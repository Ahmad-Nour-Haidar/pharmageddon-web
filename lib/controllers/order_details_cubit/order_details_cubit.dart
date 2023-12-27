import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_text.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/order_data.dart';
import '../../model/order_details_model.dart';
import '../../model/order_model.dart';
import 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit() : super(OrderDetailsInitialState());

  static OrderDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final _orderRemoteData = AppInjection.getIt<OrderRemoteData>();
  final List<OrderDetailsModel> data = [];
  var model = OrderModel();

  void _update(OrderDetailsState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial(OrderModel model) async {
    this.model = model;
    getDetails();
  }

  Future<void> getDetails() async {
    _update(OrderGetDetailsLoadingState());
    final queryParameters = {AppRKeys.id: model.id};
    final response = await _orderRemoteData.getOrderDetails(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 200) {
        final List temp =
            r[AppRKeys.data][AppRKeys.order][AppRKeys.order_details];
        data.clear();
        data.addAll(temp.map((e) => OrderDetailsModel.fromJson(e)));
      }
      _update(OrderGetDetailsSuccessState());
    });
  }

  Future<void> cancelOrder() async {
    _update(OrderDetailsCancelLoadingState());
    final queryParameters = {AppRKeys.id: model.id};
    final response = await _orderRemoteData.cancelOrder(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 403) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderNotFound.tr,
        )));
      } else if (status == 405) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.thisOrderHasCanceledBefore.tr,
        )));
      } else if (status == 406) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderHasBeenSentSoYouCannotCancelIt.tr,
        )));
      } else if (status == 408) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderHasReceivedSoYouCannotCancelIt.tr,
        )));
      } else if (status == 200) {
        _updateOrder(r);
        _update(OrderDetailsCancelSuccessState());
      }
    });
  }

  /// has_been_sent, preparing, received
  Future<void> updateOrderStatus(String status) async {
    _update(OrderUpdateStatusLoadingState());
    final data = {
      AppRKeys.id: model.id,
      AppRKeys.order_status: status,
    };
    final response = await _orderRemoteData.updateOrderStatus(data: data);
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) async {
      final status = r[AppRKeys.status];
      if (status == 403) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderNotFound.tr,
        )));
      } else if (status == 405) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.thisOrderHasAlreadyBeenCanceled.tr,
        )));
      } else if (status == 408) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.thisOrderHasAlreadyBeenReceived.tr,
        )));
      } else if (status == 200) {
        _updateOrder(r);
        _update(OrderUpdateStatusSuccessState());
      }
    });
  }

  /// 1, 0
  Future<void> updatePaymentStatus() async {
    _update(OrderUpdatePaymentStatusLadingState());
    final data = {AppRKeys.id: model.id};
    final response = await _orderRemoteData.updatePaymentStatus(data: data);
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) async {
      final status = r[AppRKeys.status];
      if (status == 403) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderNotFound.tr,
        )));
      } else if (status == 404) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.orderHasBeenPaidBeforeSoYouCannotEditIt.tr,
        )));
      } else if (status == 405) {
        _update(OrderDetailsFailureState(FailureState(
          message: AppText.thisOrderHasAlreadyBeenCanceled.tr,
        )));
      } else if (status == 200) {
        _updateOrder(r);
        _update(OrderUpdatePaymentStatusSuccessState());
      }
    });
  }

  void _updateOrder(Map response) {
    final json = response[AppRKeys.data][AppRKeys.order];
    model = OrderModel.fromJson(json);
  }
}

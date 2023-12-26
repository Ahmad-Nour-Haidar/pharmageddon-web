import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/print.dart';
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
    printme.yellow(isClosed);
    if (isClosed) return;
    emit(state);
  }

  void initial(OrderModel model) async {
    printme.magenta(this.model.id);
    printme.magenta(model.id);
    this.model = model;
    _update(OrderDetailsSuccessState());
    getDetails();
  }

  Future<void> getDetails() async {
    _update(OrderDetailsGetLoadingState());
    final queryParameters = {
      AppRKeys.id: model.id,
    };
    final response = await _orderRemoteData.getOrderDetails(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(OrderDetailsFailureState(l));
    }, (r) {
      final List temp =
          r[AppRKeys.data][AppRKeys.order][AppRKeys.order_details];
      data.clear();
      data.addAll(temp.map((e) => OrderDetailsModel.fromJson(e)));
      printme.cyan(model.id);
      printme.cyan(data.length);
      _update(OrderDetailsSuccessState());
    });
  }

  Future<void> cancelOrder() async {
    _update(OrderDetailsLoadingCancelState());
    final queryParameters = {
      AppRKeys.id: model.id,
    };
    final response =
        await _orderRemoteData.cancelOrder(queryParameters: queryParameters);
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
        _update(OrderDetailsSuccessCancelState());
      }
    });
  }

  Future<void> updateOrderStatus(String status) async {
    _update(OrderDetailsUpdateOrderLoadingState());
    final requestData = {
      AppRKeys.id: model.id,
      AppRKeys.order_status: status,
    };
    final response =
        await _orderRemoteData.updateOrderStatus(data: requestData);
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
        _update(OrderDetailsUpdateStatusOrderSuccessState());
      }
    });
  }
}

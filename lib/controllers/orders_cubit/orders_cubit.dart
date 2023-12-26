import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/core/constant/app_link.dart';
import 'package:pharmageddon_web/print.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/enums/drawer_enum.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/order_data.dart';
import '../../model/order_model.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(BuildContext context) => BlocProvider.of(context);
  final _orderRemoteData = AppInjection.getIt<OrderRemoteData>();
  final List<OrderModel> data = [];

  void _update(OrdersState state) {
    if (isClosed) return;
    emit(state);
  }

  var lastScreen = ScreenView.all;

  void getData(ScreenView screenView, {bool forceGat = false}) {
    if (lastScreen == screenView && !forceGat) return;
    lastScreen = screenView;
    printme.green(lastScreen);
    _update(OrdersLoadingState());
    _orderRemoteData.getOrders(url: _getUrl(screenView)).then((response) {
      response.fold((l) {
        _update(OrdersFailureState(l));
      }, (r) {
        final status = r[AppRKeys.status];
        if (status == 403) {
          data.clear();
        } else if (status == 200) {
          final List temp = r[AppRKeys.data][AppRKeys.orders];
          data.clear();
          data.addAll(temp.map((e) => OrderModel.fromJson(e)));
        }
        _update(OrdersSuccessState());
      });
    }).catchError((e) {});
  }

  int get totalQuantity {
    int q = 0;
    for (final element in data) {
      q += element.totalQuantity!;
    }
    return q;
  }

  double get totalPrice {
    double p = 0.0;
    for (final element in data) {
      p += element.totalPrice!;
    }
    return p;
  }

  String _getUrl(ScreenView screenView) {
    if (screenView == ScreenView.preparing) {
      return AppLink.orderGetAllPreparing;
    }
    if (screenView == ScreenView.hasBeenSent) {
      return AppLink.orderGetAllSent;
    }
    if (screenView == ScreenView.received) {
      return AppLink.orderGetAllReceived;
    }
    if (screenView == ScreenView.paid) {
      return AppLink.orderGetAllPaid;
    }
    return AppLink.orderGetAllUnpaid;
  }

  // this to show details of list of orders
  final List<OrderModel?> showingOrders = [null, null];

  void showOrder(OrderModel model) {
    if (showingOrders[0]?.id == model.id) return;
    if (showingOrders[1]?.id == model.id) return;
    if (showingOrders[0] == null) {
      showingOrders[0] = model;
      _update(OrdersChangeState());
      return;
    } else if (showingOrders[1] == null) {
      showingOrders[1] = model;
      _update(OrdersChangeState());
    }
  }

  void closeModel(int index) {
    showingOrders[index] = null;
    _update(OrdersChangeState());
  }
}

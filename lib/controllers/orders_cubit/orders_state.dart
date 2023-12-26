import '../../core/class/parent_state.dart';

abstract class OrdersState {}

class OrdersInitialState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersSuccessState extends OrdersState {}

class OrdersFailureState extends OrdersState {
  final ParentState state;

  OrdersFailureState(this.state);
}

class OrdersChangeState extends OrdersState {}

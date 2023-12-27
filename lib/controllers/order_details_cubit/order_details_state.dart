import '../../core/class/parent_state.dart';

abstract class OrderDetailsState {}

class OrderDetailsInitialState extends OrderDetailsState {}

class OrderDetailsFailureState extends OrderDetailsState {
  final ParentState state;

  OrderDetailsFailureState(this.state);
}

// change
class OrderDetailsChangeState extends OrderDetailsState {}

// get details
class OrderGetDetailsLoadingState extends OrderDetailsState {}

class OrderGetDetailsSuccessState extends OrderDetailsState {}

// cancel
class OrderDetailsCancelLoadingState extends OrderDetailsState {}

class OrderDetailsCancelSuccessState extends OrderDetailsState {}

// update order status
class OrderUpdateStatusLoadingState extends OrderDetailsState {}

class OrderUpdateStatusSuccessState extends OrderDetailsState {}

// update order payment status

class OrderUpdatePaymentStatusLadingState extends OrderDetailsState {}

class OrderUpdatePaymentStatusSuccessState extends OrderDetailsState {}

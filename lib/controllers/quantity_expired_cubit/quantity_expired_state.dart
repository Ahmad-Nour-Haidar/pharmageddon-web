import '../../core/class/parent_state.dart';

abstract class QuantityExpiredState {}

class QuantityExpiredInitialState extends QuantityExpiredState {}

class QuantityExpiredLoadingState extends QuantityExpiredState {}

class QuantityExpiredSuccessState extends QuantityExpiredState {}

class QuantityExpiredChangeState extends QuantityExpiredState {}

class QuantityExpiredFailureState extends QuantityExpiredState {
  final ParentState state;

  QuantityExpiredFailureState(this.state);
}

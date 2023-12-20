import '../../core/class/parent_state.dart';

abstract class DiscountsState {}

class DiscountsInitialState extends DiscountsState {}

class DiscountsLoadingState extends DiscountsState {}

class DiscountsSuccessState extends DiscountsState {}

class DiscountsFailureState extends DiscountsState {
  final ParentState state;

  DiscountsFailureState(this.state);
}

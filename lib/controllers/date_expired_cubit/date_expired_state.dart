import '../../core/class/parent_state.dart';

abstract class DateExpiredState {}

class DateExpiredInitialState extends DateExpiredState {}

class DateExpiredLoadingState extends DateExpiredState {}

class DateExpiredSuccessState extends DateExpiredState {}

class DateExpiredChangeState extends DateExpiredState {}

class DateExpiredFailureState extends DateExpiredState {
  final ParentState state;

  DateExpiredFailureState(this.state);
}

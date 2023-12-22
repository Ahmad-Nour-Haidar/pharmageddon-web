import '../../core/class/parent_state.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchChangeState extends SearchState {}

class SearchSuccessState extends SearchState {}

class SearchNoDataState extends SearchState {}

class SearchFailureState extends SearchState {
  final ParentState state;

  SearchFailureState(this.state);
}

import '../../core/class/parent_state.dart';

abstract class ManufacturerState {}

class ManufacturerInitialState extends ManufacturerState {}

class ManufacturerLoadingState extends ManufacturerState {}

class ManufacturerSuccessState extends ManufacturerState {}

class ManufacturerFailureState extends ManufacturerState {
  final ParentState state;

  ManufacturerFailureState(this.state);
}

class ManufacturerChangeState extends ManufacturerState {}

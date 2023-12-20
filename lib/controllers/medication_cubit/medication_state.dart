import '../../core/class/parent_state.dart';

abstract class MedicationState {}

class MedicationInitialState extends MedicationState {}

class MedicationLoadingState extends MedicationState {}

class MedicationSuccessState extends MedicationState {
}

class MedicationFailureState extends MedicationState {
  final ParentState state;

  MedicationFailureState(this.state);
}

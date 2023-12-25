import 'package:pharmageddon_web/core/class/parent_state.dart';

abstract class AddState {}

class AddInitialState extends AddState {}

class AddFailureState extends AddState {
  final ParentState state;

  AddFailureState(this.state);
}

/// Manufacturer
// get
class AddGetManufacturerLoadingState extends AddState {}

class AddGetManufacturerSuccessState extends AddState {}
// add

class AddManufacturerLoadingState extends AddState {}

class AddManufacturerSuccessState extends AddState {}

/// EffectCategory
// get
class AddGetEffectCategoryLoadingState extends AddState {}

class AddGetEffectCategorySuccessState extends AddState {}

// add
class AddEffectCategoryLoadingState extends AddState {}

class AddEffectCategorySuccessState extends AddState {}

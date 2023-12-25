import '../../core/class/parent_state.dart';

abstract class EffectCategoryState {}

class EffectCategoryInitialState extends EffectCategoryState {}

class EffectCategoryLoadingState extends EffectCategoryState {}

class EffectCategorySuccessState extends EffectCategoryState {}

class EffectCategoryFailureState extends EffectCategoryState {
  final ParentState state;

  EffectCategoryFailureState(this.state);
}

class EffectCategoryChangeState extends EffectCategoryState {}

class EffectCategoryEditLoadingState extends EffectCategoryState {}

class EffectCategoryEditSuccessState extends EffectCategoryState {
  final ParentState state;

  EffectCategoryEditSuccessState(this.state);
}

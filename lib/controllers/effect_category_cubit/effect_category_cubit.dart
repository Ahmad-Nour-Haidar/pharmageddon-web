import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/class/parent_state.dart';
import 'package:pharmageddon_web/core/constant/app_link.dart';
import 'package:pharmageddon_web/core/functions/check_errors.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';

import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_text.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/effect_categories_data.dart';
import '../../model/effect_category_model.dart';
import 'effect_category_state.dart';

class EffectCategoryCubit extends Cubit<EffectCategoryState> {
  EffectCategoryCubit() : super(EffectCategoryInitialState());

  static EffectCategoryCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final _effectCategoryRemoteData =
      AppInjection.getIt<EffectCategoryRemoteData>();
  final List<EffectCategoryModel> data = [];

  void _update(EffectCategoryState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getData();
  }

  Future<void> getData() async {
    _update(EffectCategoryLoadingState());
    final response = await _effectCategoryRemoteData.getEffectsCategories(
      url: AppLink.effectCategoriesGetAll,
    );
    response.fold((l) {
      _update(EffectCategoryFailureState(l));
    }, (r) {
      // printme.printFullText(r);
      final status = r[AppRKeys.status];
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.effect_categories];
        data.clear();
        data.addAll(temp.map((e) => EffectCategoryModel.fromJson(e)));
      }
      _update(EffectCategorySuccessState());
    });
  }

  Future<void> updateEffectCategory(
    Map<String, Object?> data,
    File? file,
  ) async {
    _update(EffectCategoryEditLoadingState());
    final response = await _effectCategoryRemoteData.updateEffectCategory(
      data: data,
      file: file,
    );
    response.fold((l) {
      _update(EffectCategoryFailureState(l));
    }, (r) {
      // printme.printFullText(r);
      final status = r[AppRKeys.status];
      if (status == 403) {
        _update(EffectCategoryFailureState(
            FailureState(message: AppText.effectCategoryNotFound.tr)));
      } else if (status == 400) {
        final errors = r[AppRKeys.message][AppRKeys.validation_errors];
        final s = checkErrorMessages(errors);
        _update(EffectCategoryFailureState(WarningState(message: s)));
      } else if (status == 200) {
        showDetailsEffectCategoryModel = false;
        final json = r[AppRKeys.data][AppRKeys.effect_category];
        effectCategoryModel = EffectCategoryModel.fromJson(json);
        _update(EffectCategoryEditSuccessState(
            SuccessState(message: AppText.updatedSuccessfully.tr)));
        getData();
      }
    });
  }

  // this to show medicines model
  bool showMedicinesEffectCategoryModel = false;
  var effectCategoryModel = EffectCategoryModel();

  String get getUrlMedicinesModel {
    return buildUrl(
      baseUrl: AppLink.effectCategoriesGetAllMedicines,
      queryParameters: {AppRKeys.id: effectCategoryModel.id},
    );
  }

  void showMedicinesOfModel(EffectCategoryModel model) {
    effectCategoryModel = model;
    showMedicinesEffectCategoryModel = true;
    _update(EffectCategoryChangeState());
  }

  // this to edit model
  bool showDetailsEffectCategoryModel = false;

  void showDetailsModel(EffectCategoryModel model) {
    effectCategoryModel = model;
    showDetailsEffectCategoryModel = true;
    _update(EffectCategoryChangeState());
  }

  void closeDetailsModel() {
    showDetailsEffectCategoryModel = false;
    _update(EffectCategoryChangeState());
  }
}

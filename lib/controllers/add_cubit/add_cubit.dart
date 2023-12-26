import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/add_cubit/add_state.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/data/remote/effect_categories_data.dart';
import 'package:pharmageddon_web/data/remote/manufacturer_data.dart';
import 'package:pharmageddon_web/data/remote/medications_data.dart';
import 'package:pharmageddon_web/model/effect_category_model.dart';
import 'package:pharmageddon_web/model/manufacturer_model.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_text.dart';
import '../../core/functions/check_errors.dart';
import '../../view/widgets/custom_menu.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitialState());

  static AddCubit get(BuildContext context) => BlocProvider.of(context);
  final _manufacturerRemoteData = AppInjection.getIt<ManufacturerRemoteData>();
  final _medicationsRemoteData = AppInjection.getIt<MedicationsRemoteData>();
  final _effectCategoryRemoteData =
      AppInjection.getIt<EffectCategoryRemoteData>();

  void _update(AddState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getDataEffectCategory();
    getDataManufacturer();
  }

  Future<void> createManufacturer(Map<String, String> data) async {
    _update(AddManufacturerLoadingState());
    _manufacturerRemoteData.createManufacturer(data: data).then((response) {
      response.fold((l) {
        _update(AddFailureState(l));
      }, (r) {
        // printme.printFullText(r);
        final status = r[AppRKeys.status];
        if (status == 400) {
          final errors = r[AppRKeys.message][AppRKeys.validation_errors];
          final s = checkErrorMessages(errors);
          _update(AddFailureState(WarningState(message: s)));
        } else if (status == 200) {
          _update(AddSuccessState(AppText.manufacturerAddedSuccessfully.tr));
        }
      });
    }).catchError((e) {});
  }

  Future<void> createMedication(Map<String, Object?> data, File? file) async {
    _update(AddAddMedicationLoadingState());
    final response = await _medicationsRemoteData.createMedication(
      data: data,
      file: file,
    );
    response.fold((l) {
      _update(AddFailureState(l));
    }, (r) {
      // printme.printFullText(r);
      final status = r[AppRKeys.status];
      if (status == 400) {
        final s =
            checkErrorMessages(r[AppRKeys.message][AppRKeys.validation_errors]);
        _update(AddFailureState(WarningState(message: s)));
      } else if (status == 405) {
        _update(AddFailureState(FailureState()));
      } else if (status == 403) {
        _update(AddFailureState(FailureState(
            message: AppText.effectCategoryOrManufacturerNotFound.tr)));
      } else if (status == 200) {
        _update(AddSuccessState(AppText.medicationAddedSuccessfully.tr));
      }
    });
  }

  /// this used to add medicine
  // all available effect categories
  final List<EffectCategoryModel> effectCategories = [];

  List<PopupMenuItemModel> get effectCategoriesData {
    return List.generate(
      effectCategories.length,
      (index) => PopupMenuItemModel(
        getEffectCategoryModelName(effectCategories[index], split: false),
        effectCategories[index].id.toString(),
      ),
    );
  }

  Future<void> getDataEffectCategory({bool forceGet = false}) async {
    if (effectCategories.isNotEmpty && !forceGet) return;
    _update(AddEffectCategoryLoadingState());
    _effectCategoryRemoteData
        .getEffectsCategories(
      url: AppLink.effectCategoriesGetAllM,
    )
        .then((response) {
      response.fold((l) {
        _update(AddFailureState(l));
      }, (r) {
        // printme.printFullText(r);
        final status = r[AppRKeys.status];
        if (status == 200) {
          final List temp = r[AppRKeys.data][AppRKeys.effect_categories];
          effectCategories.clear();
          effectCategories
              .addAll(temp.map((e) => EffectCategoryModel.fromJson(e)));
        }
        _update(AddGetEffectCategorySuccessState());
      });
    }).catchError((e) {});
  }

  // all available manufacturers
  final List<ManufacturerModel> manufacturers = [];

  List<PopupMenuItemModel> get manufacturersData {
    return List.generate(
      manufacturers.length,
      (index) => PopupMenuItemModel(
        getManufacturerName(manufacturers[index], split: false),
        manufacturers[index].id.toString(),
      ),
    );
  }

  Future<void> getDataManufacturer({bool forceGet = false}) async {
    if (manufacturers.isNotEmpty && !forceGet) return;
    _update(AddGetManufacturerLoadingState());
    _manufacturerRemoteData
        .getManufacturers(
      url: AppLink.manufacturerGetAll,
    )
        .then((response) {
      response.fold((l) {
        _update(AddFailureState(l));
      }, (r) {
        // printme.printFullText(r);
        final status = r[AppRKeys.status];
        if (status == 200) {
          final List temp = r[AppRKeys.data][AppRKeys.manufacturers];
          manufacturers.clear();
          manufacturers.addAll(temp.map((e) => ManufacturerModel.fromJson(e)));
        }
        _update(AddGetManufacturerSuccessState());
      });
    }).catchError((e) {});
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/controllers/add_cubit/add_state.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/data/remote/effect_categories_data.dart';
import 'package:pharmageddon_web/data/remote/manufacturer_data.dart';
import 'package:pharmageddon_web/data/remote/medications_data.dart';
import 'package:pharmageddon_web/model/effect_category_model.dart';
import 'package:pharmageddon_web/model/manufacturer_model.dart';

import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_link.dart';

class AddCubit extends Cubit<AddState> {
  AddCubit() : super(AddInitialState());

  static AddCubit get(BuildContext context) => BlocProvider.of(context);
  final _manufacturerRemoteData = AppInjection.getIt<ManufacturerRemoteData>();
  final _medicationsRemoteData = AppInjection.getIt<MedicationsRemoteData>();
  final _effectCategoryRemoteData =
      AppInjection.getIt<EffectCategoryRemoteData>();

  final List<ManufacturerModel> manufacturers = [];
  final List<EffectCategoryModel> effectCategories = [];

  void _update(AddState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getDataEffectCategory();
    getDataManufacturer();
  }

  Future<void> getDataEffectCategory() async {
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

  Future<void> getDataManufacturer() async {
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

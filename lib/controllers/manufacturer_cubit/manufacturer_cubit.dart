import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/class/parent_state.dart';
import 'package:pharmageddon_web/core/constant/app_link.dart';
import 'package:pharmageddon_web/core/functions/check_errors.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/model/manufacturer_model.dart';

import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_text.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/manufacturer_data.dart';
import 'manufacturer_state.dart';

class ManufacturerCubit extends Cubit<ManufacturerState> {
  ManufacturerCubit() : super(ManufacturerInitialState());

  static ManufacturerCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final _manufacturerRemoteData = AppInjection.getIt<ManufacturerRemoteData>();
  final List<ManufacturerModel> manufacturers = [];

  void _update(ManufacturerState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getData();
  }

  Future<void> getData() async {
    _update(ManufacturerLoadingState());
    final response = await _manufacturerRemoteData.getManufacturers(
      url: AppLink.manufacturerGetAll,
    );
    response.fold((l) {
      _update(ManufacturerFailureState(l));
    }, (r) {
      // printme.printFullText(r);
      final status = r[AppRKeys.status];
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.manufacturers];
        manufacturers.clear();
        manufacturers.addAll(temp.map((e) => ManufacturerModel.fromJson(e)));
      }
      _update(ManufacturerSuccessState());
    });
  }

  Future<void> updateManufacturer(Map<String, String> data) async {
    _update(ManufacturerEditLoadingState());
    _manufacturerRemoteData.updateManufacturers(data: data).then((response) {
      response.fold((l) {
        _update(ManufacturerFailureState(l));
      }, (r) {
        // printme.printFullText(r);
        final status = r[AppRKeys.status];
        if (status == 403) {
          _update(ManufacturerFailureState(
              FailureState(message: AppText.manufacturerNotFound.tr)));
        } else if (status == 400) {
          final errors = r[AppRKeys.message][AppRKeys.validation_errors];
          final s = checkErrorMessages(errors);
          _update(ManufacturerFailureState(WarningState(message: s)));
        } else if (status == 200) {
          showDetailsManufacturerModel = false;
          final json = r[AppRKeys.data][AppRKeys.manufacturer];
          manufacturerModel = ManufacturerModel.fromJson(json);
          _update(ManufacturerEditSuccessState(
              SuccessState(message: AppText.updatedSuccessfully.tr)));
          getData();
        }
      });
    }).catchError((e) {});
  }

  // this to show medicines model
  bool showMedicinesManufacturerModel = false;
  late ManufacturerModel manufacturerModel;

  String get getUrlMedicinesModel {
    return buildUrl(
      baseUrl: AppLink.manufacturerGetAllMedicines,
      queryParameters: {AppRKeys.id: manufacturerModel.id},
    );
  }

  void showMedicinesOfModel(ManufacturerModel model) {
    manufacturerModel = model;
    showMedicinesManufacturerModel = true;
    _update(ManufacturerChangeState());
  }

  // this to edit model
  bool showDetailsManufacturerModel = false;

  void showDetailsModel(ManufacturerModel model) {
    manufacturerModel = model;
    showDetailsManufacturerModel = true;
    _update(ManufacturerChangeState());
  }

  void closeDetailsModel() {
    showDetailsManufacturerModel = false;
    _update(ManufacturerChangeState());
  }
}

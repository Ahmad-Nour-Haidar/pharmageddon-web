import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/class/parent_state.dart';
import 'package:pharmageddon_web/core/constant/app_keys_request.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/print.dart';
import '../../core/functions/check_errors.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/home_data.dart';
import '../../model/medication_model.dart';
import 'medication_details_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  MedicationDetailsCubit() : super(MedicationDetailsInitialState());

  static MedicationDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final _medicationsRemoteData = AppInjection.getIt<MedicationsRemoteData>();
  late MedicationModel model;

  void _update(MedicationDetailsState state) {
    if (isClosed) return;

    emit(state);
  }

  void initial(MedicationModel m) {
    model = m;
    _update(MedicationDetailsChangeState());
  }

  var enableEdit = false;

  void onTapEdit() {
    enableEdit = !enableEdit;
    _update(MedicationDetailsChangeState());
  }

  Future<void> updateMedication(Map<String, Object?> data) async {
    data[AppRKeys.id] = model.id;
    printme.blue(data);
    File? file;
    if (data[AppRKeys.image] != null) {
      file = data[AppRKeys.image] as File;
    }
    final response = await _medicationsRemoteData.updateMedication(
      data: data,
      file: file,
    );
    response.fold((l) {
      _update(MedicationDetailsFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      if (status == 400) {
        var s =
            checkErrorMessages(r[AppRKeys.message][AppRKeys.validation_errors]);
        s = '${AppText.field.tr} $s ${AppText.alreadyBeenTaken.tr}';
        _update(MedicationDetailsFailureState(WarningState(message: s)));
      } else if (status == 403) {
        _update(MedicationDetailsFailureState(FailureState(
            message: AppText.medicineNotFoundOrHasBeenDeleted.tr)));
      } else if (status == 200) {
        model = MedicationModel.fromJson(r[AppRKeys.data][AppRKeys.medicine]);
        _update(MedicationDetailsSuccessState(
            SuccessState(message: AppText.updatedSuccessfully.tr)));
      }
    });
  }
}

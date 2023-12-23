import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/data/remote/home_data.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/medication_model.dart';
import '../medication_details_cubit/medication_details_cubit.dart';
import 'medication_state.dart';

class MedicationCubit extends Cubit<MedicationState> {
  MedicationCubit() : super(MedicationInitialState());

  static MedicationCubit get(BuildContext context) => BlocProvider.of(context);
  final _medicationsRemoteData = AppInjection.getIt<MedicationsRemoteData>();
  final List<MedicationModel> medications = [];

  void _update(MedicationState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getData();
  }

  Future<void> getData() async {
    // showMedicationModelDetails = false;
    _update(MedicationLoadingState());
    final response = await _medicationsRemoteData.getMedications();
    response.fold((l) {
      _update(MedicationFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.medicines];
      medications.clear();
      medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      _update(MedicationSuccessState());
    });
  }

  bool showMedicationModelDetails = false;
  late MedicationModel medicationModel;

  void showDetailsModel(MedicationModel model) {
    medicationModel = model;
    showMedicationModelDetails = true;
    _update(MedicationChangeState());
  }

  void closeDetailsModel() {
    showMedicationModelDetails = false;
    AppInjection.getIt<MedicationDetailsCubit>().enableEdit = false;
    _update(MedicationChangeState());
  }
}

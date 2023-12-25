import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/data/remote/medications_data.dart';
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

  Future<void> initial(String url) async {
    getData(url);
  }

  var lastUrl = '';

  Future<void> getData(String url) async {
    if (lastUrl == url) return;
    lastUrl = url;
    showMedicationModelDetails = false;
    _update(MedicationLoadingState());
    _medicationsRemoteData.getMedications(url: url).then((response) {
      response.fold((l) {
        _update(MedicationFailureState(l));
      }, (r) {
        final status = r[AppRKeys.status];
        if (status == 200) {
          medications.clear();
          final List temp = r[AppRKeys.data][AppRKeys.medicines];
          medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
          _update(MedicationSuccessState());
        }
      });
    }).catchError((e) {});
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

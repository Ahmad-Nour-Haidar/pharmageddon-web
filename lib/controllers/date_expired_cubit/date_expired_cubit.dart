import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/data/remote/medications_data.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/medication_model.dart';
import '../medication_details_cubit/medication_details_cubit.dart';
import 'date_expired_state.dart';

class DateExpiredCubit extends Cubit<DateExpiredState> {
  DateExpiredCubit() : super(DateExpiredInitialState());

  static DateExpiredCubit get(BuildContext context) => BlocProvider.of(context);
  final _medicationsRemoteData = AppInjection.getIt<MedicationsRemoteData>();
  final List<MedicationModel> medications = [];

  void _update(DateExpiredState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getData();
  }

  Future<void> getData() async {
    _update(DateExpiredLoadingState());
    final response = await _medicationsRemoteData.getAllDateExpired();
    response.fold((l) {
      _update(DateExpiredFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      medications.clear();
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.medicines];
        medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      }
      _update(DateExpiredSuccessState());
    });
  }

  bool showMedicationModelDetails = false;
  late MedicationModel medicationModel;

  void showDetailsModel(MedicationModel model) {
    medicationModel = model;
    showMedicationModelDetails = true;
    _update(DateExpiredChangeState());
  }

  void closeDetailsModel() {
    showMedicationModelDetails = false;
    AppInjection.getIt<MedicationDetailsCubit>().enableEdit = false;
    _update(DateExpiredChangeState());
  }
}

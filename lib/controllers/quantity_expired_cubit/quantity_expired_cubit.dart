import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/controllers/quantity_expired_cubit/quantity_expired_state.dart';
import 'package:pharmageddon_web/data/remote/home_data.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/medication_model.dart';
import '../medication_details_cubit/medication_details_cubit.dart';

class QuantityExpiredCubit extends Cubit<QuantityExpiredState> {
  QuantityExpiredCubit() : super(QuantityExpiredInitialState());

  static QuantityExpiredCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final _medicationsRemoteData = AppInjection.getIt<MedicationsRemoteData>();
  final List<MedicationModel> medications = [];

  void _update(QuantityExpiredState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getData();
  }

  Future<void> getData() async {
    _update(QuantityExpiredLoadingState());
    final response = await _medicationsRemoteData.getQuantityExpired();
    response.fold((l) {
      _update(QuantityExpiredFailureState(l));
    }, (r) {
      final status = r[AppRKeys.status];
      medications.clear();
      if (status == 200) {
        final List temp = r[AppRKeys.data][AppRKeys.medicines];
        medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      }
      _update(QuantityExpiredSuccessState());
    });
  }

  bool showMedicationModelDetails = false;
  late MedicationModel medicationModel;

  void showDetailsModel(MedicationModel model) {
    medicationModel = model;
    showMedicationModelDetails = true;
    _update(QuantityExpiredChangeState());
  }

  void closeDetailsModel() {
    showMedicationModelDetails = false;
    AppInjection.getIt<MedicationDetailsCubit>().enableEdit = false;
    _update(QuantityExpiredChangeState());
  }
}

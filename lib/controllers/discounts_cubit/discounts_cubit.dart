import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/data/remote/home_data.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/services/dependency_injection.dart';
import '../../model/medication_model.dart';
import 'discounts_state.dart';

class DiscountsCubit extends Cubit<DiscountsState> {
  DiscountsCubit() : super(DiscountsInitialState());

  static DiscountsCubit get(BuildContext context) => BlocProvider.of(context);
  final _homeRemoteData = AppInjection.getIt<MedicationsRemoteData>();
  final List<MedicationModel> medications = [];

  void _update(DiscountsState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial() {
    getData();
  }

  Future<void> getData() async {
    _update(DiscountsLoadingState());
    final response = await _homeRemoteData.getDiscount();
    response.fold((l) {
      _update(DiscountsFailureState(l));
    }, (r) {
      final List temp = r[AppRKeys.data][AppRKeys.medicines];
      medications.clear();
      medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      _update(DiscountsSuccessState());
    });
  }

  bool showMedicationModelDetails = false;
  late MedicationModel medicationModel;

  void showDetailsModel(MedicationModel model) {
    medicationModel = model;
    showMedicationModelDetails = true;
    _update(DiscountsChangeState());
  }

  void closeDetailsModel() {
    showMedicationModelDetails = false;
    _update(DiscountsChangeState());
  }
}

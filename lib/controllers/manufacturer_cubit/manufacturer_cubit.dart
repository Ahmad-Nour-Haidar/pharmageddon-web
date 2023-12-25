import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/core/constant/app_link.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/model/manufacturer_model.dart';

import '../../core/constant/app_keys_request.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/manufacturer_data.dart';
import '../medication_details_cubit/medication_details_cubit.dart';
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

  bool showManufacturerModelDetails = false;
  late ManufacturerModel manufacturerModel;

  String get getUrl {
    return buildUrl(
      baseUrl: AppLink.manufacturerGetAllMedicines,
      queryParameters: {AppRKeys.id: manufacturerModel.id},
    );
  }

  void showDetailsModel(ManufacturerModel model) {
    manufacturerModel = model;
    showManufacturerModelDetails = true;
    _update(ManufacturerChangeState());
  }

  void closeDetailsModel() {
    showManufacturerModelDetails = false;
    AppInjection.getIt<MedicationDetailsCubit>().enableEdit = false;
    _update(ManufacturerChangeState());
  }
}

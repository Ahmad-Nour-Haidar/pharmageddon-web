import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/search_data.dart';
import '../../model/medication_model.dart';
import '../medication_details_cubit/medication_details_cubit.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(BuildContext context) => BlocProvider.of(context);
  final _searchRemoteData = AppInjection.getIt<SearchRemoteData>();
  final List<MedicationModel> medications = [];

  void _update(SearchState state) {
    if (isClosed) return;
    emit(state);
  }

  void initial(String value) {
    search(value);
  }

  var valueSearch = '';
  Future<void> search(String value) async {
    _update(SearchLoadingState());
    final queryParameters = {AppRKeys.q: value};
    final response = await _searchRemoteData.search(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(SearchFailureState(l));
    }, (r) {
      valueSearch = value;
      if (r[AppRKeys.status] == 403) {
        _update(SearchNoDataState());
        return;
      }
      final List temp = r[AppRKeys.data][AppRKeys.medicines];
      medications.clear();
      medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      if (medications.isEmpty) {
        _update(SearchNoDataState());
      } else {
        _update(SearchSuccessState());
      }
    });
  }

  bool showMedicationModelDetails = false;
  late MedicationModel medicationModel;

  void showDetailsModel(MedicationModel model) {
    medicationModel = model;
    showMedicationModelDetails = true;
    _update(SearchChangeState());
  }

  void closeDetailsModel() {
    showMedicationModelDetails = false;
    AppInjection.getIt<MedicationDetailsCubit>().enableEdit = false;
    _update(SearchChangeState());
  }
}

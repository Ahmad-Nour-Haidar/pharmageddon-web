import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/search_data.dart';
import '../../model/medication_model.dart';
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

  Future<void> search(String value) async {
    _update(SearchLoadingState());
    final queryParameters = {AppRKeys.q: value};
    final response = await _searchRemoteData.search(
      queryParameters: queryParameters,
    );
    response.fold((l) {
      _update(SearchFailureState(l));
    }, (r) {
      if (r[AppRKeys.status] == 403) {
        _update(SearchNoDataState(value));
        return;
      }
      final List temp = r[AppRKeys.data][AppRKeys.medicines];
      medications.clear();
      medications.addAll(temp.map((e) => MedicationModel.fromJson(e)));
      if (medications.isEmpty) {
        _update(SearchNoDataState(value));
      } else {
        _update(SearchSuccessState(value));
      }
    });
  }
}

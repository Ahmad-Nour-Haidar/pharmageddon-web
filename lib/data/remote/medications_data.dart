import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pharmageddon_web/core/constant/app_keys_request.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';
import '../crud_http.dart';

class MedicationsRemoteData {
  final _crudDio = AppInjection.getIt<CrudDio>();
  final _crudHttp = AppInjection.getIt<CrudHttp>();

  Future<Either<ParentState, Map<String, dynamic>>> getMedications({
    required String url,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crudDio.getData(linkUrl: url, token: token);
  }

  Future<Either<ParentState, Map<String, dynamic>>> createMedication({
    required Map<String, dynamic> data,
    required File? file,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crudHttp.requestWithFile(
      linkUrl: AppLink.medicineCreate,
      token: token,
      data: data,
      file: file,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> updateMedication({
    required Map<String, dynamic> data,
    required File? file,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crudHttp.requestWithFile(
      linkUrl: AppLink.medicineUpdate,
      token: token,
      data: data,
      file: file,
      nameKey: AppRKeys.image,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> deleteMedication({
    required Map<String, dynamic> queryParameters,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crudDio.getData(
      linkUrl: AppLink.medicineDelete,
      token: token,
      queryParameters: queryParameters,
    );
  }
}

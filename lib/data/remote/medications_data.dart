import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pharmageddon_web/core/constant/app_keys_request.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class MedicationsRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> getMedications({
    String url = AppLink.medicineGetAll,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crud.getData(linkUrl: url, token: token);
  }

  Future<Either<ParentState, Map<String, dynamic>>> getDiscount() async {
    final token = AppLocalData.user?.authorization;
    return await _crud.getData(
      linkUrl: AppLink.medicineGetAllDiscount,
      token: token,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>>
      getEffectsCategories() async {
    final token = AppLocalData.user?.authorization;
    return await _crud.getData(
      linkUrl: AppLink.effectCategoriesGetAll,
      token: token,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> getManufacturers() async {
    final token = AppLocalData.user?.authorization;
    return await _crud.getData(
      linkUrl: AppLink.manufacturerGetAll,
      token: token,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> createMedication({
    required Map<String, dynamic> data,
    required File? file,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crud.requestWithFileUsingHttp(
      linkUrl: AppLink.medicineCreate,
      token: token,
      data: data,
      file: file,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> updateMedication(
      {required Map<String, dynamic> data, required File? file}) async {
    final token = AppLocalData.user?.authorization;
    return await _crud.requestWithFileUsingHttp(
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
    return await _crud.getData(
      linkUrl: AppLink.medicineDelete,
      token: token,
      queryParameters: queryParameters,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>>
      getAllQuantityExpired() async {
    final token = AppLocalData.user?.authorization;
    return await _crud.getData(
      linkUrl: AppLink.medicineGetAllQuantityExpired,
      token: token,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> getAllDateExpired() async {
    final token = AppLocalData.user?.authorization;
    return await _crud.getData(
      linkUrl: AppLink.medicineGetAllDateExpired,
      token: token,
    );
  }
}

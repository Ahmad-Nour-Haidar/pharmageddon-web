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

  Future<Either<ParentState, Map<String, dynamic>>> getMedications() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.medicineGetAll,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getDiscount() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.medicineGetAllDiscount,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>>
      getEffectsCategories() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.effectCategoriesGetAll,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getManufacturers() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.manufacturerGetAll,
      token: token,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> createMedication(
      {required Map<String, dynamic> data, required File? file}) async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.postRequestWithFile(
      linkUrl: AppLink.medicineCreate,
      token: token,
      data: data,
      file: file,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> updateMedication(
      {required Map<String, dynamic> data, required File? file}) async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.postRequestWithFile(
      linkUrl: AppLink.medicineUpdate,
      token: token,
      data: data,
      file: file,
      nameKey: AppRKeys.image,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> deleteMedication({
    required Map<String, dynamic> queryParameters,
  }) async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.medicineDelete,
      token: token,
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getQuantityExpired() async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.medicineGetAllQuantityExpired,
      token: token,
    );
    return response;
  }
}

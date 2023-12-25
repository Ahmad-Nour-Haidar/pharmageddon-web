import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';
import '../crud_http.dart';

class EffectCategoryRemoteData {
  final _crudDio = AppInjection.getIt<CrudDio>();
  final _crudHttp = AppInjection.getIt<CrudHttp>();

  Future<Either<ParentState, Map<String, dynamic>>> getEffectsCategories({
    required String url,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crudDio.getData(linkUrl: url, token: token);
  }

  Future<Either<ParentState, Map<String, dynamic>>> createEffectCategory({
    required Map<String, dynamic> data,
    required File? file,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crudHttp.requestWithFile(
      linkUrl: AppLink.effectCategoriesCreate,
      token: token,
      data: data,
      file: file,
      nameKey: AppRKeys.image,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> updateEffectCategory({
    required Map<String, dynamic> data,
    required File? file,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crudHttp.requestWithFile(
      linkUrl: AppLink.effectCategoriesUpdate,
      token: token,
      data: data,
      file: file,
      nameKey: AppRKeys.image,
    );
  }
}

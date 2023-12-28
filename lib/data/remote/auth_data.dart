import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:pharmageddon_web/data/crud_http.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_keys_request.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class AuthRemoteData {
  final _crudDio = AppInjection.getIt<CrudDio>();
  final _crudHttp = AppInjection.getIt<CrudHttp>();

  Future<Either<ParentState, Map<String, dynamic>>> login({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crudHttp.requestWithFile(
      file: null,
      data: data,
      linkUrl: AppLink.login,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> register({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crudDio.postData(
      data: data,
      linkUrl: AppLink.register,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> verify({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crudDio.postData(
      data: data,
      linkUrl: AppLink.checkVerifyCode,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> getVerificationCode({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crudDio.postData(
      data: data,
      linkUrl: AppLink.sendVerificationCode,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> checkEmail({
    required Map<String, dynamic> data,
  }) async {
    final response = await _crudDio.postData(
      data: data,
      linkUrl: AppLink.checkEmail,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> resetPassword({
    required Map<String, dynamic> data,
  }) async {
    var response = await _crudDio.postData(
      data: data,
      linkUrl: AppLink.resetPassword,
    );
    return response;
  }

  Future<Either<ParentState, Map<String, dynamic>>> update({
    required Map<String, dynamic> data,
    File? file,
  }) async {
    final token = AppLocalData.user!.authorization!;
    return await _crudHttp.requestWithFile(
      data: data,
      token: token,
      linkUrl: AppLink.updateUser,
      file: file,
      nameKey: AppRKeys.image,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> logout() async {
    final token = AppLocalData.user!.authorization!;
    var response = await _crudDio.deleteData(
      data: {},
      token: token,
      linkUrl: AppLink.logout,
    );
    return response;
  }
}

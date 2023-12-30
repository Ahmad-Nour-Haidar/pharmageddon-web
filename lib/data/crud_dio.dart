import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmageddon_web/core/class/parent_state.dart';
import 'package:pharmageddon_web/print.dart';
import '../core/functions/random_loading.dart';

class CrudDio {
  final _headers = {
    "Content-Type": "application/json",
    'Accept': 'application/json',
    'accepted-lang': 'en',
  };

  static late final Dio _dio;

  CrudDio() {
    _dio = Dio(BaseOptions(headers: _headers));
  }

  Future<Either<ParentState, Map<String, dynamic>>> postData({
    required String linkUrl,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    // if (!await checkInternet()) {
    //   return Left(OfflineState());
    // }
    if (token != null) {
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    await randomLoading();
    try {
      final response = await _dio.post(linkUrl, data: data);
      printme.cyan(response.statusCode);
      // printme.printFullText(response.data);
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        return Left(ServerFailureState());
      }
      return Right(response.data);
    } on DioException catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }

  Future<Either<ParentState, Map<String, dynamic>>> getData({
    required String linkUrl,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    // if (!await checkInternet()) {
    //   return Left(OfflineState(tr));
    // }
    if (token != null) {
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    await randomLoading();
    try {
      final response =
          await _dio.get(linkUrl, queryParameters: queryParameters);
      printme.cyan(response.statusCode);
      // printme.printFullText(response.data);
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        return Left(ServerFailureState());
      }
      return Right(response.data);
    } on DioException catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }

  Future<Either<ParentState, Map<String, dynamic>>> deleteData({
    required String linkUrl,
    required Map data,
    String? token,
  }) async {
    // if (!await checkInternet()) {
    //   return Left(OfflineState());
    // }
    if (token != null) {
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    await randomLoading();
    try {
      final response = await _dio.delete(linkUrl, data: data);
      printme.cyan(response.statusCode);
      // printme.printFullText(response.data);
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        return Left(ServerFailureState());
      }
      return Right(response.data);
    } on DioException catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }

  Future<Either<ParentState, Map<String, dynamic>>> requestWithFile({
    required String linkUrl,
    required Map<String, dynamic> data,
    required File? file,
    String nameKey = "file",
    String? token,
  }) async {
    // if (!await checkInternet()) {
    //   return Left(OfflineState(tr));
    // }
    /// add headers
    if (token != null) {
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    /// add data
    final formData = FormData.fromMap(data);

    /// add file
    if (file != null) {
      final xFile = XFile(file.path);
      final imageBytes = await xFile.readAsBytes();
      final imageFile = PickedFile(xFile.path);
      final stream = imageFile.openRead();
      final length = imageBytes.length;
      final fileName = xFile.path.split('/').last;
      final image = MultipartFile.fromStream(
        () => stream,
        length,
        filename: fileName,
      );
      formData.files.addAll({nameKey: image}.entries);
    }
    await randomLoading();

    /// send request
    try {
      final response = await _dio.post(linkUrl, data: formData);
      printme.cyan(response.statusCode);
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        return Left(ServerFailureState());
      }
      return Right(response.data);
    } on DioException catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }
}

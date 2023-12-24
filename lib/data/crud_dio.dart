import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmageddon_web/core/class/parent_state.dart';
import 'package:pharmageddon_web/print.dart';
import '../core/functions/random_loading.dart';
import 'package:http/http.dart' as http;

class Crud {
  final _headers = {
    "Content-Type": "application/json",
    "Charset": "utf-8",
    "Connection": "Keep-Alive",
    'Accept': 'application/json',
    // 'Content-Type': 'application/json',
    // 'Keep-Alive': 'timeout=5, max=50',
  };

  static late final Dio _dio;

  Crud() {
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
    if (token != null) {
      _dio.options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    final formData = FormData.fromMap(data);
    if (file != null) {
      final fileName = file.path.split('/').last;
      formData.files.addAll({
        nameKey: await MultipartFile.fromFile(file.path, filename: fileName),
      }.entries);
    }
    await randomLoading();
    try {
      final response = await _dio.post(linkUrl, data: formData);
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

  Future<Either<ParentState, Map<String, dynamic>>> requestWithFileUsingHttp({
    required String linkUrl,
    required Map<String, dynamic> data,
    required File? file,
    String nameKey = "file",
    String method = "POST",
    String? token,
  }) async {
    // if (!await checkInternet()) {
    //   return Left(OfflineState(tr));
    // }
    /// create URI : Uniform Resource Identifier
    final uri = Uri.parse(linkUrl);

    /// create request to send it
    final request = http.MultipartRequest(method, uri);

    /// add headers
    request.headers.addAll(_headers);
    if (token != null) {
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    /// add data
    data.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    /// add file
    if (file != null) {
      final xFile = XFile(file.path);
      final imageBytes = await xFile.readAsBytes();
      final imageFile = PickedFile(xFile.path);
      final stream = imageFile.openRead();
      final length = imageBytes.length;
      final fileName = imageFile.path.split('/').last;
      final multipartFile = http.MultipartFile(
        nameKey, stream, length,
        filename: fileName,
        // contentType: http_parser.MediaType('image', 'png'),
      );
      request.files.add(multipartFile);
    }
    await randomLoading();

    /// send request
    try {
      final response = await request.send();
      printme.cyan(response.statusCode);
      if (!(response.statusCode == 200 || response.statusCode == 201)) {
        return Left(ServerFailureState());
      }
      final myResponse = await http.Response.fromStream(response);
      final jsonBody = json.decode(myResponse.body);
      return Right(jsonBody);
    } catch (e) {
      printme.red(e);
      return Left(ServerFailureState());
    }
  }
}

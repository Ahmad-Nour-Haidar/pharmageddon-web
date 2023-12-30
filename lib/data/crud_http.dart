import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmageddon_web/core/class/parent_state.dart';
import 'package:pharmageddon_web/print.dart';
import '../core/functions/random_loading.dart';
import 'package:http/http.dart' as http;

class CrudHttp {
  final _headers = {
    "Content-Type": "application/json",
    'Accept': 'application/json',
    'accepted-lang': 'en',
  };

  Future<Either<ParentState, Map<String, dynamic>>> requestWithFile({
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

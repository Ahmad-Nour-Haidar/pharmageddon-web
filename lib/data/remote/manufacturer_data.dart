import 'package:dartz/dartz.dart';

import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class ManufacturerRemoteData {
  final _crud = AppInjection.getIt<CrudDio>();

  Future<Either<ParentState, Map<String, dynamic>>> createManufacturer({
    required Map<String, dynamic> data,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crud.postData(
      linkUrl: AppLink.manufacturerCreate,
      token: token,
      data: data,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> updateManufacturers({
    required Map<String, dynamic> data,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crud.postData(
      linkUrl: AppLink.manufacturerUpdate,
      token: token,
      data: data,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> getManufacturers({
    required String url,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crud.getData(
      linkUrl: url,
      token: token,
    );
  }
}

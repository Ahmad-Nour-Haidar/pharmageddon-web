import 'package:dartz/dartz.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class ReportsRemoteData {
  final _crud = AppInjection.getIt<CrudDio>();

  Future<Either<ParentState, Map<String, dynamic>>> getReports({
    required Map<String, dynamic> queryParameters,
  }) async {
    final token = AppLocalData.user?.authorization;
    final response = await _crud.getData(
      linkUrl: AppLink.report,
      token: token,
      queryParameters: queryParameters,
    );
    return response;
  }
}

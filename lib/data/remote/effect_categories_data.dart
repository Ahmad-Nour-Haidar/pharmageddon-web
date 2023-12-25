import 'package:dartz/dartz.dart';
import '../../core/class/parent_state.dart';
import '../../core/constant/app_link.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/services/dependency_injection.dart';
import '../crud_dio.dart';

class EffectCategoryRemoteData {
  final _crud = AppInjection.getIt<Crud>();

  Future<Either<ParentState, Map<String, dynamic>>> getEffectsCategories({
    required String url,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crud.getData(linkUrl: url, token: token);
  }

  Future<Either<ParentState, Map<String, dynamic>>> createEffectCategory({
    required Map<String, dynamic> data,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crud.postData(
      linkUrl: AppLink.effectCategoriesCreate,
      token: token,
      data: data,
    );
  }

  Future<Either<ParentState, Map<String, dynamic>>> updateEffectCategory({
    required Map<String, dynamic> data,
  }) async {
    final token = AppLocalData.user?.authorization;
    return await _crud.postData(
      linkUrl: AppLink.effectCategoriesUpdate,
      token: token,
      data: data,
    );
  }
}

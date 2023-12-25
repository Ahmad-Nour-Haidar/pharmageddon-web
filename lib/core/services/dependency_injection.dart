import 'package:get_it/get_it.dart';
import 'package:pharmageddon_web/data/remote/effect_categories_data.dart';
import 'package:pharmageddon_web/data/remote/order_data.dart';
import 'package:pharmageddon_web/data/remote/reports_data.dart';
import 'package:pharmageddon_web/data/remote/search_data.dart';
import 'package:pharmageddon_web/view/widgets/app_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/auth/check_email_cubit/check_email_cubit.dart';
import '../../controllers/auth/login_cubit/login_cubit.dart';
import '../../controllers/auth/register_cubit/register_cubit.dart';
import '../../controllers/auth/reset_password_cubit/reset_password_cubit.dart';
import '../../controllers/auth/verify_code_cubit/verify_code_cubit.dart';
import '../../controllers/effect_category_cubit/effect_category_cubit.dart';
import '../../controllers/home_cubit/home_cubit.dart';
import '../../controllers/local_controller.dart';
import '../../controllers/manufacturer_cubit/manufacturer_cubit.dart';
import '../../controllers/medication_cubit/medication_cubit.dart';
import '../../controllers/medication_details_cubit/medication_details_cubit.dart';
import '../../controllers/reports_cubit/reports_cubit.dart';
import '../../controllers/search_cubit/search_cubit.dart';
import '../../data/crud_dio.dart';
import '../../data/crud_http.dart';
import '../../data/remote/auth_data.dart';
import '../../data/remote/manufacturer_data.dart';
import '../../data/remote/medications_data.dart';
import '../../my_bloc_observer.dart';
import '../class/image_helper.dart';

class AppInjection {
  AppInjection._();

  static final getIt = GetIt.instance;

  static Future<void> initial() async {
    /// storage
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPreferences);
    getIt.registerLazySingleton(() => ImageHelper());

    /// start
    getIt.registerLazySingleton(() => LocaleController());
    getIt.registerLazySingleton(() => MyBlocObserver());

    /// data
    getIt.registerLazySingleton(() => CrudDio());
    getIt.registerLazySingleton(() => CrudHttp());
    getIt.registerLazySingleton(() => AuthRemoteData());

    /// controllers
    // auth
    getIt.registerFactory(() => RegisterCubit());
    getIt.registerFactory(() => LoginCubit());
    getIt.registerFactory(() => CheckEmailCubit());
    getIt.registerFactory(() => ResetPasswordCubit());
    getIt.registerFactory(() => VerifyCodeCubit());

    // home
    getIt.registerLazySingleton(() => HomeCubit());
    getIt.registerLazySingleton(() => SearchCubit());
    getIt.registerLazySingleton(() => MedicationDetailsCubit());
    getIt.registerLazySingleton(() => ManufacturerCubit());
    getIt.registerLazySingleton(() => EffectCategoryCubit());
    getIt.registerLazySingleton(() => MedicationCubit());
    getIt.registerFactory(() => ReportsCubit());

    /// data
    getIt.registerLazySingleton(() => MedicationsRemoteData());
    getIt.registerLazySingleton(() => ManufacturerRemoteData());
    getIt.registerLazySingleton(() => EffectCategoryRemoteData());
    getIt.registerLazySingleton(() => OrderRemoteData());
    getIt.registerLazySingleton(() => ReportsRemoteData());
    getIt.registerLazySingleton(() => SearchRemoteData());

    // widget
    getIt.registerLazySingleton(() => AppWidget());
  }
}

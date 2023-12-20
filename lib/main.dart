import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pharmageddon_web/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_web/controllers/search_cubit/search_cubit.dart';
import 'package:pharmageddon_web/model/user_model.dart';
import 'package:pharmageddon_web/routes.dart';
import 'controllers/discounts_cubit/discounts_cubit.dart';
import 'controllers/local_controller.dart';
import 'controllers/medication_cubit/medication_cubit.dart';
import 'core/constant/app_local_data.dart';
import 'core/constant/app_size.dart';
import 'core/functions/functions.dart';
import 'core/localization/translation.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/dependency_injection.dart';
import 'my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInjection.initial();
  initialUser();
  storeUser(user);
  Bloc.observer = AppInjection.getIt<MyBlocObserver>();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initial(context);
    final controller = AppInjection.getIt<LocaleController>();
    var initialRoute = AppRoute.home;
    if (AppLocalData.user != null && AppLocalData.user!.authorization != null) {
      // initialRoute = AppRoute.home;
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => AppInjection.getIt<HomeCubit>(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => AppInjection.getIt<SearchCubit>(),
        ),
        BlocProvider<MedicationCubit>(
          create: (context) => AppInjection.getIt<MedicationCubit>(),
        ),
        // BlocProvider<DiscountsCubit>(
        //   create: (context) => AppInjection.getIt<DiscountsCubit>(),
        // ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pharmageddon',
        locale: controller.locale,
        translations: MyTranslation(),
        theme: themeData(),
        routes: routes,
        initialRoute: initialRoute,
        // home: const RegisterScreen(),
      ),
    );
  }
}

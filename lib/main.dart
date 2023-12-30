import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pharmageddon_web/controllers/effect_category_cubit/effect_category_cubit.dart';
import 'package:pharmageddon_web/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_web/controllers/orders_cubit/orders_cubit.dart';
import 'package:pharmageddon_web/controllers/search_cubit/search_cubit.dart';
import 'package:pharmageddon_web/print.dart';
import 'package:pharmageddon_web/routes.dart';
import 'controllers/add_cubit/add_cubit.dart';
import 'controllers/local_controller.dart';
import 'controllers/manufacturer_cubit/manufacturer_cubit.dart';
import 'controllers/medication_cubit/medication_cubit.dart';
import 'controllers/medication_details_cubit/medication_details_cubit.dart';
import 'core/constant/app_constant.dart';
import 'core/constant/app_local_data.dart';
import 'core/constant/app_size.dart';
import 'core/localization/translation.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/dependency_injection.dart';
import 'my_bloc_observer.dart';

Future<void> requestPermissionNotification() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}

Future<void> init() async {
  await requestPermissionNotification();
  final topic = AppLocalData.user?.id.toString() ?? '0';
  printme.green(topic);
  await FirebaseMessaging.instance.deleteToken();
  FirebaseMessaging.instance.getToken().then((token) {
    printme.yellow('------------------');
    printme.yellow(token);
    printme.yellow('------------------');
  }).catchError((e) {});

  // await FirebaseMessaging.instance.subscribeToTopic(topic);
  // await FirebaseMessaging.instance.subscribeToTopic("all-users");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    printme.blue(message.data);
    printme.blue(message.notification?.title.toString());
    printme.blue(message.notification?.body.toString());
    printme.blue(message);
  });
}

// eRMObZyYJ2aVeJrs9_WwAD:APA91bG6MieGij1ie4sIBLtG7vC9qU0c6hrsP6y6QXWdUVV4Fx5zZ61y0JaNmHu3uXKF1zB-Y8WSC7hywF0imEa_a_6O-KEThh7m6go7zNPgvI5SLBKM9dC5Vqpdohac2OvHyt1jwQ8O

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInjection.initial();
  Bloc.observer = AppInjection.getIt<MyBlocObserver>();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initial(context);
    final controller = AppInjection.getIt<LocaleController>();
    var initialRoute = AppRoute.login;
    // if (AppLocalData.user != null && AppLocalData.user!.authorization != null) {
      initialRoute = AppRoute.home;
    // }
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => AppInjection.getIt<HomeCubit>(),
        ),
        BlocProvider<SearchCubit>(
          create: (context) => AppInjection.getIt<SearchCubit>(),
        ),
        BlocProvider<MedicationDetailsCubit>(
          create: (context) => AppInjection.getIt<MedicationDetailsCubit>(),
        ),
        BlocProvider<MedicationCubit>(
          create: (context) => AppInjection.getIt<MedicationCubit>(),
        ),
        BlocProvider<ManufacturerCubit>(
          create: (context) => AppInjection.getIt<ManufacturerCubit>(),
        ),
        BlocProvider<EffectCategoryCubit>(
          create: (context) => AppInjection.getIt<EffectCategoryCubit>(),
        ),
        BlocProvider<AddCubit>(
          create: (context) => AppInjection.getIt<AddCubit>(),
        ),
        BlocProvider<OrdersCubit>(
          create: (context) => AppInjection.getIt<OrdersCubit>(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstant.isEnglish ? 'Pharmageddon' : 'فارماجيدون',
        locale: controller.locale,
        translations: MyTranslation(),
        theme: themeData(),
        routes: routes,
        initialRoute: initialRoute,
      ),
    );
  }
}

/// flutter run -d chrome --web-renderer html // to run the app
//
// flutter build web --web-renderer html --release // to generate a production build

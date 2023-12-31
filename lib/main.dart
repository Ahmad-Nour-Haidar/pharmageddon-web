import 'package:firebase_core/firebase_core.dart';
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
import 'core/notifications/app_firebase.dart';
import 'core/resources/theme_manager.dart';
import 'core/services/dependency_injection.dart';
import 'firebase_options.dart';
import 'my_bloc_observer.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  AppFirebase.firebaseMessagingBackgroundHandler(message);
}

Future<void> _firebaseMessaging(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  AppFirebase.firebaseMessaging(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInjection.initial();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  } catch (e) {
    printme.red(e);
  }
  AppFirebase.setToken();

  FirebaseMessaging.onMessage.listen(_firebaseMessaging);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = AppInjection.getIt<MyBlocObserver>();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize.initial(context);
    final controller = AppInjection.getIt<LocaleController>();
    var initialRoute = AppRoute.login;
    if (AppLocalData.user != null && AppLocalData.user!.authorization != null) {
      initialRoute = AppRoute.home;
    }
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

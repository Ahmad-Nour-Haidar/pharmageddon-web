import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/core/constant/app_link.dart';
import 'package:pharmageddon_web/view/screens/medication_screen.dart';
import 'package:pharmageddon_web/view/screens/search_screen.dart';
import '../../core/enums/drawer_enum.dart';
import '../../view/screens/add_screen.dart';
import '../../view/screens/auth/profile_screen.dart';
import '../../view/screens/effect_category_screen.dart';
import '../../view/screens/manufacturer_screen.dart';
import '../../view/screens/orders_screen.dart';
import '../../view/screens/reports_screen.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  void _update(HomeState state) {
    if (isClosed) return;
    emit(state);
  }

  var currentScreen = ScreenView.all;

  void changeScreen(ScreenView value) {
    // if (currentScreen == value) return;
    currentScreen = value;
    _update(HomeChangeState());
  }

  var _valueForSearch = '';

  void onFieldSubmitted(String value) {
    if (value.isEmpty) return;
    _valueForSearch = value;
    currentScreen = ScreenView.search;
    _update(HomeChangeState());
  }

  Widget get screen {
    switch (currentScreen) {
      case ScreenView.manufacturer:
        return const ManufacturerScreen();
      case ScreenView.effectCategories:
        return const EffectCategoryScreen();
      case ScreenView.add:
        return const AddScreen();
      case ScreenView.reports:
        return const ReportsScreen();
      // Medication Screen
      case ScreenView.all:
        return const MedicationScreen(url: AppLink.medicineGetAll);
      case ScreenView.quantityExpired:
        return const MedicationScreen(
          url: AppLink.medicineGetAllQuantityExpired,
        );
      case ScreenView.discounts:
        return const MedicationScreen(url: AppLink.medicineGetAllDiscount);
      case ScreenView.dateExpired:
        return const MedicationScreen(
          url: AppLink.medicineGetAllDateExpired,
        );
      case ScreenView.search:
        return SearchScreen(value: _valueForSearch);
      // OrdersScreen
      case ScreenView.preparing:
        return OrdersScreen(currentScreen: currentScreen);
      case ScreenView.hasBeenSent:
        return OrdersScreen(currentScreen: currentScreen);
      case ScreenView.received:
        return OrdersScreen(currentScreen: currentScreen);
      case ScreenView.paid:
        return OrdersScreen(currentScreen: currentScreen);
      case ScreenView.unPaid:
        return OrdersScreen(currentScreen: currentScreen);
      case ScreenView.profile:
        return const ProfileScreen();
    }
  }
}

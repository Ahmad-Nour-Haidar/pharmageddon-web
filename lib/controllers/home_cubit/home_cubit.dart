import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/core/constant/app_link.dart';
import 'package:pharmageddon_web/view/screens/medication_screen.dart';
import 'package:pharmageddon_web/view/screens/search_screen.dart';
import '../../core/enums/drawer_enum.dart';
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
    if (currentScreen == value) return;
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
      case ScreenView.all:
        return const MedicationScreen(url: AppLink.medicineGetAll);
      case ScreenView.manufacturer:
        return const SizedBox();
      case ScreenView.effectCategories:
        return const SizedBox();
      case ScreenView.discounts:
        return const MedicationScreen(url: AppLink.medicineGetAllDiscount);
      case ScreenView.add:
        return const SizedBox();
      case ScreenView.reports:
        return const ReportsScreen();
      case ScreenView.preparing:
        return const SizedBox();
      case ScreenView.hasBeenSent:
        return const SizedBox();
      case ScreenView.received:
        return const SizedBox();
      case ScreenView.paid:
        return const SizedBox();
      case ScreenView.unPaid:
        return const SizedBox();
      case ScreenView.quantityExpired:
        return const MedicationScreen(
          url: AppLink.medicineGetAllQuantityExpired,
        );
      case ScreenView.dateExpired:
        return const MedicationScreen(url: AppLink.medicineGetAllDateExpired);
      case ScreenView.search:
        return SearchScreen(value: _valueForSearch);
    }
  }
}

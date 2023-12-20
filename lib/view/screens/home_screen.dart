import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import '../../core/enums/drawer_enum.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BorderRadius get borderRadius {
    if (isEnglish()) {
      return const BorderRadius.only(
        topLeft: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      );
    }
    return const BorderRadius.only(
      topRight: Radius.circular(25),
      bottomRight: Radius.circular(25),
    );
  }

  var _currentScreen = ScreenView.all;

  void changeScreen(ScreenView value) {
    if (_currentScreen == value) return;
    setState(() {
      _currentScreen = value;
    });
  }

  var _valueForSearch = '';

  void onFieldSubmitted(String value) {
    if (value.isEmpty) return;
    setState(() {
      _valueForSearch = value;
      _currentScreen = ScreenView.search;
    });
  }

  Widget get _screen {
    switch (_currentScreen) {
      case ScreenView.all:
        return const SizedBox();
      case ScreenView.manufacturer:
        return const SizedBox();
      case ScreenView.effectCategories:
        return const SizedBox();
      case ScreenView.discounts:
        return const SizedBox();
      case ScreenView.add:
        return const SizedBox();
      case ScreenView.reports:
        return const SizedBox();
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
        return const SizedBox();
      case ScreenView.dateExpired:
        return const SizedBox();
      case ScreenView.search:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.contentColorBlue,
      body: Row(
        children: [
          CustomDrawer(onTap: changeScreen),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: borderRadius,
              ),
              child: Column(children: [
                CustomAppBar(onFieldSubmitted: onFieldSubmitted),
                Expanded(child: _screen)
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

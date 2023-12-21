import 'package:flutter/material.dart';
import '../../generate_material_color.dart';
import '../constant/app_color.dart';

ThemeData themeData() => ThemeData(
      applyElevationOverlayColor: false,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
      ),
      fontFamily: 'Inter',
      useMaterial3: true,
      primaryColor: AppColor.primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: generateMaterialColor(color: AppColor.primaryColor),
        backgroundColor: AppColor.white,
      ),
    );

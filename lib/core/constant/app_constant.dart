import 'package:flutter/widgets.dart';

class AppConstant {
  AppConstant._();

  static const ar = 'ar';
  static const en = 'en';
  // static const pharmacist = 'pharmacist';
  static const warehouseowner = 'warehouseowner';

  static const localEn = Locale(en);
  static const localAr = Locale(ar);
  static late Locale currentLocal;
}

import 'package:flutter/widgets.dart';

class AppConstant {
  AppConstant._();

  static const ar = 'ar';
  static const en = 'en';

  // static const pharmacist = 'pharmacist';
  static const warehouseowner = 'warehouseowner';
  static const received = 'received';
  static const hasBeenSent = 'has_been_sent';
  static const preparing = 'preparing';

  static const localEn = Locale(en);
  static const localAr = Locale(ar);
  static bool _isEnglish = false;

  static bool get isEnglish => _isEnglish;

  static set isEnglish(bool value) {
    _isEnglish = value;
  }
}

import 'package:get/get.dart';
import '../constant/app_constant.dart';
import '../constant/app_text.dart';

class ValidateInput {
  ValidateInput._();

  static const _regExpEmail =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const _regExpPhone = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  static const _regExpPhone2 = r'^09\d{8}$';
  static const _regExpUsername = r'^[a-zA-Z0-9][a-zA-Z0-9_. ]+[a-zA-Z0-9]$';
  static const _regExpPassword =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  static const _regExpEnglish = r'^[A-Za-z0-9!@#\$%^&*():\/\\.\-+,; ]+$';
  static const _regExpArabic = r'^[\u0600-\u06FF0-9\s!@#$%^&*():/\\.,;+-]+$';
  static const _isAlphanumeric = r'^[a-zA-Z0-9 ]+$';
  static const _isArabicAlphanumeric = r'^[؀-ۿ0-9 ]+$';
  static const _isAlphanumericAndSomeCharacters = r'^[a-zA-Z0-9/.,:+\-_()% ]+$';
  static const _isArabicAlphanumericAndSomeCharacters =
      r'^[؀-ۿ0-9/.,:+\-_()% ]+$';
  static const _isAlphanumericAndAllCharacters =
      r'^[a-zA-Z0-9:+=_,.!@#$%^&*();/\[\] ]+$';
  static const _isArabicAlphanumericAndAllCharacters =
      r'^[؀-ۿ0-9:+=_,.!@#$%^&*();/\[\] ]+$';

  static String _getMessageLength(int mn, int mx) =>
      '${AppText.lengthMustBeBetween.tr} $mn - $mx';

  static String _getMessageNotValid(String field) =>
      '$field ${AppText.notValid.tr}';

  static String? isArabicAlphanumericAndAllCharacters(String? value,
      {int min = 4, int max = 60}) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < min || value.length > max) {
      return _getMessageLength(min, max);
    }
    if (!RegExp(_isArabicAlphanumericAndAllCharacters).hasMatch(value)) {
      return _getMessageNotValid('');
    }
    return null;
  }

  static String? isAlphanumericAndAllCharacters(String? value,
      {int min = 4, int max = 60}) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < min || value.length > max) {
      return _getMessageLength(min, max);
    }
    if (!RegExp(_isAlphanumericAndAllCharacters).hasMatch(value)) {
      return _getMessageNotValid('');
    }
    return null;
  }

  static String? isArabicAlphanumericAndSomeCharacters(String? value,
      {int min = 4, int max = 60}) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < min || value.length > max) {
      return _getMessageLength(min, max);
    }
    if (!RegExp(_isArabicAlphanumericAndSomeCharacters).hasMatch(value)) {
      return _getMessageNotValid('');
    }
    return null;
  }

  static String? isAlphanumericAndSomeCharacters(String? value,
      {int min = 4, int max = 60}) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < min || value.length > max) {
      return _getMessageLength(min, max);
    }
    if (!RegExp(_isAlphanumericAndSomeCharacters).hasMatch(value)) {
      return _getMessageNotValid('');
    }
    return null;
  }

  static String? isArabicAlphanumeric(String? value,
      {int min = 4, int max = 60}) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < min || value.length > max) {
      return _getMessageLength(min, max);
    }
    if (!RegExp(_isArabicAlphanumeric).hasMatch(value)) {
      return AppText.thisFieldMustContainArabicLettersAndNumbers.tr;
    }
    return null;
  }

  static String? isAlphanumeric(String? value, {int min = 4, int max = 60}) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < min || value.length > max) {
      return _getMessageLength(min, max);
    }
    if (!RegExp(_isAlphanumeric).hasMatch(value)) {
      return AppText.thisFieldMustContainEnglishLettersAndNumbers.tr;
    }
    return null;
  }

  static String? isEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (!_hasMatch(value, _regExpEmail)) {
      return _getMessageNotValid(AppText.email.tr);
    }
    if (!value.endsWith('@gmail.com')) {
      return AppConstant.isEnglish
          ? '${AppText.emailMustBeEndWith.tr}: @gmail.com'
          : '@gmail.com :${AppText.emailMustBeEndWith.tr}';
    }
    if (value.length < 13 || value.length > 50) {
      return _getMessageLength(13, 50);
    }
    return null;
  }

  static String? isPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < 8 || value.length > 50) {
      return _getMessageLength(8, 50);
    }
    if (!_hasMatch(value, _regExpPassword)) {
      return AppText.passwordMustBeAtLeast8.tr;
    }
    return null;
  }

  static String? isPhone(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    // if (value.length < 9 || value.length > 16) {
    //   return _getMessageLength(9, 16);
    // }
    if (!_hasMatch(value, _regExpPhone2)) {
      return AppText.thePhoneNumberMustStartWith.tr;
      // return _getMessageNotValid(AppStrings.phone.tr);
    }
    return null;
  }

  static String? isUsername(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < 3 || value.length > 50) {
      return _getMessageLength(3, 50);
    }
    if (!_hasMatch(value, _regExpUsername)) {
      return _getMessageNotValid(AppText.userName.tr);
    }
    return null;
  }

  static String? isAddress(String? value) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < 10 || value.length > 200) {
      return _getMessageLength(10, 200);
    }
    return null;
  }

  static String? isArabicText(String? value, {int min = 4, int max = 60}) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < min || value.length > max) {
      return _getMessageLength(min, max);
    }
    if (!RegExp(_regExpArabic, unicode: true).hasMatch(value)) {
      return AppText.thisFieldMustBeArabic.tr;
    }
    return null;
  }

  static String? isEnglishText(String? value, {int min = 4, int max = 60}) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value.length < min || value.length > max) {
      return _getMessageLength(min, max);
    }
    if (!RegExp(_regExpEnglish).hasMatch(value)) {
      return AppText.thisFieldMustBeEnglish.tr;
    }
    return null;
  }

  static String? isNumericWithoutDecimal(
    String? value, {
    int min = 1,
    int max = 16,
  }) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value[0] == '0') {
      return AppText.invalidNumber.tr;
    }
    final x = int.tryParse(value);
    if (value.contains('.') || x == null) {
      return AppText.invalidNumberOrContainsDecimals.tr;
    }
    if (x < 1) {
      return "${AppText.atLeast.tr} $min";
    }
    return null;
  }

  static String? isPrice(String? value, {double min = 1.0}) {
    if (value == null || value.isEmpty) {
      return AppText.thisFieldCantBeEmpty.tr;
    }
    if (value[0] == '0') {
      return AppText.invalidNumber.tr;
    }
    final x = double.tryParse(value);
    if (x == null) {
      return AppText.invalidNumber.tr;
    }
    if (x < 1.0) {
      return "${AppText.atLeast.tr} $min";
    }
    return null;
  }

  static bool _hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }
}

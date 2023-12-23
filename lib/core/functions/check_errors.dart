import 'package:get/get.dart';
import '../constant/app_keys_request.dart';

String checkErrorMessages(List<dynamic> errors) {
  String result = '';
  for (String error in errors) {
    error = error.toString();
    result.isNotEmpty ? result += ', ' : 1;
    if (error.toLowerCase().contains(AppRKeys.email)) {
      result += AppRKeys.email.tr;
    } else if (error.toLowerCase().contains(AppRKeys.phone)) {
      result += AppRKeys.phone.tr;
    } else if (error.toLowerCase().contains(AppRKeys.username)) {
      result += AppRKeys.username.tr;
    } else if (error.toLowerCase().contains(AppRKeys.english_scientific_name)) {
      result += AppRKeys.english_scientific_name.tr;
    } else if (error.toLowerCase().contains(AppRKeys.arabic_scientific_name)) {
      result += AppRKeys.arabic_scientific_name.tr;
    } else if (error.toLowerCase().contains(AppRKeys.english_commercial_name)) {
      result += AppRKeys.english_commercial_name.tr;
    } else if (error.toLowerCase().contains(AppRKeys.arabic_commercial_name)) {
      result += AppRKeys.arabic_commercial_name.tr;
    }
  }
  return result;
}

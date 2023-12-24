import 'package:get/get.dart';
import '../constant/app_keys_request.dart';
import '../constant/app_text.dart';

String checkErrorMessages(List<dynamic> errors) {
  const s = 'The expiration date field must be a date after today';
  String result = '';
  for (String error in errors) {
    error = error.toString().toLowerCase();
    result.isNotEmpty ? result += ', ' : 1;
    if (error.contains(s.toLowerCase())) {
      return AppText.theExpirationDateFieldMustBeADateAfterToday.tr;
    } else if (error.contains(AppRKeys.email)) {
      result += AppRKeys.email.tr;
    } else if (error.contains(AppRKeys.phone)) {
      result += AppRKeys.phone.tr;
    } else if (error.contains(AppRKeys.username)) {
      result += AppRKeys.username.tr;
    } else if (error.contains(AppRKeys.english_scientific_name)) {
      result += AppRKeys.english_scientific_name.tr;
    } else if (error.contains(AppRKeys.arabic_scientific_name)) {
      result += AppRKeys.arabic_scientific_name.tr;
    } else if (error.contains(AppRKeys.english_commercial_name)) {
      result += AppRKeys.english_commercial_name.tr;
    } else if (error.contains(AppRKeys.arabic_commercial_name)) {
      result += AppRKeys.arabic_commercial_name.tr;
    }
  }
  return '${AppText.field.tr} $result ${AppText.alreadyBeenTaken.tr}';
}

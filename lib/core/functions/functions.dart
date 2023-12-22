import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/effect_category_model.dart';
import '../../model/manufacturer_model.dart';
import '../../model/medication_model.dart';
import '../../model/order_model.dart';
import '../../model/user_model.dart';
import '../constant/app_constant.dart';
import '../constant/app_keys_request.dart';
import '../constant/app_keys_storage.dart';
import '../constant/app_link.dart';
import '../constant/app_local_data.dart';
import '../constant/app_text.dart';
import '../services/dependency_injection.dart';

bool isEnglish() => AppConstant.currentLocal == AppConstant.localEn;

String getCodeLang() =>
    AppConstant.currentLocal == AppConstant.localEn ? 'en' : 'ar';

int getRandom() => Random().nextInt(15) + 5;

String formatDateJiffy(DateTime date) {
  return Jiffy.parseFromDateTime(date)
      .format(pattern: 'EEEE, MMMM, d - MM - yyyy');
}

String formatTimeJiffy(DateTime date) {
  return Jiffy.parseFromDateTime(date).format(pattern: 'h:mm a');
}

TextDirection getTextDirection(String value) {
  if (value.contains(RegExp(r"[\u0600-\u06FF]"))) {
    return TextDirection.rtl;
  } else {
    return TextDirection.ltr;
  }
}

TextDirection getTextDirectionOnLang() {
  if (isEnglish()) {
    return TextDirection.ltr;
  } else {
    return TextDirection.rtl;
  }
}

Future<void> storeUser(Map<String, dynamic> response) async {
  final user = User.fromJson(response[AppRKeys.data][AppRKeys.user]);
  final sh = AppInjection.getIt<SharedPreferences>();
  final jsonString = jsonEncode(user.toJson());
  await sh.setString(AppKeysStorage.user, jsonString);
  AppLocalData.user = user;

  // printme.yellowAccent(AppLocalData.user?.authorization);
}

void initialUser() async {
  final sh = AppInjection.getIt<SharedPreferences>();
  var jsonString = sh.getString(AppKeysStorage.user);
  if (jsonString == null) return;
  final Map<String, dynamic> m = jsonDecode(jsonString);
  final user = User.fromJson(m);
  AppLocalData.user = user;
}

String getImageUserUrl() =>
    '${AppLink.userImage}/${AppLocalData.user!.imageName}';

String getUrlImageMedication(MedicationModel? model) {
  final s = '${AppLink.medicineImage}/${model?.imageName}';
  return s;
}

String getManufacturerName(ManufacturerModel? model, {bool split = true}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (isEnglish()) {
      s = model.englishName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (isEnglish()) {
    s = model.englishName.toString();
  } else {
    s = model.arabicName.toString();
  }
  return s;
}

String getEffectCategoryModelName(EffectCategoryModel? model,
    {bool split = true}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (isEnglish()) {
      s = model.englishName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (isEnglish()) {
    s = model.englishName.toString();
  } else {
    s = model.arabicName.toString();
  }
  return s;
}

bool isNew(MedicationModel model) {
  final dateNow = DateTime.now();
  final dateMedication = DateTime.tryParse(model.createdAt ?? '') ?? dateNow;
  return dateNow.difference(dateMedication).inDays <= 7;
}

String getMedicationScientificName(MedicationModel? model,
    {bool split = true}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (isEnglish()) {
      s = model.englishScientificName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicScientificName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (isEnglish()) {
    s = model.englishScientificName.toString();
  } else {
    s = model.arabicScientificName.toString();
  }
  return s;
}

String getMCommercialName(MedicationModel? model, {bool split = true}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (isEnglish()) {
      s = model.englishCommercialName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicCommercialName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (isEnglish()) {
    s = model.englishCommercialName.toString();
  } else {
    s = model.arabicCommercialName.toString();
  }
  return s;
}

String getMedicationModelDescription(MedicationModel? model) {
  var s = '';
  if (model == null) return s;
  if (isEnglish()) {
    s = model.englishDescription.toString();
  } else {
    s = model.arabicDescription.toString();
  }
  return s;
}

String formatYYYYMd(String? s) {
  final date = DateTime.tryParse(s ?? '');
  if (date == null) return ' --- ';
  final pattern = isEnglish() ? 'yyyy - M - d' : 'd - M - yyyy';
  return Jiffy.parseFromDateTime(date).format(pattern: pattern);
}

String getPaymentStatus(OrderModel model) {
  return model.paymentStatus == 0 ? AppText.unPaid.tr : AppText.paid.tr;
}

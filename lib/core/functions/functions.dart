import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pharmageddon_web/controllers/local_controller.dart';
import '../../data/local/app_hive.dart';
import '../../model/effect_category_model.dart';
import '../../model/manufacturer_model.dart';
import '../../model/medication_model.dart';
import '../../model/order_details_model.dart';
import '../../model/order_model.dart';
import '../../model/user_model.dart';
import '../constant/app_constant.dart';
import '../constant/app_link.dart';
import '../constant/app_local_data.dart';
import '../constant/app_storage_keys.dart';
import '../constant/app_text.dart';
import '../services/dependency_injection.dart';

// bool AppConstant.isEnglish => AppConstant.isEnglish;

String getCodeLang() =>
    AppInjection.getIt<LocaleController>().locale.languageCode;

int getRandom() => Random().nextInt(15) + 5;

String formatDateJiffy(DateTime date) {
  return Jiffy.parseFromDateTime(date)
      .format(pattern: 'EEEE, MMMM, d - MM - yyyy');
}

String formatTimeJiffy(DateTime date) {
  return Jiffy.parseFromDateTime(date).format(pattern: 'h:mm a');
}

String formatYYYYMd(Object? object) {
  final s = object?.toString();
  final date = DateTime.tryParse(s ?? '');
  if (date == null) return ' --- ';
  final pattern = AppConstant.isEnglish ? 'yyyy - M - d' : 'd - M - yyyy';
  return Jiffy.parseFromDateTime(date).format(pattern: pattern);
}

String formatDM(Object? object) {
  final s = object?.toString();
  final date = DateTime.tryParse(s ?? '');
  if (date == null) return ' --- ';
  return '${date.day} - ${date.month}';
}

TextDirection getTextDirection(String value) {
  if (value.contains(RegExp(r"[\u0600-\u06FF]"))) {
    return TextDirection.rtl;
  } else {
    return TextDirection.ltr;
  }
}

TextDirection getTextDirectionOnLang() {
  if (AppConstant.isEnglish) {
    return TextDirection.ltr;
  } else {
    return TextDirection.rtl;
  }
}

Future<void> storeUser(Map<String, dynamic> json) async {
  final user = User.fromJson(json);
  final appHive = AppInjection.getIt<AppHive>();
  await appHive.store(AppSKeys.userKey, user.toJson());
  AppLocalData.user = user;
  // printme.yellowAccent(AppLocalData.user?.toJson());
}

void initialUser() {
  final appHive = AppInjection.getIt<AppHive>();
  final Map? jsonString = appHive.get(AppSKeys.userKey);
  if (jsonString == null) {
    return;
  }
  final Map<String, dynamic> jsonUser = {};
  jsonString.forEach((key, value) {
    jsonUser[key.toString()] = value;
  });
  var user = User.fromJson(jsonUser);
  AppLocalData.user = user;
  // printme.yellowAccent(AppLocalData.user?.toJson());
  return;
}

String getImageUserUrl() =>
    '${AppLink.userImage}/${AppLocalData.user?.imageName}';

String getUrlImageMedication(MedicationModel? model) {
  final s = '${AppLink.medicineImage}/${model?.imageName}';
  return s;
}

String getManufacturerName(
  ManufacturerModel? model, {
  bool split = true,
  int max = 2,
}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (AppConstant.isEnglish) {
      s = model.englishName.toString().split(' ').take(max).join(' ');
    } else {
      s = model.arabicName.toString().split(' ').take(max).join(' ');
    }
    return s;
  }
  if (AppConstant.isEnglish) {
    s = model.englishName.toString();
  } else {
    s = model.arabicName.toString();
  }
  return s;
}

String getEffectCategoryModelName(
  EffectCategoryModel? model, {
  bool split = true,
  int max = 2,
}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (AppConstant.isEnglish) {
      s = model.englishName.toString().split(' ').take(max).join(' ');
    } else {
      s = model.arabicName.toString().split(' ').take(max).join(' ');
    }
    return s;
  }
  if (AppConstant.isEnglish) {
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
    if (AppConstant.isEnglish) {
      s = model.englishScientificName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicScientificName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (AppConstant.isEnglish) {
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
    if (AppConstant.isEnglish) {
      s = model.englishCommercialName.toString().split(' ').take(2).join(' ');
    } else {
      s = model.arabicCommercialName.toString().split(' ').take(2).join(' ');
    }
    return s;
  }
  if (AppConstant.isEnglish) {
    s = model.englishCommercialName.toString();
  } else {
    s = model.arabicCommercialName.toString();
  }
  return s;
}

String getMedicationModelDescription(MedicationModel? model) {
  var s = '';
  if (model == null) return s;
  if (AppConstant.isEnglish) {
    s = model.englishDescription.toString();
  } else {
    s = model.arabicDescription.toString();
  }
  return s;
}

String getPaymentStatus(OrderModel model) {
  return model.paymentStatus == 0 ? AppText.unPaid.tr : AppText.paid.tr;
}

String buildUrl({
  required String baseUrl,
  required Map<String, dynamic> queryParameters,
}) {
  // Convert all values to strings
  final stringQueryParameters = Map.from(queryParameters)
      .map((key, value) => MapEntry<String, String>(key, value.toString()));

  final uri = Uri.parse(baseUrl).replace(
    queryParameters: stringQueryParameters,
  );
  return uri.toString();
}

String getEffectCategoryImage(EffectCategoryModel? model) {
  final s = '${AppLink.effectCategoriesImage}/${model?.imageName}';
  // printme.cyan(s);
  return s;
}

String getOrderDetailsModelName(
  OrderDetailsModel? model, {
  bool split = true,
  int max = 2,
}) {
  var s = '';
  if (model == null) return s;
  if (split) {
    if (AppConstant.isEnglish) {
      s = model.medicineEnglishCommercialName
          .toString()
          .split(' ')
          .take(max)
          .join(' ');
    } else {
      s = model.medicineArabicCommercialName
          .toString()
          .split(' ')
          .take(max)
          .join(' ');
    }
    return s;
  }
  if (AppConstant.isEnglish) {
    s = model.medicineEnglishCommercialName.toString();
  } else {
    s = model.medicineArabicCommercialName.toString();
  }
  return s;
}

String formatYYYYMdEEEE(String? s) {
  final date = DateTime.tryParse(s ?? '');
  if (date == null) return ' --- ';
  final pattern =
      AppConstant.isEnglish ? 'EEEE , yyyy - M - d' : 'EEEE , d - M - yyyy';
  return Jiffy.parseFromDateTime(date).format(pattern: pattern);
}

Alignment alignment() =>
    AppConstant.isEnglish ? Alignment.centerLeft : Alignment.centerRight;

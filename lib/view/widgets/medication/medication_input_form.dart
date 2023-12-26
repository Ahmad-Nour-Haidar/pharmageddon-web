import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/add_cubit/add_cubit.dart';
import 'package:pharmageddon_web/core/constant/app_keys_request.dart';
import 'package:pharmageddon_web/core/constant/app_svg.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_web/print.dart';
import 'package:pharmageddon_web/view/widgets/custom_button.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';
import 'package:pharmageddon_web/view/widgets/text_input.dart';

import '../../../core/class/image_helper.dart';
import '../../../core/class/validation.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_padding.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/functions/functions.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../model/medication_model.dart';
import '../build_row_two_widgets.dart';
import '../custom_menu.dart';
import '../get_image_from_url_and_memory.dart';

class MedicationInputForm extends StatefulWidget {
  const MedicationInputForm({
    super.key,
    required this.onTapButton,
    required this.isLoading,
    this.medicationModel,
    this.physics,
    this.chooseEffectCategory = false,
    this.chooseManufacturer = false,
  });

  final MedicationModel? medicationModel;
  final ScrollPhysics? physics;
  final void Function(Map<String, Object?> data, File? file) onTapButton;
  final bool isLoading, chooseManufacturer, chooseEffectCategory;

  @override
  State<MedicationInputForm> createState() => _MedicationInputFormState();
}

class _MedicationInputFormState extends State<MedicationInputForm> {
  final _imageHelper = AppInjection.getIt<ImageHelper>();
  final _formKey = GlobalKey<FormState>();
  final _scientificNameArCon = TextEditingController();
  final _scientificNameEnCon = TextEditingController();
  final _commercialNameArCon = TextEditingController();
  final _commercialNameEnCon = TextEditingController();
  final _availableQuantityCon = TextEditingController();
  final _descArCon = TextEditingController();
  final _descEnCon = TextEditingController();
  final _priceCon = TextEditingController();
  DateTime? _expirationDate;
  File? _pickedImage;
  Uint8List? _webImage;
  MedicationModel? _model;

  // this to when add medicine
  String? manufacturerId, effectCategoryId;

  @override
  void initState() {
    initial(widget.medicationModel);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MedicationInputForm oldWidget) {
    initial(widget.medicationModel);
    super.didUpdateWidget(oldWidget);
  }

  void initial(MedicationModel? medicationModel) {
    if (medicationModel == null) return;
    if (_model == medicationModel) return;
    _model = medicationModel;
    _scientificNameArCon.text = _model!.arabicScientificName.toString();
    _scientificNameEnCon.text = _model!.englishScientificName.toString();
    _commercialNameArCon.text = _model!.arabicCommercialName.toString();
    _commercialNameEnCon.text = _model!.englishCommercialName.toString();
    _descArCon.text = _model!.arabicDescription.toString();
    _descEnCon.text = _model!.englishDescription.toString();
    _priceCon.text = _model!.price.toString();
    _availableQuantityCon.text = _model!.availableQuantity.toString();
    _expirationDate = DateTime.tryParse(_model!.expirationDate.toString());
    setState(() {});
  }

  void onTapButton() {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      AppRKeys.id: _model == null ? '' : _model!.id.toString(),
      AppRKeys.english_scientific_name: _scientificNameEnCon.text,
      AppRKeys.arabic_scientific_name: _scientificNameArCon.text,
      AppRKeys.english_commercial_name: _commercialNameEnCon.text,
      AppRKeys.arabic_commercial_name: _commercialNameArCon.text,
      AppRKeys.available_quantity: _availableQuantityCon.text,
      AppRKeys.expiration_date: _expirationDate.toString(),
      AppRKeys.price: _priceCon.text,
      AppRKeys.english_description: _descEnCon.text,
      AppRKeys.arabic_description: _descArCon.text,
    };
    widget.onTapButton(data, _pickedImage);
  }

  set expirationDate(DateTime value) {
    setState(() {
      _expirationDate = value;
    });
  }

  String get _textButton => _model == null ? AppText.add.tr : AppText.edit.tr;

  Future<void> pickImage() async {
    try {
      final temp = await _imageHelper.pickImage();
      if (temp == null) return;
      _pickedImage = File(temp.path);
      _webImage = await temp.readAsBytes();
      {
        // final tempCrop = await _imageHelper.cropImage(
        //   file: temp,
        //   uiSettings: [if (webUiSettings != null) webUiSettings],
        // );
        // if (tempCrop == null) return;
        // _pickedImage = File(tempCrop.path);
        // _webImage = await tempCrop.readAsBytes();
      }
    } catch (e) {
      printme.red(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    printme.magenta(AppInjection.getIt<AddCubit>().effectCategoriesData.length);
    return Form(
      key: _formKey,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ListView(
          physics: widget.physics,
          shrinkWrap: true,
          children: [
            GetImageFromUrlAndMemory(
              url: getUrlImageMedication(_model),
              size: 200,
              onTap: pickImage,
              callUrl: _model != null,
              webImage: _webImage,
            ),
            const Gap(15),
            BuildRow(
              widget1: TextInputField(
                validator: (value) {
                  return ValidateInput.isAlphanumeric(value);
                },
                controller: _scientificNameEnCon,
                label: AppText.scientificNameEn.tr,
              ),
              widget2: TextInputField(
                validator: (value) {
                  return ValidateInput.isArabicAlphanumeric(value);
                },
                controller: _scientificNameArCon,
                label: AppText.scientificNameAr.tr,
                textDirection: TextDirection.rtl,
              ),
            ),
            const Gap(10),
            BuildRow(
              widget1: TextInputField(
                validator: (value) {
                  return ValidateInput.isAlphanumeric(value);
                },
                controller: _commercialNameEnCon,
                label: AppText.commercialNameEn.tr,
              ),
              widget2: TextInputField(
                validator: (value) {
                  return ValidateInput.isArabicAlphanumeric(value);
                },
                controller: _commercialNameArCon,
                label: AppText.commercialNameAr.tr,
                textDirection: TextDirection.rtl,
              ),
            ),
            const Gap(10),
            BuildRow(
              widget1: TextInputField(
                validator: (value) {
                  return ValidateInput.isAlphanumericAndAllCharacters(value,
                      max: 500);
                },
                controller: _descEnCon,
                label: AppText.description.tr,
                maxLength: 500,
                maxLines: 7,
              ),
              widget2: TextInputField(
                validator: (value) {
                  return ValidateInput.isArabicAlphanumericAndAllCharacters(
                      value,
                      max: 500);
                },
                controller: _descArCon,
                label: AppText.description.tr,
                textDirection: TextDirection.rtl,
                maxLength: 500,
                maxLines: 7,
              ),
            ),
            const Gap(10),
            BuildRow(
              widget1: TextInputField(
                validator: (value) {
                  return ValidateInput.isPrice(value);
                },
                controller: _priceCon,
                label: AppText.price.tr,
                maxLength: 16,
                maxLines: 1,
              ),
              widget2: TextInputField(
                validator: (value) {
                  return ValidateInput.isNumericWithoutDecimal(value, max: 5);
                },
                controller: _availableQuantityCon,
                label: AppText.availableQuantity.tr,
                textDirection: TextDirection.ltr,
                maxLength: 5,
                maxLines: 1,
              ),
            ),
            const Gap(10),
            InkWell(
              onTap: () => _pickDate(context),
              child: Container(
                width: double.infinity,
                padding: AppPadding.padding10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColor.contentColorBlue,
                    width: 2,
                  ),
                ),
                child: Align(
                  alignment: isEnglish()
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Text(
                    '${AppText.expirationDate.tr} : ${formatYYYYMd(_expirationDate)}'
                        .trn,
                    style: AppTextStyle.f16w500black,
                  ),
                ),
              ),
            ),
            const Gap(10),
            Row(
              children: [
                if (widget.chooseEffectCategory)
                  Expanded(
                    child: CustomMenu(
                      title: AppText.effectCategories.tr,
                      data: AppInjection.getIt<AddCubit>().effectCategoriesData,
                      onChange: (newValue) {
                        effectCategoryId = newValue;
                      },
                      onTapReload: () => AppInjection.getIt<AddCubit>()
                          .getDataEffectCategory(forceGet: true),
                    ),
                  ),
                const Gap(10),
                if (widget.chooseManufacturer)
                  Expanded(
                    child: CustomMenu(
                      title: AppText.manufacturer.tr,
                      data: AppInjection.getIt<AddCubit>().manufacturersData,
                      onChange: (newValue) {
                        manufacturerId = newValue;
                      },
                      onTapReload: () => AppInjection.getIt<AddCubit>()
                          .getDataManufacturer(forceGet: true),
                    ),
                  ),
              ],
            ),
            const Gap(10),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: widget.isLoading
                      ? const SpinKitThreeBounce(color: AppColor.primaryColor)
                      : CustomButton(
                          onTap: onTapButton,
                          text: _textButton,
                          textStyle: AppTextStyle.f20w600white,
                        ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final dateNow = DateTime.now();
    final firstDate = dateNow.add(const Duration(days: 1));
    final lastDate =
        DateTime(dateNow.year + 6).subtract(const Duration(days: 1));
    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date != null) {
      expirationDate = date;
    }
  }

  @override
  void dispose() {
    _scientificNameArCon.dispose();
    _scientificNameEnCon.dispose();
    _commercialNameArCon.dispose();
    _commercialNameEnCon.dispose();
    _descArCon.dispose();
    _descEnCon.dispose();
    _priceCon.dispose();
    _availableQuantityCon.dispose();
    super.dispose();
  }
}
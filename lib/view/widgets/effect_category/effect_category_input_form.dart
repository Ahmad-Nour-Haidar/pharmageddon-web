import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_keys_request.dart';
import 'package:pharmageddon_web/model/effect_category_model.dart';
import 'package:pharmageddon_web/print.dart';
import 'package:pharmageddon_web/view/widgets/custom_button.dart';
import 'package:pharmageddon_web/view/widgets/text_input.dart';

import '../../../core/class/image_helper.dart';
import '../../../core/class/validation.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/functions/functions.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../get_image_from_url_and_memory.dart';

class EffectCategoryInputForm extends StatefulWidget {
  const EffectCategoryInputForm({
    super.key,
    required this.onTapButton,
    required this.isLoading,
    this.effectCategoryModel,
    this.physics,
  });

  final EffectCategoryModel? effectCategoryModel;
  final ScrollPhysics? physics;
  final void Function(Map<String, Object?> data, File? file) onTapButton;
  final bool isLoading;

  @override
  State<EffectCategoryInputForm> createState() =>
      _EffectCategoryInputFormState();
}

class _EffectCategoryInputFormState extends State<EffectCategoryInputForm> {
  final _imageHelper = AppInjection.getIt<ImageHelper>();
  final _formKey = GlobalKey<FormState>();
  final _nameArCon = TextEditingController();
  final _nameEnCon = TextEditingController();
  EffectCategoryModel? _model;
  File? _pickedImage;
  Uint8List? _webImage;

  @override
  void initState() {
    initial(widget.effectCategoryModel);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EffectCategoryInputForm oldWidget) {
    initial(widget.effectCategoryModel);
    super.didUpdateWidget(oldWidget);
  }

  void initial(EffectCategoryModel? effectCategoryModel) {
    if (effectCategoryModel == null) return;
    if (_model == effectCategoryModel) return;
    _model = effectCategoryModel;
    _nameArCon.text = _model!.arabicName.toString();
    _nameEnCon.text = _model!.englishName.toString();
    setState(() {});
  }

  void onTapButton() {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      AppRKeys.id: _model == null ? '' : _model!.id.toString(),
      AppRKeys.arabic_name: _nameArCon.text,
      AppRKeys.english_name: _nameEnCon.text,
    };
    widget.onTapButton(data, _pickedImage);
  }

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

  String get _textButton => _model == null ? AppText.add.tr : AppText.edit.tr;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ListView(
          physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            GetImageFromUrlAndMemory(
              url: getEffectCategoryImage(_model),
              size: 100,
              onTap: pickImage,
              callUrl: _model != null,
              webImage: _webImage,
            ),
            const Gap(10),
            TextInputField(
              validator: (value) {
                return ValidateInput.isAlphanumeric(value);
              },
              controller: _nameEnCon,
              label: AppText.nameEn.tr,
              maxLines: 1,
            ),
            const Gap(5),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextInputField(
                validator: (value) {
                  return ValidateInput.isArabicAlphanumeric(value);
                },
                controller: _nameArCon,
                label: AppText.nameAr.tr,
                textDirection: TextDirection.rtl,
              ),
            ),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: widget.isLoading
                      ? const SpinKitThreeBounce(color: AppColor.primaryColor)
                      : CustomButton(
                          height: 40,
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

  @override
  void dispose() {
    _nameEnCon.dispose();
    _nameArCon.dispose();
    super.dispose();
  }
}

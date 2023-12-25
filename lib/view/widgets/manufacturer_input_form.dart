import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_keys_request.dart';
import 'package:pharmageddon_web/model/manufacturer_model.dart';
import 'package:pharmageddon_web/view/widgets/custom_button.dart';
import 'package:pharmageddon_web/view/widgets/text_input.dart';

import '../../core/class/validation.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_text.dart';
import '../../core/resources/app_text_theme.dart';

class ManufacturerInputForm extends StatefulWidget {
  const ManufacturerInputForm({
    super.key,
    this.manufacturerModel,
    required this.onTapButton,
    required this.isLoading,
  });

  final ManufacturerModel? manufacturerModel;

  final void Function(Map<String, Object?> data) onTapButton;
  final bool isLoading;

  @override
  State<ManufacturerInputForm> createState() => _ManufacturerInputFormState();
}

class _ManufacturerInputFormState extends State<ManufacturerInputForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameArCon = TextEditingController();
  final _nameEnCon = TextEditingController();
  ManufacturerModel? _model;

  @override
  void initState() {
    initial(widget.manufacturerModel);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ManufacturerInputForm oldWidget) {
    initial(widget.manufacturerModel);
    super.didUpdateWidget(oldWidget);
  }

  void initial(ManufacturerModel? manufacturerModel) {
    _model = manufacturerModel;
    if (_model == null) return;
    _nameArCon.text = _model!.arabicName.toString();
    _nameEnCon.text = _model!.englishName.toString();
    setState(() {});
  }

  void onTapButton() {
    if (!_formKey.currentState!.validate()) return;
    final data = {
      AppRKeys.arabic_name: _nameArCon.text,
      AppRKeys.english_name: _nameEnCon.text,
    };
    widget.onTapButton(data);
  }

  String get _textButton => _model == null ? AppText.add.tr : AppText.edit.tr;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ListView(
          children: [
            TextInputField(
              validator: (value) {
                return ValidateInput.isAlphanumeric(value);
              },
              controller: _nameEnCon,
              label: AppText.scientificNameEn.tr,
            ),
            TextInputField(
              validator: (value) {
                return ValidateInput.isArabicAlphanumeric(value);
              },
              controller: _nameEnCon,
              label: AppText.scientificNameEn.tr,
            ),
            const Gap(20),
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
            const Gap(30),
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

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_keys_request.dart';
import 'package:pharmageddon_web/model/manufacturer_model.dart';
import 'package:pharmageddon_web/view/widgets/custom_button.dart';
import 'package:pharmageddon_web/view/widgets/text_input.dart';

import '../../../core/class/validation.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/resources/app_text_theme.dart';

class ManufacturerInputForm extends StatefulWidget {
  const ManufacturerInputForm({
    super.key,
    required this.onTapButton,
    required this.isLoading,
    this.manufacturerModel,
    this.physics,
  });

  final ManufacturerModel? manufacturerModel;
  final ScrollPhysics? physics;
  final void Function(Map<String, String> data) onTapButton;
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
    if (manufacturerModel == null) return;
    if (_model == manufacturerModel) return;
    _model = manufacturerModel;
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
          physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
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
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: widget.isLoading
                        ? const SpinKitThreeBounce(color: AppColor.primaryColor)
                        : CustomButton(
                            height: 60,
                            onTap: onTapButton,
                            text: _textButton,
                            textStyle: AppTextStyle.f20w600white,
                          ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
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

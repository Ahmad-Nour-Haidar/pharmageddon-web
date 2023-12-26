import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';

import '../../core/constant/app_color.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    required this.validator,
    required this.controller,
    this.enabled = true,
    this.textDirection = TextDirection.ltr,
    this.label = '',
    this.minLines = 1,
    this.maxLines = 3,
    this.maxLength = 60,
  });

  static final _border = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColor.contentColorBlue, width: 2),
  );

  static final _borderDisabled = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColor.gray1, width: 2),
  );
  static final _borderErrorBorder = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColor.red, width: 2),
  );

  final String? Function(String?) validator;
  final TextDirection? textDirection;
  final TextEditingController controller;
  final String label;
  final bool enabled;
  final int? maxLength, minLines, maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: enabled,
      controller: controller,
      validator: validator,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      textDirection: textDirection ?? getTextDirection(controller.text),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTextStyle.f14w500black,
        contentPadding: const EdgeInsets.all(10),
        border: _border,
        focusedBorder: _border,
        enabledBorder: _border,
        disabledBorder: _borderDisabled,
        errorBorder: _borderErrorBorder,
        focusedErrorBorder: _borderErrorBorder,
      ),
    );
  }
}

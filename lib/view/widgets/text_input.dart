import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';

import '../../core/constant/app_color.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.validator,
    this.textDirection,
    required this.controller,
    required this.label,
    required this.enabled,
  });

  static final _border = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: AppColor.contentColorBlue, width: 2),
  );

  static final _borderDisabled = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: AppColor.gray1, width: 2),
  );
  final String? Function(String?) validator;
  final TextDirection? textDirection;
  final TextEditingController controller;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textDirection: getTextDirection(controller.text),
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.all(10),
        border: _border,
        focusedBorder: _border,
        enabledBorder: _border,
        disabledBorder: _borderDisabled,
      ),
    );
  }
}

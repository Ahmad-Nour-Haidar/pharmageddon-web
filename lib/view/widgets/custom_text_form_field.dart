import 'package:flutter/material.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';
import '../../core/functions/functions.dart';
import '../../core/resources/app_text_theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.textInputAction,
    required this.fillColor,
    required this.colorPrefixIcon,
    required this.prefixIcon,
    required this.labelText,
    this.onFieldSubmitted,
    this.textDirection,
    this.onTapSuffix,
    this.suffixIcon,
    this.obscureText,
    this.sizePrefix = AppSize.size20,
    this.hintStyle,
    this.borderRadius = AppSize.radius10,
    this.contentPadding = const EdgeInsets.all(15),
    this.height,
    this.onTap,
    this.onTapPrefix,
    this.enabled = true,
  });

  final void Function()? onTapSuffix;
  final void Function()? onTapPrefix;
  final String? Function(String?) validator;
  final String? Function(String?)? onFieldSubmitted;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color fillColor;
  final Color colorPrefixIcon;
  final String? prefixIcon;
  final String? suffixIcon;
  final String labelText;
  final bool? obscureText;
  final double sizePrefix;
  final double? height;
  final double borderRadius;
  final TextDirection? textDirection;
  final TextStyle? hintStyle;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? onTap;

  TextDirection get getDirectionality {
    if (textDirection != null) {
      return textDirection!;
    }
    return getTextDirectionOnLang();
  }

  static final _border = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: AppColor.gray2, width: 1),
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

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: getDirectionality,
      child: TextFormField(
        enabled: enabled,
        onTap: onTap,
        // onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textDirection: getTextDirection(controller.text),
        validator: validator,
        style: enabled ? null : AppTextStyle.f16w500black,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText ?? false,
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: AppTextStyle.f14w500black,
          helperText: " ",
          errorMaxLines: 2,
          // contentPadding: contentPadding,
          hintTextDirection: getTextDirectionOnLang(),
          // prefixIcon: IconButton(
          //   icon: SvgPicture.asset(prefixIcon, width: sizePrefix),
          //   onPressed: null,
          // ),
          suffixIcon: suffixIcon != null
              ? InkWell(
                  borderRadius: BorderRadius.circular(borderRadius),
                  onTap: onTapSuffix,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgImage(
                      path: suffixIcon!,
                      color: AppColor.gray3,
                      size: 24,
                    ),
                  ),
                )
              : null,
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          focusedErrorBorder: _borderErrorBorder,
          errorBorder: _borderErrorBorder,
          disabledBorder: _borderDisabled,
        ),
      ),
    );
  }
}

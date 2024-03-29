import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/constant/app_padding.dart';
import 'package:pharmageddon_web/core/constant/app_size.dart';

import '../../core/constant/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textStyle = const TextStyle(
      fontSize: 24,
      color: AppColor.white,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.0,
    ),
    this.height = 55,
    this.width = double.infinity,
    this.radius = AppSize.radius10,
    this.color = AppColor.primaryColor,
  });

  final void Function() onTap;
  final String text;
  final double height;
  final double width;
  final double radius;
  final Color color;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppPadding.padding7,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}

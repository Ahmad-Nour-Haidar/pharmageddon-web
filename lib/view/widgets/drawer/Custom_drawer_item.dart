import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/resources/app_text_theme.dart';
import '../svg_image.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    required this.isSelected,
    required this.isOpen,
  });

  final String iconPath;
  final String title;
  final bool isSelected;
  final bool isOpen;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: title,
      preferBelow: false,
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        tileColor: isSelected ? AppColor.white.withOpacity(0.2) : null,
        title: isOpen
            ? FittedBox(
                alignment:
                    isEnglish() ? Alignment.centerLeft : Alignment.centerRight,
                fit: BoxFit.scaleDown,
                child: Text(title, style: AppTextStyle.f16w500white),
              )
            : null,
        leading: SvgImage(path: iconPath, color: AppColor.white, size: 20),
      ),
    );
  }
}

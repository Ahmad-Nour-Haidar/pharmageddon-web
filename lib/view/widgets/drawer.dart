import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/core/enums/drawer_enum.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/print.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_svg.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var isOpen = false;
  var _currentScreen = DrawerEnum.all;
  static const _iconSize = 20.0;

  void changeScreen(DrawerEnum value) {
    setState(() {
      _currentScreen = value;
    });
  }

  void openCloseDrawer() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isOpen ? 200 : 75,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: openCloseDrawer,
              icon: Transform.flip(
                flipX: isOpen,
                child: const SvgImage(
                  path: AppSvg.arrowRight,
                  color: AppColor.white,
                  size: _iconSize,
                ),
              ),
            ),
          ),
          const Gap(30),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.all.tr,
            iconPath: AppSvg.all,
            onTap: () => changeScreen(DrawerEnum.all),
            isSelected: _currentScreen == DrawerEnum.all,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.manufacturer.tr,
            iconPath: AppSvg.text,
            onTap: () => changeScreen(DrawerEnum.manufacturer),
            isSelected: _currentScreen == DrawerEnum.manufacturer,
          ),
        ],
      ),
    );
  }
}

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
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      contentPadding: const EdgeInsets.only(left: 15),
      tileColor: isSelected ? AppColor.white.withOpacity(0.2) : null,
      title: isOpen ?SelectableText(title, style: AppTextTheme.f16w500white) : null,
      leading: SvgImage(path: iconPath, color: AppColor.white, size: 20),
    );
  }
}

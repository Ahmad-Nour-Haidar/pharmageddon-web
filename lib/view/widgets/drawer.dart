import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/core/enums/drawer_enum.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/print.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_svg.dart';
import 'drawer/Custom_drawer_item.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var isOpen = true;
  var _currentScreen = DrawerEnum.all;
  static const _iconSize = 20.0;

  void changeScreen(DrawerEnum value) {
    setState(() {
      _currentScreen = value;
      printme.cyan(value);
    });
  }

  bool get isOrderSelected {
    return _currentScreen == DrawerEnum.preparing ||
        _currentScreen == DrawerEnum.hasBeenSent ||
        _currentScreen == DrawerEnum.received;
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
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.effectCategories.tr,
            iconPath: AppSvg.chemistry,
            onTap: () => changeScreen(DrawerEnum.chemistry),
            isSelected: _currentScreen == DrawerEnum.chemistry,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.discounts.tr,
            iconPath: AppSvg.percentage,
            onTap: () => changeScreen(DrawerEnum.percentage),
            isSelected: _currentScreen == DrawerEnum.percentage,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.quantityExpired.tr,
            iconPath: AppSvg.quantity,
            onTap: () => changeScreen(DrawerEnum.quantity),
            isSelected: _currentScreen == DrawerEnum.quantity,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.dateExpired.tr,
            iconPath: AppSvg.timeDelete,
            onTap: () => changeScreen(DrawerEnum.dateExpired),
            isSelected: _currentScreen == DrawerEnum.dateExpired,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.reports.tr,
            iconPath: AppSvg.report,
            onTap: () => changeScreen(DrawerEnum.reports),
            isSelected: _currentScreen == DrawerEnum.reports,
          ),
          Container(
            decoration: BoxDecoration(
              color: isOrderSelected ? AppColor.white.withOpacity(.2) : null,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(5),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isOpen = true;
                      _currentScreen = DrawerEnum.preparing;
                    });
                  },
                  icon: const SvgImage(
                    path: AppSvg.order,
                    color: AppColor.white,
                    size: 25,
                  ),
                ),
                if (isOpen)
                  Expanded(
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      childrenPadding: const EdgeInsets.only(left: 15),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: AppColor.transparent),
                      ),
                      textColor: AppColor.white,
                      collapsedTextColor: AppColor.white,
                      collapsedIconColor: AppColor.white,
                      iconColor: AppColor.white,
                      title: Text(
                        AppText.orders.tr,
                        style: AppTextTheme.f16w500white,
                      ),
                      expandedAlignment: Alignment.centerLeft,
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextButtonDrawer(
                          text: AppText.preparing.tr,
                          onTap: () => changeScreen(DrawerEnum.preparing),
                          isSelected: _currentScreen == DrawerEnum.preparing,
                        ),
                        CustomTextButtonDrawer(
                          text: AppText.hasBeenSent.tr,
                          onTap: () => changeScreen(DrawerEnum.hasBeenSent),
                          isSelected: _currentScreen == DrawerEnum.hasBeenSent,
                        ),
                        CustomTextButtonDrawer(
                          text: AppText.received.tr,
                          onTap: () => changeScreen(DrawerEnum.received),
                          isSelected: _currentScreen == DrawerEnum.received,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomTextButtonDrawer extends StatelessWidget {
  const CustomTextButtonDrawer({
    super.key,
    required this.onTap,
    required this.text,
    required this.isSelected,
  });

  final void Function() onTap;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? AppColor.white.withOpacity(.2) : null,
        ),
        child: Text(text, style: AppTextTheme.f16w500white),
      ),
    );
  }
}

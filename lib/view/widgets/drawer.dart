import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/core/enums/drawer_enum.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/print.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_svg.dart';
import 'drawer/Custom_drawer_item.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.onTap,
  });

  final void Function(ScreenView value) onTap;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  var isOpen = true;

  var _currentScreen = ScreenView.all;
  static const _iconSize = 20.0;

  void changeScreen(ScreenView value) {
    if (_currentScreen == value) return;
    setState(() {
      _currentScreen = value;
      printme.cyan(value);
    });
    widget.onTap(_currentScreen);
  }

  bool get isOrderSelected {
    return _currentScreen == ScreenView.preparing ||
        _currentScreen == ScreenView.hasBeenSent ||
        _currentScreen == ScreenView.paid ||
        _currentScreen == ScreenView.unPaid ||
        _currentScreen == ScreenView.received;
  }

  void openCloseDrawer() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isOpen ? 230 : 100,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Align(
            alignment: isEnglish() ? Alignment.topRight : Alignment.topLeft,
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
            onTap: () => changeScreen(ScreenView.all),
            isSelected: _currentScreen == ScreenView.all,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.manufacturer.tr,
            iconPath: AppSvg.text,
            onTap: () => changeScreen(ScreenView.manufacturer),
            isSelected: _currentScreen == ScreenView.manufacturer,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.effectCategories.tr,
            iconPath: AppSvg.chemistry,
            onTap: () => changeScreen(ScreenView.effectCategories),
            isSelected: _currentScreen == ScreenView.effectCategories,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.discounts.tr,
            iconPath: AppSvg.percentage,
            onTap: () => changeScreen(ScreenView.discounts),
            isSelected: _currentScreen == ScreenView.discounts,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.reports.tr,
            iconPath: AppSvg.report,
            onTap: () => changeScreen(ScreenView.reports),
            isSelected: _currentScreen == ScreenView.reports,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.add.tr,
            iconPath: AppSvg.add,
            onTap: () => changeScreen(ScreenView.add),
            isSelected: _currentScreen == ScreenView.add,
          ),
          if (!isOpen)
            ListTile(
              tileColor:
                  isOrderSelected ? AppColor.white.withOpacity(0.2) : null,
              leading: const SvgImage(
                path: AppSvg.ballot,
                color: AppColor.white,
                size: 25,
              ),
              onTap: () {
                setState(() {
                  isOpen = true;
                });
                changeScreen(ScreenView.preparing);
              },
            ),
          if (isOpen)
            ExpansionTile(
              collapsedBackgroundColor:
                  isOrderSelected ? AppColor.white.withOpacity(0.2) : null,
              backgroundColor:
                  isOrderSelected ? AppColor.white.withOpacity(0.2) : null,
              initiallyExpanded: isOrderSelected,
              childrenPadding: EdgeInsets.only(
                left: isEnglish() ? 30 : 60,
              ),
              tilePadding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: AppColor.transparent),
              ),
              textColor: AppColor.white,
              collapsedTextColor: AppColor.white,
              collapsedIconColor: AppColor.white,
              iconColor: AppColor.white,
              leading: const SvgImage(
                path: AppSvg.ballot,
                color: AppColor.white,
                size: 25,
              ),
              title: Text(
                isOpen ? AppText.orders.tr : '',
                style: AppTextTheme.f16w500white,
              ),
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextButtonDrawer(
                  text: AppText.preparing.tr,
                  onTap: () => changeScreen(ScreenView.preparing),
                  isSelected: _currentScreen == ScreenView.preparing,
                ),
                CustomTextButtonDrawer(
                  text: AppText.hasBeenSent.tr,
                  onTap: () => changeScreen(ScreenView.hasBeenSent),
                  isSelected: _currentScreen == ScreenView.hasBeenSent,
                ),
                CustomTextButtonDrawer(
                  text: AppText.paid.tr,
                  onTap: () => changeScreen(ScreenView.paid),
                  isSelected: _currentScreen == ScreenView.paid,
                ),
                CustomTextButtonDrawer(
                  text: AppText.unPaid.tr,
                  onTap: () => changeScreen(ScreenView.unPaid),
                  isSelected: _currentScreen == ScreenView.unPaid,
                ),
              ],
            ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.quantityExpired.tr,
            iconPath: AppSvg.quantity,
            onTap: () => changeScreen(ScreenView.quantityExpired),
            isSelected: _currentScreen == ScreenView.quantityExpired,
          ),
          CustomDrawerItem(
            isOpen: isOpen,
            title: AppText.dateExpired.tr,
            iconPath: AppSvg.timeDelete,
            onTap: () => changeScreen(ScreenView.dateExpired),
            isSelected: _currentScreen == ScreenView.dateExpired,
          ),
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

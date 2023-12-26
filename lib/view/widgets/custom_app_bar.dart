import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';
import '../../controllers/local_controller.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_constant.dart';
import '../../core/constant/app_local_data.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_svg.dart';
import '../../core/constant/app_text.dart';
import '../../core/functions/functions.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import 'custom_cached_network_image.dart';
import 'custom_layout_builder.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    super.key,
    required this.onFieldSubmitted,
  });

  final void Function(String) onFieldSubmitted;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  var _dropValue = AppConstant.en;
  final _controller = TextEditingController();

  @override
  void initState() {
    _dropValue = AppInjection.getIt<LocaleController>().locale.languageCode;
    super.initState();
  }

  void changeLanguage(String code) {
    _dropValue = code;
    AppInjection.getIt<LocaleController>().changeLang(code);
  }

  static final _border = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: AppColor.contentColorBlue, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    return CustomLayoutBuilder(widget: (maxWidth, maxHeight) {
      return SizedBox(
        height: 45,
        child: Row(
          children: [
            ClipOval(
              child: CustomCachedNetworkImage(
                width: AppSize.appBarHeight,
                height: AppSize.appBarHeight,
                imageUrl: getImageUserUrl(),
                errorWidget: ErrorWidgetShow.user,
              ),
            ),
            const Gap(10),
            SizedBox(
              width: min(140, AppSize.width * .22),
              child: FittedBox(
                child: Text(
                  AppLocalData.user?.username ?? '',
                  style: AppTextStyle.f14w600black,
                ),
              ),
            ),
            const Gap(15),
            if (AppSize.width > 550)
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(5),
                  value: _dropValue,
                  onChanged: (value) {
                    if (value == null) return;
                    changeLanguage(value);
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: AppConstant.en,
                      child: Text(AppText.english.tr),
                    ),
                    DropdownMenuItem<String>(
                      value: AppConstant.ar,
                      child: Text(AppText.arabic.tr),
                    ),
                  ],
                ),
              ),
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 2,
              child: TextFormField(
                controller: _controller,
                cursorColor: AppColor.secondColor,
                textDirection: getTextDirection(_controller.text),
                onChanged: (_) => setState(() {}),
                onFieldSubmitted: widget.onFieldSubmitted,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: _border,
                    focusedBorder: _border,
                    enabledBorder: _border,
                    constraints: const BoxConstraints(
                      maxHeight: AppSize.appBarHeight,
                    ),
                    prefixIcon: const IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: null,
                      icon: SvgImage(
                        path: AppSvg.search,
                        color: AppColor.contentColorBlue,
                        size: 20,
                      ),
                    )),
              ),
            ),
            const Expanded(child: SizedBox()),
            SvgPicture.asset(
              AppSvg.logo,
              width: AppSize.appBarHeight,
              height: AppSize.appBarHeight,
            )
          ],
        ),
      );
    });
  }
}

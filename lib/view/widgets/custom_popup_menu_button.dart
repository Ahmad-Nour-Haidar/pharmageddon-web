import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controllers/local_controller.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_strings.dart';
import '../../core/constant/app_svg.dart';
import '../../core/functions/functions.dart';
import '../../core/services/dependency_injection.dart';

class PopupMenuItemModel {
  final String text;
  final String value;

  PopupMenuItemModel({
    required this.text,
    required this.value,
  });
}

void showPopupMenu({
  required BuildContext context,
  required GlobalKey actionKey,
  required List<PopupMenuItemModel> list,
  required void Function(String value) onChange,
  void Function(bool value)? isOpen,
  Offset offsetVar = const Offset(10, 60),
}) {
  if (isOpen != null) {
    isOpen(true);
  }

  final renderBox = actionKey.currentContext!.findRenderObject() as RenderBox;
  final offset = renderBox.localToGlobal(offsetVar);

  final height = min(list.length * 60.0, 200.0);

  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      offset.dx,
      offset.dy,
      offset.dx + renderBox.size.width,
      offset.dy + renderBox.size.height,
    ),
    color: AppColor.buttonColor,
    constraints: BoxConstraints(
      maxWidth: ((AppSize.width - 90) / 3),
      minWidth: ((AppSize.width - 90) / 3),
      maxHeight: height,
      minHeight: height,
    ),
    items: List.generate(
      list.length,
      (index) => PopupMenuItem(
        onTap: () {
          onChange(list[index].value);
        },
        value: list[index].value,
        // child: Text(AppLocalData.monthNames[index]),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              list[index].text.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    ),
  ).then((value) {
    if (isOpen != null) {
      isOpen(false);
    }
  });
}

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    super.key,
    required this.actionKey,
    required this.list,
    required this.onChange,
    required this.color,
    required this.borderColor,
    required this.valueShow,
  });

  final GlobalKey actionKey;
  final List<PopupMenuItemModel> list;
  final void Function(String) onChange;
  final Color color, borderColor;
  final String valueShow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: actionKey,
      onTap: () {
        showPopupMenu(
          actionKey: actionKey,
          context: context,
          list: list,
          onChange: onChange,
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSize.radius10),
          border: Border.all(color: borderColor, width: 3),
        ),
        padding: const EdgeInsets.all(5),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            valueShow.tr,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomPopupMenuButtonLang extends StatefulWidget {
//   const CustomPopupMenuButtonLang({
//     super.key,
//   });
//
//   @override
//   State<CustomPopupMenuButtonLang> createState() =>
//       _CustomPopupMenuButtonLangState();
// }

// class _CustomPopupMenuButtonLangState extends State<CustomPopupMenuButtonLang> {
//   final GlobalKey actionKey = GlobalKey();
//
//   final localeController = AppDependency.getIt<LocaleController>();
//
//   bool _isOpen = false;
//
//   String get valueShow {
//     final s = isEnglish() ? AppStrings.english.tr : AppStrings.arabic.tr;
//     return '${AppStrings.language.tr} : $s';
//   }
//
//   final List<PopupMenuItemModel> list = [
//     PopupMenuItemModel(text: AppStrings.english.tr, value: 'en'),
//     PopupMenuItemModel(text: AppStrings.arabic.tr, value: 'ar'),
//   ];
//
//   void change(String codeLang) {
//     localeController.changeLang(codeLang);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 55,
//       decoration: BoxDecoration(
//         color: AppColor.backgroundCardColor,
//         borderRadius: BorderRadius.circular(AppSize.radius15),
//       ),
//       padding: const EdgeInsets.all(10),
//       child: Row(
//         children: [
//           FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Text(
//               valueShow,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 20,
//                 color: AppColor.gray,
//               ),
//             ),
//           ),
//           Spacer(key: actionKey),
//           InkWell(
//             onTap: () {
//               showPopupMenu(
//                   actionKey: actionKey,
//                   context: context,
//                   offsetVar: const Offset(10, 30),
//                   list: list,
//                   onChange: change,
//                   isOpen: (value) {
//                     setState(() {
//                       _isOpen = value;
//                     });
//                   });
//             },
//             child: SvgPicture.asset(
//               _isOpen ? AppSvg.arrowUp : AppSvg.arrowDown,
//               width: 30,
//               height: 30,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

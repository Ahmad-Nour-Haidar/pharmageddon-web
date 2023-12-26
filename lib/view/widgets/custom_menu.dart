import 'package:flutter/material.dart';
import 'package:pharmageddon_web/core/constant/app_constant.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_svg.dart';

class PopupMenuItemModel {
  final String title, value;

  PopupMenuItemModel(this.title, this.value);
}

class CustomMenu extends StatefulWidget {
  const CustomMenu({
    super.key,
    required this.title,
    required this.data,
    required this.onChange,
    required this.onTapReload,
  });

  final List<PopupMenuItemModel> data;
  final String title;
  final void Function(String value) onChange;
  final void Function() onTapReload;

  @override
  State<CustomMenu> createState() => _CustomMenuState();
}

class _CustomMenuState extends State<CustomMenu> {
  var _value = '';

  @override
  void initState() {
    initial();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomMenu oldWidget) {
    initial();
    super.didUpdateWidget(oldWidget);
  }

  void initial() {
    if (widget.data.isEmpty) return;
    setState(() {
      _value = widget.data[0].value;
      widget.onChange(_value);
    });
  }

  void onSelected(String value) {
    setState(() {
      _value = value;
    });
    widget.onChange(_value);
  }

  String get title {
    if (widget.data.isEmpty) return '';
    return widget.data.firstWhere((e) => e.value == _value).title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.contentColorBlue, width: 2),
      ),
      padding: EdgeInsets.only(
        left: AppConstant.isEnglish ? 10 : 0,
        right: AppConstant.isEnglish ? 0 : 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              minVerticalPadding: 0,
              contentPadding: AppPadding.zero,
              title: Text(
                '${widget.title} : $title',
                style: AppTextStyle.f14w600black,
              ),
              trailing: widget.data.isEmpty
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: AppColor.snackbarColor,
                        strokeWidth: 3,
                      ),
                    )
                  : Theme(
                      data: Theme.of(context).copyWith(
                        dividerTheme: const DividerThemeData(
                          color: AppColor.gray1,
                          endIndent: 8,
                          indent: 8,
                        ),
                      ),
                      child: PopupMenuButton<String>(
                        tooltip: '',
                        constraints: const BoxConstraints(
                          maxHeight: 220,
                          maxWidth: 180,
                        ),
                        itemBuilder: (context) {
                          return List.generate(
                            (widget.data.length * 2 - 1),
                            (index) {
                              if (index % 2 == 0) {
                                final i = index ~/ 2;
                                return PopupMenuItem(
                                  value: widget.data[i].value,
                                  child: Text(widget.data[i].title),
                                );
                              } else {
                                return const PopupMenuDivider();
                              }
                            },
                          );
                        },
                        onSelected: onSelected,
                      ),
                    ),
            ),
          ),
          IconButton(
            onPressed: widget.onTapReload,
            icon: const Align(
              child: SvgImage(
                path: AppSvg.rotateLeft,
                color: AppColor.snackbarColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

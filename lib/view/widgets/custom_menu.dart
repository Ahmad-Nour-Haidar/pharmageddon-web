

import 'package:flutter/material.dart';
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
    _value = widget.data[0].value;
    widget.onChange(_value);
  }

  void onSelected(String value) {
    setState(() {
      _value = value;
    });
    widget.onChange(_value);
  }

  String get title {
    if (widget.data.isEmpty) return '';
    return widget.data.firstWhere((element) => element.value == _value).title;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.data.isNotEmpty)
          Expanded(
            child: ListTile(
              contentPadding: AppPadding.zero,
              title: Text('${widget.title} : $title'),
              trailing: PopupMenuButton(
                constraints:
                const BoxConstraints(maxHeight: 220, maxWidth: 180),
                itemBuilder: (context) {
                  return List.generate(
                    widget.data.length,
                        (index) => PopupMenuItem(
                      value: widget.data[index].value,
                      child: Text(widget.data[index].title),
                    ),
                  );
                },
                onSelected: onSelected,
              ),
            ),
          ),
        IconButton(
          onPressed: widget.onTapReload,
          icon: const Align(
            child: SvgImage(
              path: AppSvg.rotateLeft,
              color: AppColor.black,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}

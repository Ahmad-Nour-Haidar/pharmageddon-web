import 'package:flutter/material.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_svg.dart';

class BuildRowEditClose extends StatelessWidget {
  const BuildRowEditClose({
    super.key,
    this.onTapClose,
    this.onTapEdit,
    this.showClose = true,
    this.showEdit = true,
  });

  final void Function()? onTapClose;
  final void Function()? onTapEdit;
  final bool showClose, showEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          if (showClose)
            Expanded(
              child: IconButton(
                  onPressed: onTapClose,
                  icon: const SvgImage(
                    path: AppSvg.close,
                    color: AppColor.contentColorBlue,
                    size: 26,
                  )),
            ),
          if (showEdit)
            Expanded(
              child: IconButton(
                onPressed: onTapEdit,
                icon: const SvgImage(
                  path: AppSvg.edit,
                  color: AppColor.contentColorBlue,
                  size: 26,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

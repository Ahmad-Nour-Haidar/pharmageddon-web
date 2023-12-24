import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_svg.dart';

enum ErrorWidgetShow { user, picture }

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.errorWidget,
  });

  final double width, height;
  final String imageUrl;
  final ErrorWidgetShow errorWidget;

  Widget get errorWidgetImp {
    final s = min(width / 2, height / 2);
    late String path;
    if (errorWidget == ErrorWidgetShow.picture) {
      path = AppSvg.picture;
    } else {
      path = AppSvg.user;
    }
    final widget = Container(
      width: s,
      height: s,
      decoration: BoxDecoration(
        color: AppColor.gray4,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        child: SvgImage(
          path: path,
          color: AppColor.white,
          size: s,
        ),
      ),
    );
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    final s = min(width / 2, height / 2);
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: CachedNetworkImage(
        httpHeaders: const {
          "Connection": "Keep-Alive",
          "Keep-Alive": "timeout=5",
        },
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: s,
            height: s,
            child: const CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ),
        fit: BoxFit.cover,
        width: width,
        imageUrl: imageUrl,
        errorWidget: (context, url, error) {
          return errorWidgetImp;
        },
      ),
    );
  }
}

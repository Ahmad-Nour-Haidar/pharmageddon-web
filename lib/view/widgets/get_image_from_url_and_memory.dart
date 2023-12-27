import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_svg.dart';
import 'custom_cached_network_image.dart';

class GetImageFromUrlAndMemory extends StatelessWidget {
  const GetImageFromUrlAndMemory({
    super.key,
    required this.url,
    required this.size,
    required this.callUrl,
    this.onTap,
    this.webImage,
    this.defaultImage = AppSvg.picture,
  });

  final String url, defaultImage;
  final double size;
  final void Function()? onTap;
  final Uint8List? webImage;
  final bool callUrl;

  @override
  Widget build(BuildContext context) {
    Widget image = Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColor.gray4,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        child: SvgImage(
          path: defaultImage,
          color: AppColor.white,
          size: size / 2,
        ),
      ),
    );

    if (callUrl) {
      image = CustomCachedNetworkImage(
        width: double.infinity,
        height: size,
        imageUrl: url,
        errorWidget: ErrorWidgetShow.picture,
      );
    }
    if (webImage != null) {
      image = Image.memory(
        webImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 200,
      );
    }

    return Align(
      child: SizedBox(
        width: size,
        height: size,
        child: InkWell(
          onTap: onTap,
          child: image,
        ),
      ),
    );
  }
}

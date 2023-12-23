import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BuildRow extends StatelessWidget {
  const BuildRow({
    super.key,
    required this.widget1,
    required this.widget2,
  });

  final Widget widget1, widget2;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: widget1,
          ),
        ),
        const Gap(10),
        Expanded(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: widget2,
          ),
        ),
      ],
    );
  }
}

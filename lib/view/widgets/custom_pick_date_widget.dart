import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_constant.dart';
import '../../core/constant/app_padding.dart';
import '../../core/constant/app_text.dart';
import '../../core/constant/app_svg.dart';
import '../../core/functions/functions.dart';
import '../../core/resources/app_text_theme.dart';

class CustomPickDateWidget extends StatelessWidget {
  const CustomPickDateWidget({
    super.key,
    required this.onChange,
    required this.dateTimeRange,
    required this.onTapSend,
  });

  final void Function(DateTimeRange dateTimeRange) onChange;
  final void Function() onTapSend;
  final DateTimeRange dateTimeRange;

  String get textStart {
    var s = AppText.start.tr;
    if (dateTimeRange.duration.inDays > 0) {
      s = formatYYYYMd(dateTimeRange.start.toString());
    }
    return s;
  }

  String get textEnd {
    var s = AppText.end.tr;
    if (dateTimeRange.duration.inDays > 0) {
      s = formatYYYYMd(dateTimeRange.end.toString());
    }
    return s;
  }

  void show(BuildContext context) async {
    final results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        cancelButtonTextStyle: AppTextStyle.f14w600red,
        okButtonTextStyle: AppTextStyle.f14w600green,
      ),
      dialogSize: const Size(350, 400),
      borderRadius: BorderRadius.circular(10),
    );
    if (results != null) {
      final now = DateTime.now();
      final s = results.isNotEmpty && results[0] != null ? results[0]! : now;
      final e = results.length > 1 && results[1] != null ? results[1]! : now;
      final timeRange = DateTimeRange(start: s, end: e);
      onChange(timeRange);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => show(context),
            child: Tooltip(
              message: AppText.selectStartDateAndEndDateOfReport.tr,
              preferBelow: false,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: AppPadding.padding10,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        textStart,
                        style: AppTextStyle.f18w500black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SvgImage(
                      path: AppConstant.isEnglish
                          ? AppSvg.arrowFillRight
                          : AppSvg.arrowFillLeft,
                      color: AppColor.green2,
                      size: 32,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: AppPadding.padding10,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        textEnd,
                        style: AppTextStyle.f18w500black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: onTapSend,
          child: FittedBox(
            child: Text(
              AppText.send.tr,
              style: AppTextStyle.f16w600primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

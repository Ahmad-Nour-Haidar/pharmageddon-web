import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_web/print.dart';
import 'package:pharmageddon_web/view/widgets/rich_text_span.dart';
import '../../controllers/reports_cubit/reports_cubit.dart';
import '../../controllers/reports_cubit/reports_state.dart';
import '../../core/constant/app_text.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/app_widget.dart';
import '../widgets/custom_pick_date_widget.dart';
import '../widgets/handle_state.dart';
import '../widgets/loading/order_loading.dart';
import '../widgets/order/order_widget.dart';
import 'flow_chart.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<ReportsCubit>(),
      child: BlocConsumer<ReportsCubit, ReportsState>(
        listener: (context, state) {
          if (state is ReportsFailureState) {
            handleState(state: state.state, context: context);
          }
        },
        builder: (context, state) {
          final cubit = ReportsCubit.get(context);
          Widget body = AppInjection.getIt<AppWidget>().reports;
          printme.green(cubit.isChart);
          printme.green(state);
          if (state is ReportsLoadingState) {
            body = const OrdersLoading();
          } else if (cubit.isChart) {
            body = FlowChart(data: cubit.data);
          } else if (state is ReportsSuccessState || cubit.data.isNotEmpty) {
            body = OrderListWidget(data: cubit.data);
          }
          return Column(
            children: [
              CustomPickDateWidget(
                onChange: cubit.setDateTimeRange,
                dateTimeRange: cubit.dateTimeRange,
                onTapSend: cubit.getData,
                onTapChart: cubit.changeChart,
              ),
              Expanded(child: body),
              SizedBox(
                height: 25,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RichTextSpan(
                          s1: '${AppText.totalOrders.tr} : ',
                          ts1: AppTextStyle.f15w600black,
                          s2: AppText.format(cubit.data.length).toString().trn,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RichTextSpan(
                          s1: '${AppText.totalQuantity.tr} : ',
                          ts1: AppTextStyle.f15w600black,
                          s2: AppText.format(cubit.totalQuantity)
                              .toString()
                              .trn,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RichTextSpan(
                          s1: '${AppText.totalPrice.tr} : ',
                          ts1: AppTextStyle.f15w600black,
                          s2: '${AppText.format(cubit.totalPrice)} ${AppText.sp.tr}'
                              .trn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// 45 app bar
// 10
// 45 pick
// 25 bottom

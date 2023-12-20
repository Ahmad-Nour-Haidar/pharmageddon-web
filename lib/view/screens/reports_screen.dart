import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import '../../controllers/reports_cubit/reports_cubit.dart';
import '../../controllers/reports_cubit/reports_state.dart';
import '../../core/constant/app_text.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/app_widget.dart';
import '../widgets/custom_pick_date_widget.dart';
import '../widgets/handle_state.dart';
import '../widgets/loading/reports_loading.dart';
import '../widgets/report_widget.dart';
import '../widgets/row_text_span.dart';

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
          if (state is ReportsSuccessState || cubit.data.isNotEmpty) {
            body = ReportListWidget(
              data: cubit.data,
              canPushNamed: false,
            );
          }
          if (state is ReportsLoadingState) {
            body = const OrdersLoading();
          }
          return Column(
            children: [
              CustomPickDateWidget(
                onChange: cubit.setDateTimeRange,
                dateTimeRange: cubit.dateTimeRange,
                onTapSend: () => cubit.getData(),
              ),
              const Gap(10),
              Expanded(child: body),
              const Gap(5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: RowTextSpan(
                      s1: '${AppText.totalOrders.tr} : ',
                      ts1: AppTextStyle.f15w600black,
                      s2: cubit.data.length.toString().trn,
                    ),
                  ),
                  Expanded(
                    child: RowTextSpan(
                      s1: '${AppText.totalQuantity.tr} : ',
                      ts1: AppTextStyle.f15w600black,
                      s2: cubit.totalQuantity.toString().trn,
                    ),
                  ),
                  Expanded(
                    child: RowTextSpan(
                      s1: '${AppText.totalPrice.tr} : ',
                      ts1: AppTextStyle.f15w600black,
                      s2: '${cubit.totalPrice} ${AppText.sp.tr}'.trn,
                    ),
                  ),
                ],
              ),
              const Gap(5),
            ],
          );
        },
      ),
    );
  }
}

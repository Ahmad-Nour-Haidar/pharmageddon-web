import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/orders_cubit/orders_cubit.dart';
import 'package:pharmageddon_web/controllers/orders_cubit/orders_state.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import '../../core/constant/app_text.dart';
import '../../core/enums/drawer_enum.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/app_widget.dart';
import '../widgets/handle_state.dart';
import '../widgets/loading/order_loading.dart';
import '../widgets/order_widget.dart';
import '../widgets/rich_text_span.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({
    super.key,
    required this.currentScreen,
  });

  final ScreenView currentScreen;

  @override
  Widget build(BuildContext context) {
    final cubit = OrdersCubit.get(context);
    cubit.getData(currentScreen);
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is OrdersFailureState) {
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        Widget body = AppInjection.getIt<AppWidget>().reports;
        if (state is OrdersSuccessState || cubit.data.isNotEmpty) {
          body = OrderListWidget(
            data: cubit.data,
            onTap: (model) {},
          );
        }
        if (state is OrdersLoadingState) {
          body = const OrdersLoading();
        }
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(child: body),
                  const Gap(5),
                  Row(
                    children: [
                      Expanded(
                        child: RichTextSpan(
                          s1: '${AppText.totalOrders.tr} : ',
                          ts1: AppTextStyle.f15w600black,
                          s2: cubit.data.length.toString().trn,
                        ),
                      ),
                      Expanded(
                        child: RichTextSpan(
                          s1: '${AppText.totalQuantity.tr} : ',
                          ts1: AppTextStyle.f15w600black,
                          s2: cubit.totalQuantity.toString().trn,
                        ),
                      ),
                      Expanded(
                        child: RichTextSpan(
                          s1: '${AppText.totalPrice.tr} : ',
                          ts1: AppTextStyle.f15w600black,
                          s2: '${cubit.totalPrice} ${AppText.sp.tr}'.trn,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

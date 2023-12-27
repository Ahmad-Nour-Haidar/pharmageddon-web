import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/orders_cubit/orders_cubit.dart';
import 'package:pharmageddon_web/controllers/orders_cubit/orders_state.dart';
import 'package:pharmageddon_web/core/extensions/translate_numbers.dart';
import 'package:pharmageddon_web/view/screens/order_details_screen.dart';
import '../../core/constant/app_text.dart';
import '../../core/enums/drawer_enum.dart';
import '../../core/resources/app_text_theme.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/app_widget.dart';
import '../widgets/handle_state.dart';
import '../widgets/info_widget.dart';
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
        Widget body = AppInjection.getIt<AppWidget>().order;
        if (state is OrdersSuccessState || cubit.data.isNotEmpty) {
          body = OrderListWidget(
            data: cubit.data,
            onTap: cubit.showOrder,
          );
        }
        if (state is OrdersLoadingState) {
          body = const OrdersLoading();
        }
        return Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: body),
                  RichTextSpan(
                    s1: '${AppText.totalOrders.tr} : ',
                    s2: cubit.data.length.toString().trn,
                  ),
                  RichTextSpan(
                    s1: '${AppText.totalQuantity.tr} : ',
                    s2: cubit.totalQuantity.toString().trn,
                  ),
                  RichTextSpan(
                    s1: '${AppText.totalPrice.tr} : ',
                    s2: '${cubit.totalPrice} ${AppText.sp.tr}'.trn,
                  ),
                ],
              ),
            ),
            ...List.generate(
              cubit.showingOrders.length,
              (index) => cubit.showingOrders[index] == null
                  ? const SizedBox()
                  : Expanded(
                      flex: 2,
                      child: OrderDetailsScreen(
                        orderModel: cubit.showingOrders[index]!,
                        onTapClose: () => cubit.closeModel(index),
                        onSuccess: () => cubit.getData(
                          currentScreen,
                          forceGat: true,
                        ),
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/view/widgets/build_row_edit_close.dart';
import '../../controllers/order_details_cubit/order_details_cubit.dart';
import '../../controllers/order_details_cubit/order_details_state.dart';
import '../../core/constant/app_color.dart';
import '../../model/order_model.dart';
import '../widgets/handle_state.dart';
import '../widgets/order_details_widget.dart';
import '../widgets/top_widget_order_details_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orderModel,
    required this.onTapClose,
  });

  final OrderModel orderModel;
  final void Function() onTapClose;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppInjection.getIt<OrderDetailsCubit>()..initial(orderModel),
      child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) {
          if (state is OrderDetailsFailureState) {
            handleState(state: state.state, context: context);
          } else if (state is OrderDetailsDeleteMedicineSuccessState) {
            handleState(state: state.state, context: context);
          } else if (state is OrderDetailsUpdateOrderSuccessState) {
            handleState(state: state.state, context: context);
          }
        },
        builder: (context, state) {
          final cubit = OrderDetailsCubit.get(context);
          if (cubit.model.id != orderModel.id) {
            cubit.initial(orderModel);
          }
          return Container(
            decoration: const BoxDecoration(
              color: AppColor.background,
            ),
            child: Column(
              children: [
                BuildRowEditClose(
                  onTapClose: onTapClose,
                  showEdit: false,
                ),
                TopWidgetOrderDetailsScreen(
                  model: cubit.model,
                ),
                if (state is OrderDetailsGetLoadingState)
                  const Expanded(
                      child: Center(
                          child: SpinKitFoldingCube(
                              color: AppColor.primaryColor))),
                if (state is! OrderDetailsGetLoadingState)
                  OrderDetailsList(data: cubit.data),
              ],
            ),
          );
        },
      ),
    );
  }
}

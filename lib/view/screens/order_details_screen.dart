import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmageddon_web/core/constant/app_constant.dart';
import 'package:pharmageddon_web/core/constant/app_padding.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/view/widgets/build_row_edit_close.dart';
import '../../controllers/order_details_cubit/order_details_cubit.dart';
import '../../controllers/order_details_cubit/order_details_state.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_svg.dart';
import '../../model/order_model.dart';
import '../widgets/order/buttons_order_details.dart';
import '../widgets/handle_state.dart';
import '../widgets/order/order_details_widget.dart';
import '../widgets/svg_image.dart';
import '../widgets/order/top_widget_order_details_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orderModel,
    required this.onTapClose,
    required this.onSuccess,
  });

  final OrderModel orderModel;
  final void Function() onTapClose;
  final void Function() onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppInjection.getIt<OrderDetailsCubit>()..initial(orderModel),
      child: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) {
          if (state is OrderDetailsFailureState) {
            handleState(state: state.state, context: context);
          }
          if (state is OrderUpdateFailureState) {
            handleState(
                state: state.state,
                context: context,
                onOk: () {
                  onSuccess();
                  onTapClose();
                });
          }
          if (state is OrderUpdateStatusSuccessState) onSuccess();
          if (state is OrderDetailsCancelSuccessState) onSuccess();
          if (state is OrderUpdatePaymentStatusSuccessState) onSuccess();
        },
        builder: (context, state) {
          final cubit = OrderDetailsCubit.get(context);
          return Container(
            padding: AppPadding.padding10,
            decoration: const BoxDecoration(
              color: AppColor.cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                BuildRowEditClose(onTapClose: onTapClose, showEdit: false),
                TopWidgetOrderDetailsScreen(model: cubit.model),
                if (cubit.data.isNotEmpty &&
                    state is! OrderGetDetailsLoadingState)
                  ButtonsOrderDetails(
                    model: cubit.model,
                    onTapSend: () =>
                        cubit.updateOrderStatus(AppConstant.has_been_sent),
                    onTapReceivedDone: () =>
                        cubit.updateOrderStatus(AppConstant.received),
                    onTapPaid: cubit.updatePaymentStatus,
                    onTapCancel: cubit.cancelOrder,
                    isLoadingSend: state is OrderUpdateStatusLoadingState,
                    isLoadingReceivedDone:
                        state is OrderUpdateStatusLoadingState,
                    isLoadingPaid: state is OrderUpdatePaymentStatusLadingState,
                    isLoadingCancel: state is OrderDetailsCancelLoadingState,
                  ),
                if (cubit.data.isEmpty && state is! OrderGetDetailsLoadingState)
                  IconButton(
                    onPressed: cubit.getDetails,
                    icon: const Align(
                      child: SvgImage(
                        path: AppSvg.rotateLeft,
                        color: AppColor.snackbarColor,
                        size: 18,
                      ),
                    ),
                  ),
                if (state is OrderGetDetailsLoadingState)
                  const Expanded(
                    child: Center(
                      child: SpinKitFoldingCube(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                if (state is! OrderGetDetailsLoadingState)
                  OrderDetailsList(data: cubit.data),
              ],
            ),
          );
        },
      ),
    );
  }
}

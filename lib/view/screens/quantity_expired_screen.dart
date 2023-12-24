import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/home/medication_widget.dart';
import 'package:pharmageddon_web/view/widgets/loading/medications_loading.dart';
import '../../controllers/quantity_expired_cubit/quantity_expired_cubit.dart';
import '../../controllers/quantity_expired_cubit/quantity_expired_state.dart';
import '../../core/constant/app_color.dart';
import 'medication_details_screen.dart';

class QuantityExpiredScreen extends StatelessWidget {
  const QuantityExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuantityExpiredCubit>(
      create: (context) =>
          AppInjection.getIt<QuantityExpiredCubit>()..initial(),
      child: BlocConsumer<QuantityExpiredCubit, QuantityExpiredState>(
        listener: (context, state) {
          if (state is QuantityExpiredFailureState) {
            handleState(state: state.state, context: context);
          }
        },
        builder: (context, state) {
          final cubit = QuantityExpiredCubit.get(context);
          Widget body = MedicationsListWidget(
            data: cubit.medications,
            onTapCard: cubit.showDetailsModel,
          );
          if (state is QuantityExpiredLoadingState) {
            body = const MedicationsLoading();
          }
          return Row(
            children: [
              Expanded(child: body),
              if (cubit.showMedicationModelDetails)
                const VerticalDivider(color: AppColor.gray1),
              if (cubit.showMedicationModelDetails)
                Expanded(
                  child: MedicationDetailsScreen(
                    medicationModel: cubit.medicationModel,
                    onTapClose: cubit.closeDetailsModel,
                    onSuccess: cubit.getData,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

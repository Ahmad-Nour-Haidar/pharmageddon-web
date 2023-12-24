import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/date_expired_cubit/date_expired_cubit.dart';
import '../../controllers/date_expired_cubit/date_expired_state.dart';
import '../../core/constant/app_color.dart';
import '../../core/services/dependency_injection.dart';
import '../widgets/handle_state.dart';
import '../widgets/home/medication_widget.dart';
import '../widgets/loading/medications_loading.dart';
import 'medication_details_screen.dart';

class DateExpiredScreen extends StatelessWidget {
  const DateExpiredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DateExpiredCubit>(
      create: (context) => AppInjection.getIt<DateExpiredCubit>()..initial(),
      child: BlocConsumer<DateExpiredCubit, DateExpiredState>(
        listener: (context, state) {
          if (state is DateExpiredFailureState) {
            handleState(state: state.state, context: context);
          }
        },
        builder: (context, state) {
          final cubit = DateExpiredCubit.get(context);
          Widget body = MedicationsListWidget(
            data: cubit.medications,
            onTapCard: cubit.showDetailsModel,
          );
          if (state is DateExpiredLoadingState) {
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

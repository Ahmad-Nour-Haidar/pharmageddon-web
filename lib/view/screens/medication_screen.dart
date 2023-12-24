import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/home/medication_widget.dart';
import 'package:pharmageddon_web/view/widgets/loading/medications_loading.dart';

import '../../controllers/medication_cubit/medication_cubit.dart';
import '../../controllers/medication_cubit/medication_state.dart';
import '../../core/constant/app_color.dart';
import 'medication_details_screen.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final cubit = MedicationCubit.get(context);
    cubit.initial(url);
    return BlocConsumer<MedicationCubit, MedicationState>(
      listener: (context, state) {
        if (state is MedicationFailureState) {
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        Widget body = MedicationsListWidget(
          data: cubit.medications,
          onTapCard: cubit.showDetailsModel,
        );
        if (state is MedicationLoadingState) {
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
                  onSuccess: () => cubit.getData(url),
                ),
              ),
          ],
        );
      },
    );
  }
}

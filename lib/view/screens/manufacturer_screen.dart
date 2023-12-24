import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';

import '../../controllers/manufacturer_cubit/manufacturer_cubit.dart';
import '../../controllers/manufacturer_cubit/manufacturer_state.dart';
import '../../core/constant/app_color.dart';
import '../widgets/loading/manufacturers_loading.dart';
import '../widgets/manufacturers_widget.dart';
import 'medication_screen.dart';

class ManufacturerScreen extends StatelessWidget {
  const ManufacturerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = ManufacturerCubit.get(context);
    cubit.initial();
    return BlocConsumer<ManufacturerCubit, ManufacturerState>(
      listener: (context, state) {
        if (state is ManufacturerFailureState) {
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        Widget body = ManufacturersListWidget(
          data: cubit.manufacturers,
          onTapCard: cubit.showDetailsModel,
        );
        if (state is ManufacturerLoadingState) {
          body = const ManufacturersLoading();
        }
        return Row(
          children: [
            Expanded(child: body),
            if (cubit.showManufacturerModelDetails)
              const VerticalDivider(color: AppColor.gray1),
            if (cubit.showManufacturerModelDetails)
              Expanded(
                flex: 2,
                child: MedicationScreen(url: cubit.getUrl),
              ),
          ],
        );
      },
    );
  }
}

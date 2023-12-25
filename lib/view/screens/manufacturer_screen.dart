import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_web/view/widgets/build_row_edit_close.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/manufacturer/manufacturer_input_form.dart';

import '../../controllers/manufacturer_cubit/manufacturer_cubit.dart';
import '../../controllers/manufacturer_cubit/manufacturer_state.dart';
import '../../core/constant/app_color.dart';
import '../widgets/loading/manufacturers_loading.dart';
import '../widgets/manufacturer/manufacturers_widget.dart';
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
        } else if (state is ManufacturerEditSuccessState) {
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        Widget body = ManufacturersListWidget(
          data: cubit.manufacturers,
          onTapCard: cubit.showMedicinesOfModel,
        );
        if (state is ManufacturerLoadingState) {
          body = const ManufacturersLoading();
        }
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (cubit.showDetailsManufacturerModel)
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: 500,
                        child: Column(
                          children: [
                            BuildRowEditClose(
                              onTapClose: cubit.closeDetailsModel,
                              showEdit: false,
                            ),
                            Expanded(
                              child: ManufacturerInputForm(
                                manufacturerModel: cubit.manufacturerModel,
                                onTapButton: cubit.updateManufacturer,
                                isLoading:
                                    state is ManufacturerEditLoadingState,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  const Gap(10),
                  Expanded(flex: 3, child: body),
                ],
              ),
            ),
            if (cubit.showMedicinesManufacturerModel)
              const VerticalDivider(color: AppColor.gray1),
            if (cubit.showMedicinesManufacturerModel)
              Expanded(
                flex: 2,
                child: MedicationScreen(url: cubit.getUrlMedicinesModel),
              ),
          ],
        );
      },
    );
  }
}

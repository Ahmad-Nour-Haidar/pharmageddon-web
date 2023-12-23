import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/search_cubit/search_cubit.dart';
import 'package:pharmageddon_web/controllers/search_cubit/search_state.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/home/medication_widget.dart';
import 'package:pharmageddon_web/view/widgets/loading/medications_loading.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_text.dart';
import '../../core/resources/app_text_theme.dart';
import '../widgets/app_widget.dart';
import 'medication_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    final cubit = SearchCubit.get(context);
    cubit.search(value);
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is SearchFailureState) {
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        Widget body = MedicationsListWidget(
          data: cubit.medications,
          onTapCard: cubit.showDetailsModel,
        );
        if (cubit.medications.isEmpty) {
          body = AppInjection.getIt<AppWidget>().noDataAfterSearch;
        }
        if (state is SearchLoadingState) {
          body = const MedicationsLoading();
        }
        final s = '${AppText.searchResultsFor.tr} : ${cubit.valueSearch}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s,
              style: AppTextStyle.f18w500black,
              maxLines: 1,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: body),
                  if (cubit.showMedicationModelDetails)
                    const VerticalDivider(color: AppColor.gray1),
                  if (cubit.showMedicationModelDetails)
                    Expanded(
                      child: MedicationDetailsScreen(
                        medicationModel: cubit.medicationModel,
                        onTapClose: cubit.closeDetailsModel,
                        onSuccess: () {
                          // cubit.getData();
                        },
                        onDelete: () {},
                      ),
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

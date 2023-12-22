import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/home/medication_widget.dart';
import 'package:pharmageddon_web/view/widgets/loading/medications_loading.dart';

import '../../controllers/discounts_cubit/discounts_cubit.dart';
import '../../controllers/discounts_cubit/discounts_state.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DiscountsCubit>(
      create: (context) => AppInjection.getIt<DiscountsCubit>()..initial(),
      child: BlocConsumer<DiscountsCubit, DiscountsState>(
        listener: (context, state) {
          if (state is DiscountsFailureState) {
            handleState(state: state.state, context: context);
          }
        },
        builder: (context, state) {
          final cubit = DiscountsCubit.get(context);
          Widget body = MedicationsListWidget(
            data: cubit.medications,
            onTapCard: (model, tag) {
              AppInjection.getIt<HomeCubit>().onTapCard(
                model: model,
                uniqueKey: tag,
              );
            },
          );
          if (state is DiscountsLoadingState) {
            body = MedicationsLoading(onRefresh: () async => cubit.getData());
          }
          return body;
        },
      ),
    );
  }
}

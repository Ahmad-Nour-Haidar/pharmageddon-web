import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_web/controllers/search_cubit/search_cubit.dart';
import 'package:pharmageddon_web/controllers/search_cubit/search_state.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/print.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/home/medication_widget.dart';
import 'package:pharmageddon_web/view/widgets/loading/medications_loading.dart';

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
          onRefresh: () async => cubit.search(value),
          onTapCard: AppInjection.getIt<HomeCubit>().onTapCard,
        );
        if (state is SearchLoadingState) {
          body = MedicationsLoading(onRefresh: () async => cubit.search(value));
        }
        return body;
      },
    );
  }
}

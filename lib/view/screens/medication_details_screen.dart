import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_web/controllers/home_cubit/home_cubit.dart';
import 'package:pharmageddon_web/controllers/medication_details_cubit/medication_details_cubit.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/constant/app_svg.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/model/medication_model.dart';
import 'package:pharmageddon_web/view/widgets/custom_cached_network_image.dart';
import 'package:pharmageddon_web/view/widgets/handle_state.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';

import '../../controllers/medication_details_cubit/medication_details_state.dart';

class MedicationDetailsScreen extends StatelessWidget {
  const MedicationDetailsScreen({
    super.key,
    required this.medicationModel,
    required this.tag,
  });

  final MedicationModel medicationModel;
  final UniqueKey tag;
  static final _border = OutlineInputBorder(
    gapPadding: 5,
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: AppColor.contentColorBlue, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    AppInjection.getIt<MedicationDetailsCubit>().initial(medicationModel);
    return BlocConsumer<MedicationDetailsCubit, MedicationDetailsState>(
      listener: (context, state) {
        if (state is MedicationDetailsFailureState) {
          handleState(state: state.state, context: context);
        }
      },
      builder: (context, state) {
        final cubit = MedicationDetailsCubit.get(context);
        return ListView(
          children: <Widget>[
            buildRowTop(),
            image(cubit),
            const Gap(15),
            TextFormField(
              inputFormatters: const [],
              decoration: InputDecoration(
                labelText: 'Ahmad',
                contentPadding: const EdgeInsets.all(10),
                border: _border,
                focusedBorder: _border,
                enabledBorder: _border,
              ),
            ),
          ],
        );
      },
    );
  }

  Row image(MedicationDetailsCubit cubit) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        Expanded(
          flex: 3,
          child: Hero(
            tag: tag,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: cubit.imageShow != null
                  ? Image.memory(
                      cubit.imageShow!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    )
                  : CustomCachedNetworkImage(
                      width: double.infinity,
                      height: 200,
                      imageUrl: getUrlImageMedication(cubit.model),
                      errorWidget: ErrorWidgetShow.picture,
                    ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }

  Row buildRowTop() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              AppInjection.getIt<HomeCubit>().closeMedicationModelDetails();
            },
            icon: const SvgImage(
              path: AppSvg.close,
              color: AppColor.contentColorBlue,
              size: 30,
            )),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: const SvgImage(
              path: AppSvg.edit,
              color: AppColor.contentColorBlue,
              size: 30,
            )),
      ],
    );
  }
}

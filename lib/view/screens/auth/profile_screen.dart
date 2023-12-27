import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/constant/app_constant.dart';
import 'package:pharmageddon_web/core/constant/app_local_data.dart';
import 'package:pharmageddon_web/core/constant/app_size.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/core/functions/navigator.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/routes.dart';
import 'package:pharmageddon_web/view/widgets/custom_button.dart';
import 'package:pharmageddon_web/view/widgets/custom_text_form_field.dart';

import '../../../controllers/auth/register_cubit/register_cubit.dart';
import '../../../controllers/auth/register_cubit/register_state.dart';
import '../../../core/class/validation.dart';
import '../../../core/constant/app_svg.dart';
import '../../widgets/custom_cached_network_image.dart';
import '../../widgets/custom_layout_builder.dart';
import '../../widgets/custom_other_auth.dart';
import '../../widgets/handle_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is RegisterSuccessState) {
            pushNamed(AppRoute.verifyCode, context);
          }
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);
          return CustomLayoutBuilder(
            widget: (maxWidth, maxHeight) {
              return ListView(
                children: [
                  Row(
                    children: [
                      const Expanded(child: SizedBox()),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ClipOval(
                                child: CustomCachedNetworkImage(
                                  width: 200,
                                  height: 200,
                                  imageUrl: getImageUserUrl(),
                                  errorWidget: ErrorWidgetShow.user,
                                ),
                              ),
                            ),
                            const Gap(15),
                            // email
                            SelectableText(
                              AppLocalData.user?.email ?? AppText.email.tr,
                              style: AppTextStyle.f18w600black,
                            ),
                            const Gap(10),
                            // phone
                            CustomTextFormField(
                              controller: cubit.phoneController,
                              keyboardType: TextInputType.phone,
                              validator: ValidateInput.isPhone,
                              textInputAction: TextInputAction.next,
                              fillColor: AppColor.transparent,
                              colorPrefixIcon: AppColor.gray,
                              prefixIcon: AppSvg.phone,
                              labelText: AppText.phoneNumber.tr,
                            ),
                            const Gap(10),
                            // user name
                            CustomTextFormField(
                              controller: cubit.userNameController,
                              keyboardType: TextInputType.name,
                              validator: ValidateInput.isUsername,
                              textInputAction: TextInputAction.next,
                              fillColor: AppColor.transparent,
                              colorPrefixIcon: AppColor.gray,
                              prefixIcon: AppSvg.user,
                              labelText: AppText.userName.tr,
                            ),
                            const Gap(10),
                            // address
                            CustomTextFormField(
                              controller: cubit.addressController,
                              keyboardType: TextInputType.text,
                              validator: ValidateInput.isAddress,
                              textInputAction: TextInputAction.next,
                              fillColor: AppColor.transparent,
                              colorPrefixIcon: AppColor.gray,
                              prefixIcon: AppSvg.marker,
                              labelText: AppText.address.tr,
                            ),
                            const Gap(15),
                            if (state is RegisterLoadingState)
                              const SpinKitThreeBounce(
                                color: AppColor.primaryColor,
                              ),
                            if (state is! RegisterLoadingState)
                              CustomButton(
                                onTap: cubit.register,
                                text: AppText.createAccount.tr,
                              ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

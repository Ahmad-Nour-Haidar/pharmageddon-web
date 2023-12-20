import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/functions/navigator.dart';
import 'package:pharmageddon_web/routes.dart';
import '../../../controllers/auth/check_email_cubit/check_email_cubit.dart';
import '../../../controllers/auth/check_email_cubit/check_email_state.dart';
import '../../../core/class/validation.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_layout_builder.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/handle_state.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<CheckEmailCubit>(),
      child: BlocConsumer<CheckEmailCubit, CheckEmailState>(
        listener: (context, state) {
          if (state is CheckEmailFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is CheckEmailSuccessState) {
            pushNamed(AppRoute.resetPassword, context);
          }
        },
        builder: (context, state) {
          final cubit = CheckEmailCubit.get(context);
          return CustomLayoutBuilder(
            widget: (maxWidth, maxHeight) {
              // printme.cyan(maxWidth);
              // printme.cyan(maxHeight);
              return Scaffold(
                body: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      height: maxHeight,
                      width: maxWidth,
                      child: SvgPicture.asset(
                        AppSvg.background,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 45),
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: maxWidth * .06,
                                vertical: 30.0,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius:
                                    BorderRadius.circular(AppSize.radius20),
                              ),
                              child: Form(
                                key: cubit.formKey,
                                child: ListView(
                                  children: [
                                    SelectableText(
                                      AppText.checkEmail.tr,
                                      style: AppTextStyle.f26w600black,
                                    ),
                                    const Gap(25),
                                    // email
                                    CustomTextFormField(
                                      controller: cubit.emPHController,
                                      keyboardType: TextInputType.text,
                                      validator: (v) {
                                        final e = ValidateInput.isEmail(v);
                                        final p = ValidateInput.isPhone(v);
                                        if (e == null || p == null) return null;
                                        return AppText.emailOrPhoneNotValid.tr;
                                      },
                                      textInputAction: TextInputAction.next,
                                      fillColor: AppColor.transparent,
                                      colorPrefixIcon: AppColor.gray,
                                      prefixIcon: AppSvg.email,
                                      hintText: AppText.emailOrPhone.tr,
                                    ),
                                    const Gap(15),
                                    if (state is CheckEmailLoadingState)
                                      const SpinKitThreeBounce(
                                        color: AppColor.primaryColor,
                                      ),
                                    if (state is! CheckEmailLoadingState)
                                      CustomButton(
                                        onTap: cubit.check,
                                        text: AppText.check.tr,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    AppSvg.logo,
                                    width: 150,
                                    height: 150,
                                  ),
                                ),
                                const Gap(20),
                                Center(
                                  child: SelectableText(
                                    'Pharmageddon',
                                    style: AppTextStyle.f24w600SecondColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

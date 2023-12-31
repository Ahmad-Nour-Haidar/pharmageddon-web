import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/constant/app_size.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
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
import '../../../core/functions/functions.dart';
import '../../widgets/custom_layout_builder.dart';
import '../../widgets/custom_other_auth.dart';
import '../../widgets/handle_state.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                                    Text(
                                      AppText.createAccount.tr,
                                      style: AppTextStyle.f26w600black,
                                    ),
                                    const Gap(25),
                                    // email
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextFormField(
                                            controller: cubit.emailController,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validator: ValidateInput.isEmail,
                                            textInputAction:
                                                TextInputAction.next,
                                            fillColor: AppColor.transparent,
                                            colorPrefixIcon: AppColor.gray,
                                            prefixIcon: AppSvg.email,
                                            labelText: AppText.email.tr,
                                          ),
                                        ),
                                        const Gap(10),
                                        // phone
                                        Expanded(
                                          child: CustomTextFormField(
                                            controller: cubit.phoneController,
                                            keyboardType: TextInputType.phone,
                                            validator: ValidateInput.isPhone,
                                            textInputAction:
                                                TextInputAction.next,
                                            fillColor: AppColor.transparent,
                                            colorPrefixIcon: AppColor.gray,
                                            prefixIcon: AppSvg.phone,
                                            labelText: AppText.phoneNumber.tr,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(10),
                                    // user name
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextFormField(
                                            controller:
                                                cubit.userNameController,
                                            keyboardType: TextInputType.name,
                                            validator: ValidateInput.isUsername,
                                            textInputAction:
                                                TextInputAction.next,
                                            fillColor: AppColor.transparent,
                                            colorPrefixIcon: AppColor.gray,
                                            prefixIcon: AppSvg.user,
                                            labelText: AppText.userName.tr,
                                          ),
                                        ),
                                        const Gap(10),
                                        // address
                                        Expanded(
                                          child: CustomTextFormField(
                                            controller: cubit.addressController,
                                            keyboardType: TextInputType.text,
                                            validator: ValidateInput.isAddress,
                                            textInputAction:
                                                TextInputAction.next,
                                            fillColor: AppColor.transparent,
                                            colorPrefixIcon: AppColor.gray,
                                            prefixIcon: AppSvg.marker,
                                            labelText: AppText.address.tr,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(10),
                                    // password
                                    CustomTextFormField(
                                      controller: cubit.passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: ValidateInput.isPassword,
                                      textInputAction: TextInputAction.done,
                                      fillColor: AppColor.transparent,
                                      colorPrefixIcon: AppColor.gray,
                                      prefixIcon: AppSvg.eye,
                                      labelText: AppText.password.tr,
                                      suffixIcon: cubit.obscureText
                                          ? AppSvg.eye
                                          : AppSvg.eyeClose,
                                      onTapSuffix: cubit.showPassword,
                                      obscureText: cubit.obscureText,
                                    ),
                                    const Gap(15),
                                    if (cubit.isLoading)
                                      const SpinKitThreeBounce(
                                        color: AppColor.primaryColor,
                                      ),
                                    if (!cubit.isLoading)
                                      CustomButton(
                                        onTap: cubit.register,
                                        text: AppText.createAccount.tr,
                                      ),
                                    const Gap(15),
                                    Row(
                                      children: [
                                        Text(
                                          AppText.haveAnAccount.tr,
                                          style: AppTextStyle.f18w400gray,
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: Align(
                                            alignment: alignment(),
                                            child: TextButton(
                                              onPressed: () {
                                                pushNamedAndRemoveUntil(
                                                    AppRoute.login, context);
                                              },
                                              child: AutoSizeText(
                                                AppText.loginNow.tr,
                                                style: AppTextStyle
                                                    .f18w600TextColor,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const CustomOtherAuth(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    AppSvg.logo,
                                    width: min(150, maxWidth * 0.11),
                                    height: min(150, maxWidth * 0.11),
                                  ),
                                ),
                                const Gap(30),
                                const Center(
                                  child: AutoSizeText(
                                    'Pharmageddon',
                                    style: AppTextStyle.f24w600SecondColor,
                                    maxLines: 1,
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

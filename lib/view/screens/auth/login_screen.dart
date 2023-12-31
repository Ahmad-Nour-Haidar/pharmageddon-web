import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/routes.dart';

import '../../../controllers/auth/login_cubit/login_cubit.dart';
import '../../../controllers/auth/login_cubit/login_state.dart';
import '../../../core/class/validation.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_constant.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/functions/functions.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_layout_builder.dart';
import '../../widgets/custom_other_auth.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/handle_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<LoginCubit>(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is LoginNotVerifyState) {
            pushNamed(AppRoute.verifyCode, context);
          }
          if (state is LoginSuccessState) {
            pushNamed(AppRoute.home, context);
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
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
                                    const Gap(25),
                                    Text(
                                      AppText.welcomeBack.tr,
                                      style: AppTextStyle.f26w600black,
                                    ),
                                    const Gap(25),
                                    // email
                                    CustomTextFormField(
                                      controller: cubit.emPhController,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        final e = ValidateInput.isEmail(value);
                                        final p = ValidateInput.isPhone(value);
                                        final b = e != null && p != null;
                                        return b
                                            ? AppText.emailOrPhoneNotValid.tr
                                            : null;
                                      },
                                      textInputAction: TextInputAction.next,
                                      fillColor: AppColor.transparent,
                                      colorPrefixIcon: AppColor.gray,
                                      prefixIcon: AppSvg.email,
                                      labelText: AppText.emailOrPhone.tr,
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
                                    Align(
                                      alignment: AppConstant.isEnglish
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: TextButton(
                                        onPressed: () {
                                          pushNamed(
                                              AppRoute.checkEmail, context);
                                        },
                                        child: Text(
                                          AppText.forgetPassword.tr,
                                          style: AppTextStyle.f18w600TextColor,
                                        ),
                                      ),
                                    ),
                                    const Gap(15),
                                    if (cubit.isLoading)
                                      const SpinKitThreeBounce(
                                        color: AppColor.primaryColor,
                                      ),
                                    if (!cubit.isLoading)
                                      CustomButton(
                                        onTap: cubit.login,
                                        text: AppText.login.tr,
                                      ),
                                    const Gap(15),
                                    Row(
                                      children: [
                                        Text(
                                          AppText.doNotHaveAnAccount.tr,
                                          style: AppTextStyle.f18w400gray,
                                        ),
                                        const Gap(10),
                                        Expanded(
                                          child: Align(
                                            alignment: alignment(),
                                            child: TextButton(
                                              onPressed: () {
                                                pushNamedAndRemoveUntil(
                                                    AppRoute.register, context);
                                              },
                                              child: AutoSizeText(
                                                AppText.createAccount.tr,
                                                style: AppTextStyle
                                                    .f18w600TextColor,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        )
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

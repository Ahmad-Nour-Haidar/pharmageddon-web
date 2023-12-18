import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/verify_code_cubit/verify_code_cubit.dart';
import 'package:pharmageddon_web/controllers/verify_code_cubit/verify_code_state.dart';
import '../../../core/constant/app_color.dart';
import '../../../core/constant/app_size.dart';
import '../../../core/constant/app_text.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/functions/functions.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/resources/app_text_theme.dart';
import '../../../core/services/dependency_injection.dart';
import '../../../routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_layout_builder.dart';
import '../../widgets/handle_state.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<VerifyCodeCubit>()..initial(),
      child: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
        listener: (context, state) {
          if (state is VerifyCodeFailureGetState) {
            handleState(context: context, state: state.state);
          }
          if (state is VerifyCodeFailureState) {
            handleState(context: context, state: state.state);
          }
          if (state is VerifyCodeSuccessState) {
            pushNamedAndRemoveUntil(AppRoute.home, context);
          }
        },
        builder: (context, state) {
          final cubit = VerifyCodeCubit.get(context);
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
                      child:
                          SvgPicture.asset(AppSvg.background, fit: BoxFit.fill),
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
                              child: ListView(
                                children: [
                                  Text(
                                    AppText.verifyCode.tr,
                                    style: AppTextTheme.f26w600black,
                                  ),
                                  const Gap(25),
                                  if (state is VerifyCodeLoadingGetState)
                                    const SpinKitFoldingCube(
                                        color: AppColor.primaryColor),
                                  if (cubit.email != null)
                                    Text(
                                      cubit.message,
                                      style: AppTextTheme.f18w500black,
                                    ),
                                  const Gap(30),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: OtpTextField(
                                      fieldWidth: 50.0,
                                      borderRadius:
                                          BorderRadius.circular(AppSize.size15),
                                      numberOfFields: 6,
                                      borderColor: AppColor.primaryColor,
                                      focusedBorderColor: AppColor.secondColor,
                                      enabledBorderColor: AppColor.primaryColor,
                                      showFieldAsBox: true,
                                      onSubmit: cubit.onSubmit, // end onSubmit
                                    ),
                                  ),
                                  const Gap(30),
                                  if (state is VerifyCodeLoadingState)
                                    const SpinKitThreeBounce(
                                      color: AppColor.primaryColor,
                                    ),
                                  if (state is! VerifyCodeLoadingState)
                                    CustomButton(
                                      onTap: cubit.verifyCode,
                                      text: AppText.verify.tr,
                                    ),
                                  const Gap(15),
                                  Align(
                                    alignment: isEnglish()
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: TextButton(
                                      onPressed: () {
                                        cubit.getVerifyCode();
                                      },
                                      child: Text(
                                        AppText.resendVerifyCode.tr,
                                        style: AppTextTheme.f18w400TextColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView(
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
                                  child: Text(
                                    'Pharmageddon',
                                    style: AppTextTheme.f24w600SecondColor,
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

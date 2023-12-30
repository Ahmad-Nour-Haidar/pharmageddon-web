import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/constant/app_constant.dart';
import 'package:pharmageddon_web/core/constant/app_local_data.dart';
import 'package:pharmageddon_web/core/constant/app_padding.dart';
import 'package:pharmageddon_web/core/constant/app_size.dart';
import 'package:pharmageddon_web/core/constant/app_text.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import 'package:pharmageddon_web/core/resources/app_text_theme.dart';
import 'package:pharmageddon_web/core/services/dependency_injection.dart';
import 'package:pharmageddon_web/view/widgets/custom_button.dart';
import 'package:pharmageddon_web/view/widgets/custom_text_form_field.dart';
import 'package:pharmageddon_web/view/widgets/get_image_from_url_and_memory.dart';
import 'package:pharmageddon_web/view/widgets/svg_image.dart';
import '../../../controllers/auth/profile_cubit/profile_cubit.dart';
import '../../../controllers/auth/profile_cubit/profile_state.dart';
import '../../../core/class/validation.dart';
import '../../../core/constant/app_storage_keys.dart';
import '../../../core/constant/app_svg.dart';
import '../../../core/functions/navigator.dart';
import '../../../data/local/app_hive.dart';
import '../../../data/remote/auth_data.dart';
import '../../../routes.dart';
import '../../widgets/custom_layout_builder.dart';
import '../../widgets/handle_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppInjection.getIt<ProfileCubit>()..initial(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailureState) {
            handleState(context: context, state: state.state);
          }
        },
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);
          return CustomLayoutBuilder(
            widget: (maxWidth, maxHeight) {
              return Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: AppPadding.padding20,
                      decoration: BoxDecoration(
                        color: AppColor.cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Form(
                        key: cubit.formKey,
                        child: ListView(
                          children: [
                            Center(
                              child: ClipOval(
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: GetImageFromUrlAndMemory(
                                    url: getImageUserUrl(),
                                    defaultImage: AppSvg.user,
                                    size: 200,
                                    onTap: cubit.enableEdit
                                        ? cubit.pickImage
                                        : null,
                                    webImage: cubit.bytes,
                                    callUrl:
                                        AppLocalData.user?.imageName != null,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(15),
                            // email
                            Center(
                              child: SelectableText(
                                AppLocalData.user?.email ?? AppText.email.tr,
                                style: AppTextStyle.f18w600black,
                              ),
                            ),
                            const Gap(15),
                            // phone
                            CustomTextFormField(
                              enabled: cubit.enableEdit,
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
                              enabled: cubit.enableEdit,
                              controller: cubit.nameController,
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
                              enabled: cubit.enableEdit,
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
                            if (state is ProfileLoadingState)
                              const SpinKitThreeBounce(
                                color: AppColor.primaryColor,
                              ),
                            if (state is! ProfileLoadingState)
                              CustomButton(
                                onTap: () {
                                  cubit.enableEdit
                                      ? cubit.updateUser()
                                      : cubit.onTapEdit();
                                },
                                text: AppText.edit.tr,
                                color: cubit.enableEdit
                                    ? AppColor.primaryColor
                                    : AppColor.gray3,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => showAwesomeLogout(context),
                      icon: Transform.flip(
                        flipX: !AppConstant.isEnglish,
                        child: const SvgImage(
                          path: AppSvg.exit,
                          color: AppColor.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void showAwesomeLogout(BuildContext context) {
    AwesomeDialog(
      context: context,
      btnOkText: AppText.ok.tr,
      btnCancelText: AppText.cancel.tr,
      dialogType: DialogType.question,
      title: AppText.logOut.tr,
      desc: AppText.doYouWantToLogOut.tr,
      width: AppSize.width * .4,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        AppInjection.getIt<AuthRemoteData>().logout();
        final appHive = AppInjection.getIt<AppHive>();
        appHive.delete(AppSKeys.userKey);
        appHive.delete(AppSKeys.langKey);
        pushNamedAndRemoveUntil(AppRoute.login, context);
      },
    ).show();
  }
}

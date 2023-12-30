import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_web/controllers/auth/profile_cubit/profile_state.dart';
import 'package:pharmageddon_web/print.dart';

import '../../../../core/class/image_helper.dart';
import '../../../../core/class/parent_state.dart';
import '../../../../core/constant/app_keys_request.dart';
import '../../../../core/constant/app_local_data.dart';
import '../../../../core/constant/app_text.dart';
import '../../../../core/functions/functions.dart';
import '../../../../core/services/dependency_injection.dart';
import '../../../../data/remote/auth_data.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);
  final _authRemoteData = AppInjection.getIt<AuthRemoteData>();
  final _imageHelper = AppInjection.getIt<ImageHelper>();
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  File? _image;
  Uint8List? _bytes;
  bool enableEdit = false;

  void _update(ProfileState state) {
    if (isClosed) return;
    emit(state);
  }

  Uint8List? get bytes => _bytes;

  void initial() {
    phoneController.text = AppLocalData.user!.phone!;
    nameController.text = AppLocalData.user!.username!;
    addressController.text = AppLocalData.user!.address!;
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    nameController.dispose();
    addressController.dispose();
    return super.close();
  }

  Future<void> updateUser() async {
    if (!formKey.currentState!.validate()) return;
    _update(ProfileLoadingState());
    final data = {
      AppRKeys.username: nameController.text,
      AppRKeys.phone: phoneController.text,
      AppRKeys.address: addressController.text,
    };
    final response = await _authRemoteData.update(data: data, file: _image);
    response.fold((l) {
      _update(ProfileFailureState(l));
    }, (r) async {
      printme.printFullText(r);
      final status = r[AppRKeys.status];
      if (status == 200) {
        _image = null;
        _bytes = null;
        enableEdit = false;
        await storeUser(r[AppRKeys.data][AppRKeys.user]);
        _update(ProfileSuccessState(
            SuccessState(message: AppText.updatedSuccessfully.tr)));
      } else {
        _update(ProfileFailureState(FailureState()));
      }
    });
  }

  void onTapEdit() {
    enableEdit = !enableEdit;
    if (!enableEdit) {
      _image = null;
    }
    _update(ProfileChangeState());
  }

  Future<void> pickImage() async {
    try {
      final temp = await _imageHelper.pickImage();
      if (temp == null) return;
      // final tempCrop = await _imageHelper.cropImage(file: temp);
      // if (tempCrop == null) return;
      _image = File(temp.path);
      _bytes = await temp.readAsBytes();
    } catch (e) {
      printme.red(e);
    }
    _update(ProfileChangeState());
  }
}

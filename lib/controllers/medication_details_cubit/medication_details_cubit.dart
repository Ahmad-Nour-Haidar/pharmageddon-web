import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmageddon_web/print.dart';
import '../../core/class/image_helper.dart';
import '../../core/services/dependency_injection.dart';
import '../../data/remote/home_data.dart';
import '../../model/medication_model.dart';
import 'medication_details_state.dart';

class MedicationDetailsCubit extends Cubit<MedicationDetailsState> {
  MedicationDetailsCubit() : super(MedicationDetailsInitialState());

  static MedicationDetailsCubit get(BuildContext context) =>
      BlocProvider.of(context);
  final _medicationsRemoteData = AppInjection.getIt<MedicationsRemoteData>();
  final _imageHelper = AppInjection.getIt<ImageHelper>();
  final formKey = GlobalKey<FormState>();
  final scientificNameArCon = TextEditingController();
  final scientificNameEnCon = TextEditingController();
  final commercialNameArCon = TextEditingController();
  final commercialNameEnCon = TextEditingController();
  final descArCon = TextEditingController();
  final descEnCon = TextEditingController();
  final priceCon = TextEditingController();
  final availableQuantityCon = TextEditingController();
  late DateTime expirationDate;
  File? image;
  Uint8List? imageShow;
  late MedicationModel model;

  void _update(MedicationDetailsState state) {
    if (isClosed) return;

    emit(state);
  }

  void initial(MedicationModel m) {
    model = m;
    printme.cyan(model.imageName);
    printme.cyan(model.arabicCommercialName);
    scientificNameArCon.text = model.arabicScientificName.toString();
    scientificNameEnCon.text = model.englishScientificName.toString();
    commercialNameArCon.text = model.arabicCommercialName.toString();
    commercialNameEnCon.text = model.englishCommercialName.toString();
    descArCon.text = model.arabicDescription.toString();
    descEnCon.text = model.englishDescription.toString();
    priceCon.text = model.price.toString();
    availableQuantityCon.text = model.availableQuantity.toString();
    expirationDate =
        DateTime.tryParse(model.expirationDate.toString()) ?? DateTime.now();
    _update(MedicationDetailsChangeState());
  }

  Future<void> pickImage() async {
    try {
      final temp = await _imageHelper.pickImage();
      if (temp == null) return;
      final tempCrop = await _imageHelper.cropImage(file: temp);
      if (tempCrop == null) return;
      image = File(tempCrop.path);
      imageShow = image?.readAsBytesSync();
    } catch (e) {
      printme.red(e);
    }
    _update(MedicationDetailsChangeState());
  }

  var enableEdit = true;
  void onTapEdit(){
    enableEdit = !enableEdit;
    _update(MedicationDetailsChangeState());
  }
}

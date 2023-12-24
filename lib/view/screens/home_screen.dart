import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmageddon_web/core/constant/app_color.dart';
import 'package:pharmageddon_web/core/functions/functions.dart';
import '../../controllers/home_cubit/home_cubit.dart';
import '../../controllers/home_cubit/home_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  BorderRadius get _borderRadius {
    if (isEnglish()) {
      return const BorderRadius.only(
        topLeft: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      );
    }
    return const BorderRadius.only(
      topRight: Radius.circular(25),
      bottomRight: Radius.circular(25),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.contentColorBlue,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomeCubit.get(context);
          return Row(
            children: [
              CustomDrawer(
                onTap: cubit.changeScreen,
                currentScreen: cubit.currentScreen,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: _borderRadius,
                  ),
                  child: Column(
                    children: [
                      CustomAppBar(onFieldSubmitted: cubit.onFieldSubmitted),
                      const Gap(10),
                      Expanded(child: cubit.screen),
                      // Expanded(
                      //   child: Row(
                      //     children: [
                      //       Expanded(child: cubit.screen),
                      //       if (cubit.showMedicationModelDetails)
                      //         const VerticalDivider(color: AppColor.gray1),
                      //       if (cubit.showMedicationModelDetails)
                      //         Expanded(
                      //           child: MedicationDetailsScreen(
                      //             tag: cubit.tag,
                      //             medicationModel: cubit.medicationModel,
                      //             // medicationModel: MedicationModel.fromJson(
                      //             //   {
                      //             //     "id": 1,
                      //             //     "english_scientific_name":
                      //             //     "Paracetamol",
                      //             //     "arabic_scientific_name": "باراسيتامول",
                      //             //     "english_commercial_name":
                      //             //     "Unadol blue",
                      //             //     "arabic_commercial_name": "بندول أزرق",
                      //             //     "available_quantity": 977,
                      //             //     "price": 5000,
                      //             //     "discount": 30,
                      //             //     "price_after_discount": 3500,
                      //             //     "is_favourite": false,
                      //             //     "arabic_description":
                      //             //     "كل مضغوطة تحتوي على: 500 ملغ باراسيتامول.",
                      //             //     "english_description":
                      //             //     "Each film coated tablets contains: 500 mg Paracetamol.",
                      //             //     "image_name": "m1.jpg",
                      //             //     "expiration_date":
                      //             //     "2024-02-14T00:00:00+03:00",
                      //             //     "created_at":
                      //             //     "2023-11-30T21:00:00+03:00",
                      //             //     "manufacturer": {
                      //             //       "id": 2,
                      //             //       "arabic_name": "يونفارما",
                      //             //       "english_name": "Unipharma",
                      //             //       "active": true
                      //             //     },
                      //             //     "effect_category": {
                      //             //       "id": 1,
                      //             //       "arabic_name": "مسكن آلام",
                      //             //       "english_name": "Analgesics",
                      //             //       "image_name": "e1.jpg",
                      //             //       "active": true
                      //             //     }
                      //             //   },
                      //             // ),
                      //           ),
                      //         ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

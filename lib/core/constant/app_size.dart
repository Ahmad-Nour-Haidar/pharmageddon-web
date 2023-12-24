import 'package:flutter/cupertino.dart';

class AppSize {
  AppSize._();

  static void initial(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    width = size.width;
    height = size.height;
  }

  static const widthManufacturer = 150.0;
  static const widthEffect = 190.0;
  static const widthMedicine = 190.0;

  // size
  static late double width;
  static late double height;
  static const appBarHeight = 40.0;
  static const size10 = 10.0;
  static const size15 = 15.0;
  static const size20 = 20.0;
  static const size25 = 25.0;
  static const size30 = 30.0;
  static const size32 = 32.0;
  static const size40 = 40.0;
  static const size45 = 45.0;
  static const size50 = 50.0;
  static const size60 = 60.0;
  static const size70 = 70.0;
  static const size80 = 80.0;
  static const size100 = 100.0;
  static const size140 = 140.0;

  // padding
  static const padding5 = 5.0;
  static const padding10 = 10.0;
  static const padding15 = 15.0;
  static const padding20 = 20.0;
  static const padding25 = 25.0;
  static const padding30 = 30.0;
  static const padding40 = 40.0;
  static const padding60 = 60.0;
  static const screenPadding = padding15;

  // radius
  static const radius10 = 10.0;
  static const radius15 = 15.0;
  static const radius20 = 20.0;
  static const radius35 = 35.0;
  static const radius45 = 45.0;
  static const radius65 = 65.0;

  // elevation
  static const elevation4 = 4.0;
  static const elevation6 = 6.0;
}

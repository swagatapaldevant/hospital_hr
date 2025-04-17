import 'package:flutter/widgets.dart';
import 'package:hospital_hr/core/utils/helper/screen_utils.dart';

class AppDimensions {
  static late double screenWidth;
  static late double screenHeight;
  static late double screenPadding;
  static late double buttonHeight;
  static late double screenContentPadding;

  static void init(BuildContext context) {
    screenWidth = ScreenUtils().screenWidth(context);
    screenHeight = ScreenUtils().screenHeight(context);

    screenPadding = screenWidth*0.03;
    buttonHeight = screenHeight*0.055;
    screenContentPadding = screenWidth*0.05;

  }
}
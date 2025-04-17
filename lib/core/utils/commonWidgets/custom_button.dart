import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';
class CommonButton extends StatelessWidget {
  final double height;
  final double width;
  final Color buttonColor;
  final String buttonName;
  final Color buttonTextColor;
  final Function()? onTap;
  final double? fontSize;
  final double? borderRadius;

  const CommonButton({super.key, required this.height, required this.width, required this.buttonColor, required this.buttonName, required this.buttonTextColor, this.onTap, this.fontSize = 22, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(borderRadius??ScreenUtils().screenHeight(context)*0.025),
            border: Border.all(color: AppColors.colorBlack, width: 1.5)

        ),
        child: Center(
          child: Text(buttonName,style: TextStyle(
              fontWeight: FontWeight.w600,
              color: buttonTextColor,
              fontSize: fontSize,
            fontFamily: "Poppins"
          ),),
        ),

      ),
    );
  }
}

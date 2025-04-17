import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';


class CommonBackIcon extends StatelessWidget {
  Function()? onTap;
   CommonBackIcon({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onTap: onTap,
      child: Container(

        decoration: BoxDecoration(
          shape:  BoxShape.circle,
          color: AppColors.white
        ),
        child: Padding(
          padding:  EdgeInsets.all(ScreenUtils().screenHeight(context)*0.01),
          child: Icon(Icons.arrow_back, size: 30,color: Colors.pinkAccent,),
        ),
      ),
    );
  }
}

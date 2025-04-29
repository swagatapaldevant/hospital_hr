
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../constants/app_colors.dart';
import '../constants/app_string.dart';
import '../helper/screen_utils.dart';
import 'common_back_icon.dart';

class CommonHeader extends StatelessWidget {
  final bool isDashBoard;
  final Function()? onPressed;
  final String headerName;
  const CommonHeader({super.key,  this.isDashBoard = true, this.onPressed, required this.headerName,});

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonBackIcon(
          onTap: (){
            Navigator.pop(context);
          },
        ),
        SizedBox(width: ScreenUtils().screenWidth(context)*0.05,),
        Text(headerName, style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
          color: AppColors.white,
          fontSize: 22
        ),)
      ],
    );
  }
}


import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';
import 'custom_button.dart';

class ImagePickerPopUp extends StatelessWidget {

  Function() onCameraClick;
  Function() onGalleryClick;
  ImagePickerPopUp({
    required this.onCameraClick,
    required this.onGalleryClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15.0, top: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pick Image'.toUpperCase(), style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  color: AppColors.colorBlack,
                  fontSize: 16
                )),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          CommonButton(
            onTap: onCameraClick,
            fontSize: 14,
              borderRadius: 10,
              height: ScreenUtils().screenHeight(context)*0.05,
              width: ScreenUtils().screenWidth(context)*0.4,
              buttonColor: AppColors.colorBlack,
              buttonName: "From Camera",
              buttonTextColor: AppColors.white),

          SizedBox(height: 10.0),

          CommonButton(
              onTap: onGalleryClick,
              fontSize: 14,
              borderRadius: 10,
              height: ScreenUtils().screenHeight(context)*0.05,
              width: ScreenUtils().screenWidth(context)*0.4,
              buttonColor: AppColors.colorBlack,
              buttonName: "From Gallery",
              buttonTextColor: AppColors.white),

        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';
import 'custom_button.dart';

CommonDialog(
    {required String title,
    required String msg,
    required String activeButtonLabel,
    Color? activeButtonLabelColor,
      required Color activeButtonSolidColor,
    IconData? icon,
      required String activeButtonName,
    bool isCancelButtonShow = true,
    Function()? activeButtonOnClicked,
    required BuildContext context}) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0)), //this right here
          child: Container(
            height: ScreenUtils().screenHeight(context) * 0.5 - 25,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(25.0),
              ),
              color: AppColors.white,
              // boxShadow: [
              //   BoxShadow(
              //     // color:  Colors.blueGrey.withOpacity(0.4),
              //       color: AppColors.colorPrimaryText2.withOpacity(0.2),
              //       offset: Offset(0.0, 5.0),
              //       blurRadius: 10.0)
              // ],
            ),
            child: Padding(
              padding:
                  EdgeInsets.all(ScreenUtils().screenWidth(context) * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Spacer(),
                  Container(
                      height: ScreenUtils().screenHeight(context) * 0.1,
                      width: ScreenUtils().screenWidth(context) * 0.2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.pinkAccent,
                                Colors.pinkAccent.withOpacity(0.4)
                              ])),
                      child: Icon(
                        icon,
                        color: AppColors.white,
                        size: 20,
                      )),
                  SizedBox(
                    height: ScreenUtils().screenHeight(context) * 0.02,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontFamily: "Poppins",
                          color: AppColors.colorBlack,
                          fontSize: ScreenUtils().screenWidth(context) * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: ScreenUtils().screenHeight(context) * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(
                      msg,
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontFamily: "Poppins",
                                color: AppColors.colorBlack,
                                fontSize:
                                    ScreenUtils().screenWidth(context) * 0.038,
                                fontWeight: FontWeight.w300,
                              ),
                      maxLines: 7,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //Spacer(),
                  SizedBox(
                    height: ScreenUtils().screenHeight(context) * 0.05,
                  ),
                  Row(
                    children: [
                      Visibility(
                        visible: isCancelButtonShow,
                        child: Expanded(
                          flex: 1,
                          child: CommonButton(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            fontSize: 14,
                              borderRadius: 10,
                              height: ScreenUtils().screenHeight(context)*0.05,
                              width: ScreenUtils().screenWidth(context)*0.3,
                              buttonColor: AppColors.white,
                              buttonName: "Cancel",
                              buttonTextColor: AppColors.colorBlack
                          ),
                        ),
                      ),
                      SizedBox(
                        width: isCancelButtonShow ? 10 : 0,
                      ),
                      Expanded(
                        flex: 1,
                        child:CommonButton(
                          onTap: activeButtonOnClicked,
                          borderRadius: 10,
                          fontSize: 14,
                            height: ScreenUtils().screenHeight(context)*0.05,
                            width: ScreenUtils().screenWidth(context)*0.3,
                            buttonColor:activeButtonSolidColor,
                            buttonName: activeButtonName,
                            buttonTextColor: AppColors.white
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}

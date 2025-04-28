import 'package:flutter/material.dart';
import '../../../../core/utils/commonWidgets/common_back_icon.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/commonWidgets/custom_textField.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';


class UserResetPasswordScreens extends StatefulWidget {
  const UserResetPasswordScreens({super.key});

  @override
  State<UserResetPasswordScreens> createState() => _UserResetPasswordScreensState();
}

class _UserResetPasswordScreensState extends State<UserResetPasswordScreens> {
  TextEditingController passwordController=TextEditingController();

  bool agreeWithTerm = false;
  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool passwordsMatch = true;
  bool startEditing = false;

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.all(AppDimensions.screenContentPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CommonBackIcon(
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.1,),
                  Text("Reset Password ", style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: AppColors.white
                  ),),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),

                  CustomTextField(controller: passwordController,
                    hintText: 'New Password',
                    prefixIcon: Icons.lock,),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                  CustomTextField(controller: passwordController,
                    hintText: 'Confirm Password',
                    prefixIcon: Icons.lock,),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),

                  CommonButton(
                    onTap: (){
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/UserLogInScreens",
                            (Route<dynamic> route) => false, // This condition removes all routes
                      );                    },
                    fontSize: 18,
                    borderRadius: 12,
                    height: 50, width: ScreenUtils().screenWidth(context),
                    buttonColor: AppColors.white, buttonName: 'Saved', buttonTextColor: Colors.pinkAccent,)


                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.center,


                ],
              ),
            ),
          ),
        )
    );
  }
}

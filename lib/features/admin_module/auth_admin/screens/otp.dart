import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/commonWidgets/common_back_icon.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/commonWidgets/custom_textField.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class AdminOTP extends StatefulWidget {
  const AdminOTP({super.key});

  @override
  State<AdminOTP> createState() => _AdminOTPState();
}

class _AdminOTPState extends State<AdminOTP> {
  TextEditingController emailController =TextEditingController();
  bool agreeWithTerm = false;
  bool isLoading = false;
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
                    )),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.1,),
                Text("Enter OTP ", style: TextStyle(
                    fontSize: 28,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: AppColors.white
                ),),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),

                CustomTextField(controller: emailController,
                  hintText: 'Please enter your OTP',
                  prefixIcon: Icons.confirmation_num,),
                SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),


                SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                CommonButton(
                  onTap: (){
                    Navigator.pushNamed(context, "/AdminResetPasswordScreens");
                  },
                  fontSize: 18,
                  borderRadius: 12,
                  height: 50, width: ScreenUtils().screenWidth(context),
                  buttonColor: AppColors.white, buttonName: 'Submit', buttonTextColor: Colors.pinkAccent,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}

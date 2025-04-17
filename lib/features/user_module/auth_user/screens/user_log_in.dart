import 'package:flutter/material.dart';
import '../../../../core/utils/commonWidgets/common_back_icon.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/commonWidgets/custom_textField.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';


class UserLogInScreens extends StatefulWidget {
  const UserLogInScreens({super.key});

  @override
  State<UserLogInScreens> createState() => _UserLogInScreensState();
}

class _UserLogInScreensState extends State<UserLogInScreens> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController=TextEditingController();
  //final LogInUsecase _logInUsecase = getIt<LogInUsecase>();
  //final SharedPref _pref = getIt<SharedPref>();

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
                  Text("Log in as User ", style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: AppColors.white
                  ),),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
                  Text("Please Login to access your profile", style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: AppColors.white
                  ),),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.05,),

                  CustomTextField(controller: emailController,
                    hintText: 'Please enter your email',
                    prefixIcon: Icons.email,),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

                  CustomTextField(controller: passwordController,
                    hintText: 'Please enter your password',
                    prefixIcon: Icons.lock,),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "/UserForgotPassword");
                      },
                      child: Text("Forgot password ?", style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: AppColors.white
                      ),),
                    ),
                  ),
                  SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                  CommonButton(
                    onTap: (){
                      Navigator.pushNamed(context, "/UserHomeScreen");
                    },
                    fontSize: 18,
                    borderRadius: 12,
                    height: 50, width: ScreenUtils().screenWidth(context),
                    buttonColor: AppColors.white, buttonName: 'Login', buttonTextColor: Colors.pinkAccent,)


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

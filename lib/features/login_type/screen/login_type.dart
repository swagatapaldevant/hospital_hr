import 'package:flutter/material.dart';
import '../../../core/utils/commonWidgets/custom_button.dart';
import '../../../core/utils/constants/app_colors.dart';
import '../../../core/utils/helper/app_dimensions.dart';
import '../../../core/utils/helper/screen_utils.dart';


class LogInTypeScreens extends StatefulWidget {
  const LogInTypeScreens({super.key});

  @override
  State<LogInTypeScreens> createState() => _LogInTypeScreensState();
}

class _LogInTypeScreensState extends State<LogInTypeScreens> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController=TextEditingController();

  bool agreeWithTerm = false;
  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool passwordMatch = true;
  bool startEditing = false;

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(AppDimensions.screenContentPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text("Select Log In Type", style: TextStyle(
                          fontSize: 32,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                          color: AppColors.white
                      ),),

                      SizedBox(height: ScreenUtils().screenHeight(context)*0.05,),

                      CommonButton(
                        fontSize: 18,
                        borderRadius: 12,
                        height: 50, width: ScreenUtils().screenWidth(context),
                        buttonColor: AppColors.white, buttonName: 'Log In as Admin', buttonTextColor: Colors.pinkAccent,onTap: (){
                        Navigator.pushNamed(context, "/AdminLogInScreens");
                      },),

                      SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),

                      CommonButton(
                        fontSize: 18,
                        borderRadius: 12,
                        height: 50, width: ScreenUtils().screenWidth(context),
                        buttonColor: AppColors.white, buttonName: 'Log In as User', buttonTextColor: Colors.pinkAccent,onTap: (){
                        Navigator.pushNamed(context, "/UserLogInScreens");
                      },),

                    ]
                )
            )
        )
    );
  }
}

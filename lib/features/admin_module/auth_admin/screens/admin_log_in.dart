import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/features/admin_module/auth_admin/data/auth_usecase.dart';
import 'package:hospital_hr/features/admin_module/auth_admin/model/login_response_model.dart';
import '../../../../core/utils/commonWidgets/common_back_icon.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/commonWidgets/custom_textField.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class AdminLogInScreens extends StatefulWidget {
  const AdminLogInScreens({super.key});

  @override
  State<AdminLogInScreens> createState() => _AdminLogInScreensState();
}

class _AdminLogInScreensState extends State<AdminLogInScreens> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthUseCase _authSelectionUseCase = getIt<AuthUseCase>();
  final SharedPref _pref = getIt<SharedPref>();

  bool agreeWithTerm = false;
  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool passwordsMatch = true;
  bool startEditing = false;
  LoginResponseModel? loginResponseData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.screenContentPadding),
          child: SingleChildScrollView(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.1,
                ),
                const Text(
                  "Log in",
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w700,
                      color: AppColors.white),
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.03,
                ),
                const Text(
                  "Please Login to access your profile",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: AppColors.white),
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.05,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Please enter your email',
                  prefixIcon: Icons.email,
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.01,
                ),
                CustomTextField(
                  controller: passwordController,
                  hintText: 'Please enter your password',
                  prefixIcon: Icons.lock,
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.01,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/AdminForgotPassword");
                    },
                    child: const Text(
                      "Forgot password ?",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: AppColors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtils().screenHeight(context) * 0.02,
                ),
                isLoading
                    ? const CircularProgressIndicator(
                        color: AppColors.white,
                      )
                    : CommonButton(
                        onTap: () {
                          loginApi();
                        },
                        fontSize: 18,
                        borderRadius: 12,
                        height: 50,
                        width: ScreenUtils().screenWidth(context),
                        buttonColor: AppColors.white,
                        buttonName: 'Login',
                        buttonTextColor: Colors.pinkAccent,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> requestData = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim()
    };

    Resource resource =
        await _authSelectionUseCase.adminLogin(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      loginResponseData = LoginResponseModel.fromJson(resource.data);

      // save ta data in local storage
      _pref.setUserName(loginResponseData?.user?.name.toString() ?? "");
      _pref.setProfileImage(
          "http://192.168.29.106/rainbow_new/public/assets/images/users/${loginResponseData?.user?.profileImg.toString() ?? ""}");
      _pref.setUserAuthToken(loginResponseData?.accessToken.toString() ?? "");
      _pref.setUserId(loginResponseData?.user?.id??0);

      //print("response data is : ${loginResponseData?.user?.name}");
      setState(() {
        isLoading = false;

        loginResponseData?.user?.roleId.toString() == "1"?
        Navigator.pushNamed(context, "/AdminHomeScreen"):
        Navigator.pushNamed(context, "/UserHomeScreen");
        CommonUtils().flutterSnackBar(
          context: context,
          mes: resource.message ?? "",
          messageType: 1,
        );
      });
    } else {
      CommonUtils().flutterSnackBar(
        context: context,
        mes: resource.message ?? "",
        messageType: 4,
      );
    }
  }
}

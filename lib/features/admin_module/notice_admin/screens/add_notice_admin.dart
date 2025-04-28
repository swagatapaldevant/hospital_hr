import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/data/notice_usecase.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/model/add_notice_model.dart';
import '../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/commonWidgets/custom_dropdown.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';


class AddNoticeAdmin extends StatefulWidget {
  const AddNoticeAdmin({super.key});


  @override
  _AddNoticeAdminState createState() => _AddNoticeAdminState();
}
class _AddNoticeAdminState extends State<AddNoticeAdmin> {

  final _enternoticeController = TextEditingController();//(text: 'Test');
  final _enterdetailsController = TextEditingController();//(text: 'Test');
  TextEditingController priority=TextEditingController();
  Map<String, int> priorityTypeMap = {"High":1, "Medium":2, "Low":3 };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  final NoticeUsecase _noticeUseCase = getIt<NoticeUsecase>();
  AddNoticeModel?addNotice;

  @override
  void initState() {
    super.initState();
    addNoticeApi();
  }


  Widget editableField(String label, TextEditingController controller, int? maxLines) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines??1,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.screenContentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonHeader(headerName: 'Add Notice'),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

                buildEditableSection(
                  icon: Icons.assessment,
                  title: 'Add Notice',
                  fields: [
                    editableField('Enter Notice', _enternoticeController, 1),
                    editableField('Notice Details', _enterdetailsController, 4),
                  ],
                ),

                CustomDropDownForTaskCreation(
                  placeHolderText: 'Choose Priority Level',
                  onValueSelected: (String , int ) {  },
                  data: priorityTypeMap,

                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CommonButton(
                  onTap: (){
                    CommonDialog(
                        icon: Icons.save,
                        activeButtonSolidColor: Colors.green,
                        title: "Notice Added",
                        msg:
                        "You are about to add notice. Please confirm.",
                        activeButtonLabel: "Confirm",
                        context: context,
                        activeButtonOnClicked: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, activeButtonName: 'Confirm');
                  },
                  fontSize: 18,
                  borderRadius: 12,
                  height: 50, width: ScreenUtils().screenWidth(context),
                  buttonColor: AppColors.white, buttonName: 'Add Notice', buttonTextColor: Colors.pinkAccent,),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditableSection({
    required IconData icon,
    required String title,
    required List<Widget> fields,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 28),
              SizedBox(width: ScreenUtils().screenHeight(context) * 0.01),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Divider(),
          ...fields,
        ],
      ),
    );
  }


  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ],
      ),
    );
  }

  addNoticeApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> requestData = {
      "Enter Notice": _enternoticeController.text.trim(),
      "Notice Details": _enterdetailsController.text.trim()
    };

    Resource resource =
    await _noticeUseCase.addNotice(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      addNotice = AddNoticeModel.fromJson(resource.data);

      // // save ta data in local storage
      // _pref.setUserName(loginResponseData?.user?.name.toString() ?? "");
      // _pref.setProfileImage(
      //     "http://192.168.29.106/rainbow_new/public/assets/images/users/${loginResponseData?.user?.profileImg.toString() ?? ""}");
      // _pref.setUserAuthToken(loginResponseData?.accessToken.toString() ?? "");

      //print("response data is : ${loginResponseData?.user?.name}");
      setState(() {
        isLoading = false;
        Navigator.pushNamed(context, "/DashboardNoticeAdmin");
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

import 'package:flutter/material.dart';
import '../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/commonWidgets/custom_dropdown.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class AppColors {
  static const primaryColor = Color(0xFF6200EE); // Your primary color
  static const cardBackgroundColor = Colors.white; // Background color for cards
  static const white = Colors.white;
  static const black = Colors.black;
  static const white70 = Colors.white70;

  // ✅ Add actual values for the missing color variables
  static const gray3 = Color(0xFFB0BEC5); // example color
  static const gray7 = Color(0xFF455A64); // example color
  static const darkBlue = Color(0xFF003366); // example color
  static const colorGreen = Color(0xFF4CAF50); // example color
}

class EditNoticeAdmin extends StatefulWidget {
  const EditNoticeAdmin({super.key});

  @override
  _EditNoticeAdminState createState() => _EditNoticeAdminState();
}

// Define these controllers at the top of your _ViewUserState
final _enternoticeController = TextEditingController(text: 'Test');
TextEditingController priority=TextEditingController();
Map<String, int> priorityTypeMap = {"High":1, "Medium":2, "Low":3 };

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


class _EditNoticeAdminState extends State<EditNoticeAdmin> {
  Widget editableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                CommonHeader(headerName: 'Edit Notice'),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
                SizedBox(height: 10),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),


                buildEditableSection(
                  icon: Icons.edit,
                  title: 'Edit Notice',
                  fields: [
                    editableField('Enter Notice', _enternoticeController),
                  ],
                ),

                CustomDropDownForTaskCreation(
                  placeHolderText: 'Choose Priority Level',
                  onValueSelected: (String , int ) {  },
                  data: priorityTypeMap,

                ),

                SizedBox(height: 12),
                CommonButton(
                  onTap: (){
                    CommonDialog(
                        icon: Icons.save,
                        activeButtonSolidColor: Colors.green,
                        title: "Notice Changed",
                        msg:
                        "You are about to change notice. Please confirm.",
                        activeButtonLabel: "Confirm",
                        context: context,
                        activeButtonOnClicked: () {
                          //_pref.clearOnLogout();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, activeButtonName: 'Confirm');
                    //Navigator.pushNamed(context, "/HrModuleScreen");
                  },
                  fontSize: 18,
                  borderRadius: 12,
                  height: 50, width: ScreenUtils().screenWidth(context),
                  buttonColor: AppColors.white, buttonName: 'Change Notice', buttonTextColor: Colors.pinkAccent,),

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
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 12),
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
              SizedBox(width: 8),
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
          SizedBox(height: 16),
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
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

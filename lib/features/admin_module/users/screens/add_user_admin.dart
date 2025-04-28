import 'package:flutter/material.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import '../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class AddUserAdmin extends StatefulWidget {
  const AddUserAdmin({super.key});


  @override
  _AddUserAdminState createState() => _AddUserAdminState();
}

// Define these controllers at the top of your _ViewUserState
final _usernameController = TextEditingController(text: '');
final _eidController = TextEditingController(text: '');
final _emailController = TextEditingController(text: '');
final _phoneController = TextEditingController(text: '');
final _designationController = TextEditingController(text: '');
final _statusController = TextEditingController(text: '');


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



class _AddUserAdminState extends State<AddUserAdmin> {


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
                CommonHeader(headerName: 'Add Users'),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

                // Profile Picture with Edit Icon





                //SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),


                buildEditableSection(
                  icon: Icons.person,
                  title: 'Add User',
                  fields: [
                    editableField('User Name', _usernameController),
                    editableField('EId', _eidController),
                    editableField('Email Id', _emailController),
                    editableField('Phone No', _phoneController),
                    editableField('Designation', _designationController),
                    editableField('Status', _statusController),

                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                CommonButton(
                  onTap: (){
                    CommonDialog(
                        icon: Icons.save,
                        activeButtonSolidColor: Colors.green,
                        title: "User Added",
                        msg:
                        "You are about to add user. Please confirm.",
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
                  buttonColor: AppColors.white, buttonName: 'Add', buttonTextColor: Colors.pinkAccent,),

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
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
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

}

import 'package:flutter/material.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import '../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class EditUserAdmin extends StatefulWidget {
  const EditUserAdmin({super.key});


  @override
  _EditUserAdminState createState() => _EditUserAdminState();
}

// Define these controllers at the top of your _ViewUserState
final _usernameController = TextEditingController(text: 'Sourav Mondal');
final _eidController = TextEditingController(text: '2134');
final _emailController = TextEditingController(text: 'sourav.dits@gmail.com');
final _phonenoController = TextEditingController(text: '9807654321');
final _designationController = TextEditingController(text: 'Software Engineer');
final _statusController = TextEditingController(text: 'Active');


final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



class _EditUserAdminState extends State<EditUserAdmin> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  get children => null;

  // Function to Pick Image
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      int imageSize = await imageFile.length();

      if (imageSize > 800 * 1024) {
        Fluttertoast.showToast(msg: "Image size is greater than 800KB. Please choose a smaller image.");
      } else {
        setState(() {
          _image = imageFile;
        });
      }
    }
  }

  // Function to Show Bottom Sheet
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.blue),
            title: Text('Take a Photo'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: Colors.green),
            title: Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

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
                CommonHeader(headerName: 'Edit User'),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

                // Profile Picture with Edit Icon
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : NetworkImage('https://picsum.photos/200/300?random=2') as ImageProvider,
                        backgroundColor: Colors.transparent,
                      ),
                      // Positioned Edit Icon
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Sourav Mondal',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),


                buildEditableSection(
                  icon: Icons.person_outline,
                  title: 'Edit User Details',
                  fields: [
                    editableField('User Name', _usernameController),
                    editableField('EId', _eidController),
                    editableField('Email Id', _emailController),
                    editableField('Phone No', _phonenoController),
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
                        title: "Saved Changes",
                        msg:
                        "You are about to save changes. Please confirm.",
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
                  buttonColor: AppColors.white, buttonName: 'Saved', buttonTextColor: Colors.pinkAccent,),

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

}

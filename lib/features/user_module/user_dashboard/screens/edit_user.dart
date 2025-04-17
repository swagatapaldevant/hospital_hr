import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import '../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
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


class EditUser extends StatefulWidget {
  const EditUser({super.key});


  @override
  _EditUserState createState() => _EditUserState();
}

// Define these controllers at the top of your _ViewUserState
final _employeeIdController = TextEditingController(text: '2134');
final _genderController = TextEditingController(text: 'Male');
final _dobController = TextEditingController(text: '18-12-2012');
final _joiningDateController = TextEditingController(text: '12-02-2022');
final _fatherNameController = TextEditingController(text: 'Father');
final _motherNameController = TextEditingController(text: 'Mother');
final _maritalStatusController = TextEditingController(text: 'Single');
final _bloodGroupController = TextEditingController(text: 'AB+');


final _qualificationController = TextEditingController(text: 'MBBS');
final _experienceController = TextEditingController(text: '2 years');
final _specialistController = TextEditingController(text: 'Heart Specialist');
final _noteController = TextEditingController(text: 'null');

final _currentAddressController = TextEditingController(text: 'Kolkata');
final _permanentAddressController = TextEditingController(text: 'Kolkata');

final _emailController = TextEditingController(text: 'sourav.dits@gmail.com');
final _mobileController = TextEditingController(text: '1234567890');
final _whatsappController = TextEditingController(text: '1234567890');
final _emergencyController = TextEditingController(text: '2134567890');

final _panController = TextEditingController(text: 'ASEFR2435Y');
final _idNameController = TextEditingController(text: 'Swagata pal');
final _idNumberController = TextEditingController(text: '2134567890');
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



class _EditUserState extends State<EditUser> {
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

                SizedBox(height: 10),
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
                      Text(
                        'Software Engineer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),


                buildEditableSection(
                  icon: Icons.person_outline,
                  title: 'Personal Details',
                  fields: [
                    editableField('Employee ID', _employeeIdController),
                    editableField('Gender', _genderController),
                    editableField('Date of Birth', _dobController),
                    editableField('Joining Date', _joiningDateController),
                    editableField('Father Name', _fatherNameController),
                    editableField('Mother Name', _motherNameController),
                    editableField('Marital Status', _maritalStatusController),
                    editableField('Blood Group', _bloodGroupController),
                  ],
                ),

                buildEditableSection(
                  icon: Icons.work_history,
                  title: 'Work & Education',
                  fields: [
                    editableField('Qualification', _qualificationController),
                    editableField('Work Experience', _experienceController),
                    editableField('Specialist', _specialistController),
                    editableField('Note', _noteController),
                  ],
                ),

                buildEditableSection(
                  icon: Icons.location_city,
                  title: 'Address',
                  fields: [
                    editableField('Current Address', _currentAddressController),
                    editableField('Permanent Address', _permanentAddressController),
                  ],
                ),

                buildEditableSection(
                  icon: Icons.contact_page,
                  title: 'Contact',
                  fields: [
                    editableField('Email Id', _emailController),
                    editableField('Mobile No', _mobileController),
                    editableField('WhatsApp No', _whatsappController),
                    editableField('Emg No', _emergencyController),
                  ],
                ),

                buildEditableSection(
                  icon: Icons.perm_identity,
                  title: 'Identification',
                  fields: [
                    editableField('PAN Number', _panController),
                    editableField('Identification Name', _idNameController),
                    editableField('Identification Number', _idNumberController),
                  ],
                ),

                SizedBox(height: 12),
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

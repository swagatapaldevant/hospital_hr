import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/features/admin_module/users/data/users_usecase.dart';
import 'package:hospital_hr/features/admin_module/users/model/user_details_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';


class ViewUserAdmin extends StatefulWidget {
  final int userId;
  const ViewUserAdmin({super.key, required this.userId});

  @override
  _ViewUserAdminState createState() => _ViewUserAdminState();
}

class _ViewUserAdminState extends State<ViewUserAdmin> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final UsersUseCase _usersUseCase = getIt<UsersUseCase>();
  final SharedPref _pref = getIt<SharedPref>();
  bool isLoading = false;
  UserDetailsModel? userDetails;

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
            leading: const Icon(Icons.camera_alt, color: Colors.blue),
            title: const Text('Take a Photo'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.green),
            title: const Text('Choose from Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    userDetailsApi();
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
                const CommonHeader(headerName: 'User Details'),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

                // Profile Picture with Edit Icon
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : const NetworkImage('https://picsum.photos/200/300?random=2') as ImageProvider,
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
                  '${userDetails?.salutation?.toString() ?? ''} ${userDetails?.name?.toString() ?? ''}',

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

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
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
                      // Header
                      Row(
                        children: [
                          Icon(Icons.person_outline, color: AppColors.primaryColor, size: 28),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            'Personal Details',
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

                      // Detail Rows
                      _detailRow('Employee ID', userDetails?.empId.toString()??""),
                      _detailRow('Gender', userDetails?.gender.toString()??""),
                      _detailRow('Date of Birth', userDetails?.dob.toString()??""),
                      _detailRow('Joining Date', userDetails?.joiningDate.toString()??""),
                      _detailRow('Father Name', userDetails?.fatherName.toString()??""),
                      _detailRow('Mother Name', userDetails?.motherName.toString()??""),
                      _detailRow('Marital Status', userDetails?.maritalStatus.toString()??""),
                      _detailRow('Blood Group', userDetails?.bloodGroup.toString()??""),
                      _detailRow('Signature', userDetails?.signature.toString()??""),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
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
                      // Header
                      Row(
                        children: [
                          Icon(Icons.work_history, color: AppColors.primaryColor, size: 28),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            'Work & Education',
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

                      // Detail Rows
                      _detailRow('Qualification', userDetails?.qualification.toString()??""),
                      _detailRow('Work Experience', userDetails?.experience.toString()??""),
                      _detailRow('User Type', userDetails?.userType.toString()??""),
                      _detailRow('Specialist', userDetails?.specialization.toString()??""),
                      _detailRow('Doctor Type', userDetails?.doctorType.toString()??""),
                      _detailRow('Doctor Fees', userDetails?.doctorFees.toString()??""),
                      _detailRow('Commission Type', userDetails?.commissionType.toString()??""),
                      _detailRow('Commission Amount', userDetails?.commissionAmount.toString()??""),
                      _detailRow('Basic Salary', userDetails?.basicSalary.toString()??""),
                      _detailRow('Note', userDetails?.note.toString()??""),

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
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
                      // Header
                      Row(
                        children: [
                          Icon(Icons.location_city, color: AppColors.primaryColor, size: 28),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          Text(
                            'Address',
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

                      // Detail Rows
                      _detailRow('Current Address', userDetails?.currentAddress.toString()??""),
                      _detailRow('Permanent Address', userDetails?.permanentAddress.toString()??""),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
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
                      // Header
                      Row(
                        children: [
                          Icon(Icons.contact_page, color: AppColors.primaryColor, size: 28),
                          SizedBox(width: ScreenUtils().screenHeight(context) * 0.01),
                          Text(
                            'Contact',
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

                      // Detail Rows
                      _detailRow('Email Id', userDetails?.email.toString()??""),
                      _detailRow('Mobile No', userDetails?.phoneNo.toString()??""),
                      _detailRow('WhatsApp No', userDetails?.whatsappNo.toString()??""),
                      _detailRow('Emg No', userDetails?.emgNo.toString()??""),

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
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
                      // Header
                      Row(
                        children: [
                          Icon(Icons.perm_identity, color: AppColors.primaryColor, size: 28),
                          SizedBox(width: ScreenUtils().screenHeight(context) * 0.01),
                          Text(
                            'Identification',
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

                      // Detail Rows
                      _detailRow('PAN Number', userDetails?.panNumber.toString()??""),
                      _detailRow('Identification Number', userDetails?.identificationNumber.toString()??""),

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              ],
            ),
          ),
        ),
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
        ],
      ),
    );
  }

  userDetailsApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> requestData = {
        "id": widget.userId,
    };

    Resource resource = await _usersUseCase.userDetails(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      userDetails = UserDetailsModel.fromJson(resource.data);

      setState(() {
        isLoading = false;

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

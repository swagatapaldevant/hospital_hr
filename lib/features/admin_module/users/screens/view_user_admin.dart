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
        child: isLoading?const Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        ):SingleChildScrollView(
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
                        radius: 80,
                        backgroundImage: _image != null
                            ? FileImage(_image!) as ImageProvider
                            : (userDetails?.profileImg != null && userDetails!.profileImg!.isNotEmpty
                            ? NetworkImage("http://192.168.29.106/rainbow_new/public/assets/images/users/${userDetails!.profileImg}")
                            : const AssetImage("assets/images/placeholder.jpeg")) as ImageProvider,                        backgroundColor: Colors.transparent,
                      ),
                      // Positioned Edit Icon
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: GestureDetector(
                      //     onTap: _showImagePickerOptions,
                      //     child: const CircleAvatar(
                      //       radius: 20,
                      //       backgroundColor: Colors.blue,
                      //       child: Icon(
                      //         Icons.camera_alt,
                      //         color: Colors.white,
                      //         size: 20,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Center(
                  child: Column(
                    children: [
                      Text(
                  '${userDetails?.salutation?.toString() ?? ''} ${userDetails?.name?.toString() ?? ''}',

            style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      // Text(
                      //   'Software Engineer',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.grey.shade400,
                      //   ),
                      // ),
                    ],
                  ),
                ),

                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
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
                          const Icon(Icons.person_outline, color: AppColors.primaryColor, size: 28),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                          const Text(
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

                      const Divider(),

                      // Detail Rows
                      _detailRow('Employee ID',  userDetails?.empId != null ? userDetails!.empId.toString() : "N/A"),
                      _detailRow('Gender',  userDetails?.gender != null ? userDetails!.gender.toString() : "N/A"),
                      _detailRow('Date of Birth', userDetails?.dob != null ? userDetails!.dob.toString() : "N/A"),
                      _detailRow('Joining Date', userDetails?.joiningDate != null ? userDetails!.joiningDate.toString() : "N/A"),
                      _detailRow('Father Name', userDetails?.fatherName != null ? userDetails!.fatherName.toString() : "N/A"),
                      _detailRow('Mother Name', userDetails?.motherName != null ? userDetails!.motherName.toString() : "N/A"),
                      _detailRow('Marital Status', userDetails?.maritalStatus != null ? userDetails!.maritalStatus.toString() : "N/A"),
                      _detailRow('Blood Group', userDetails?.bloodGroup != null ? userDetails!.bloodGroup.toString() : "N/A"),
                      _detailRow('Signature', userDetails?.signature != null ? userDetails!.signature.toString() : "N/A"),
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
                      _detailRow('Qualification', userDetails?.qualification != null ? userDetails!.qualification.toString() : "N/A"),
                      _detailRow('Work Experience', userDetails?.experience != null ? userDetails!.experience.toString() : "N/A"),
                      _detailRow('User Type', userDetails?.userType != null ? userDetails!.userType.toString() : "N/A"),
                      _detailRow('Specialist', userDetails?.specialization != null ? userDetails!.specialization.toString() : "N/A"),
                      _detailRow('Doctor Type', userDetails?.doctorType != null ? userDetails!.doctorType.toString() : "N/A"),
                      _detailRow('Doctor Fees', userDetails?.doctorFees != null ? userDetails!.doctorFees.toString() : "N/A"),
                      _detailRow('Commission Type', userDetails?.commissionType != null ? userDetails!.commissionType.toString() : "N/A"),
                      _detailRow('Commission Amount', userDetails?.commissionAmount != null ? userDetails!.commissionAmount.toString() : "N/A"),
                      _detailRow('Basic Salary', userDetails?.basicSalary != null ? userDetails!.basicSalary.toString() : "N/A"),
                      _detailRow('Note', userDetails?.note != null ? userDetails!.note.toString() : "N/A"),

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
                      _detailRow('Current Address', userDetails?.currentAddress != null ? userDetails!.currentAddress.toString() : "N/A"),
                      _detailRow('Permanent Address', userDetails?.permanentAddress != null ? userDetails!.permanentAddress.toString() : "N/A"),
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
                      _detailRow('Email Id', userDetails?.email != null ? userDetails!.email.toString() : "N/A"),
                      _detailRow('Mobile No', userDetails?.phoneNo != null ? userDetails!.phoneNo.toString() : "N/A"),
                      _detailRow('WhatsApp No', userDetails?.whatsappNo != null ? userDetails!.whatsappNo.toString() : "N/A"),
                      _detailRow('Emg No', userDetails?.emgNo != null ? userDetails!.emgNo.toString() : "N/A"),

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
                      _detailRow('PAN Number', userDetails?.panNumber != null ? userDetails!.panNumber.toString() : "N/A"),
                      _detailRow('Identification Number', userDetails?.identificationNumber != null ? userDetails!.identificationNumber.toString() : "N/A"),

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

import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/features/admin_module/users/data/users_usecase.dart';
import 'package:hospital_hr/features/admin_module/users/model/user_details_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/common_utils.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDetailsApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.screenContentPadding),
          child: isLoading?const Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ):Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonHeader(headerName: 'Profile Details'),
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
                        child: const CircleAvatar(
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

              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
              Center(
                child: Column(
                  children: [
                     Text(
                   ' ${userDetails?.salutation.toString()??""} ${userDetails?.name.toString()??""}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        fontFamily: "Poppins"
                      ),
                    ),
                    Text(
                      userDetails?.doctorType.toString()??"",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade100,
                          fontFamily: "Poppins"
                      ),
                    ),
                    Text(
                      'Emp Id: ${userDetails?.empId.toString()??""}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade200,
                          fontFamily: "Poppins"
                      ),
                    ),
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
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      children: [
                        const Icon(Icons.contact_page, color: AppColors.primaryColor, size: 28),
                        SizedBox(width: ScreenUtils().screenHeight(context) * 0.01),
                        const Text(
                          'Contact',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            fontFamily: "Poppins"
                          ),
                        ),
                      ],
                    ),

                    const Divider(),

                    // Detail Rows
                    _detailRow('Email Id', userDetails?.email.toString()??""),
                    _detailRow('Mobile No', userDetails?.phoneNo.toString()??""),
                    _detailRow('WhatsApp No',(userDetails?.whatsappNo != null) ? userDetails!.whatsappNo.toString() : "N/A"),
                    _detailRow('Emg No', (userDetails?.emgNo != null) ? userDetails!.emgNo.toString() : "N/A"),
                    _detailRow('Current Address', (userDetails?.currentAddress != null) ? userDetails!.currentAddress.toString() : "N/A"),
                    _detailRow('Gender', (userDetails?.gender != null) ? userDetails!.gender.toString() : "N/A"),
                    _detailRow('Pan Number', (userDetails?.panNumber != null) ? userDetails!.panNumber.toString() : "N/A"),

                  ],
                ),
              ),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

            ],
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontFamily: "Poppins"
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
                fontFamily: "Poppins"
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
    final userId = await _pref.getUserId();
    Map<String, dynamic> requestData = {
      "id": userId,
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

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/constants/app_colors.dart';
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


class DashboardUser extends StatefulWidget {
  const DashboardUser({super.key});

  @override
  _DashboardUserState createState() => _DashboardUserState();
}

class _DashboardUserState extends State<DashboardUser> {
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
                CommonHeader(headerName: 'Dashboard'),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),


                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  margin: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey[100]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Avatar with Border
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blueAccent, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: _image != null
                                  ? FileImage(_image!)
                                  : NetworkImage('https://picsum.photos/200/300?random=2') as ImageProvider,
                              backgroundColor: Colors.grey.shade200,
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: _showImagePickerOptions,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.blueAccent,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // User Info
                      Column(
                        children: [
                          Text(
                            'Sourav Mondal',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey[900],
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Software Engineer',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Emp ID: 2134',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.001),

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
                          SizedBox(width: 8),
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
                      SizedBox(height: 16),
                      Divider(),
                      _detailRow('Joining Date', '12-02-2022'),
                      _detailRow('Blood Group', 'AB+'),
                    ],
                  ),
                ),
                SizedBox(height: 5),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Events',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                        ),
                        SizedBox(height: 10),

                        // Tab Bar
                        TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black54,
                          indicator: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tabs: const [
                            Tab(text: "Upcoming Events"),
                            Tab(text: "Past Events"),
                          ],
                        ),
                        SizedBox(height: 12),

                        // Tab Views
                        SizedBox(
                          height: 260,
                          child: TabBarView(
                            children: [
                              // Upcoming Events
                              ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 4,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Upcoming Event ${index + 1}',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                          SizedBox(height: 8),
                                          Text('Details: Sample details of the event.'),
                                          SizedBox(height: 4),
                                          Text('Date: 2025-04-${index + 10}'),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Past Events
                              ListView.builder(
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 4,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Past Event ${index + 1}',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                          SizedBox(height: 8),
                                          Text('Details: Sample details of the event.'),
                                          SizedBox(height: 4),
                                          Text('Date: 2025-04-${index + 5}'),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

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
                          Icon(Icons.notifications_active, color: AppColors.primaryColor, size: 28),
                          SizedBox(width: 8),
                          Text(
                            'Notices',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Scrollable List of Notices
                      Container(
                        height: 160, // You can adjust height as needed
                        child: ListView.separated(
                          itemCount: 4, // Example count
                          separatorBuilder: (_, __) => Divider(color: Colors.grey[300]),
                          itemBuilder: (context, index) {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.circle, size: 8, color: Colors.black54),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Notice ${index + 1}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'This is a sample description of notice ${index + 1}. It can be a bit longer to test scrolling.',
                                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        'Date: 2025-04-${10 + index}',
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),

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
                          SizedBox(width: 8),
                          Text(
                            'Work',
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
                      _detailRow('Work Experience', '2 years'),
                      _detailRow('Specialist', 'Heart Specialist'),
                    ],
                  ),
                ),
                SizedBox(height: 10),

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
                          SizedBox(width: 8),
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
                      SizedBox(height: 16),

                      Divider(),
                      // Detail Rows
                      _detailRow('Email Id', 'sourav.dits@gmail.com'),
                      _detailRow('Mobile No', '1234567890'),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
}

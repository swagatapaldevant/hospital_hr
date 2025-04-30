import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/core/utils/commonWidgets/common_dialog.dart';
import 'package:hospital_hr/core/utils/commonWidgets/dashboard_drawer_menu.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';


class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _advancedDrawerController = AdvancedDrawerController();
  TextEditingController searchController = TextEditingController();
  DateTime? currentBackPressTime;
  final SharedPref _pref = getIt<SharedPref>();

  bool agreeWithTerm = false;
  bool isLoading = false;
  bool startEditing = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
    AppDimensions.init(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        DateTime now = DateTime.now();
        if (didPop || currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          Fluttertoast.showToast(msg: 'Tap back again to Exit');
          // return false;
        }else{
          SystemNavigator.pop();
        }
      },
      child: AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.darkBlue,
        ),
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: false,
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              // color:  Colors.blueGrey.withOpacity(0.4),
                color: AppColors.darkBlue.withOpacity(0.2),
                offset: const Offset(0.0, 3.0),
                blurRadius: 8.0)
          ],
          borderRadius: const BorderRadius.all(Radius.circular(25)),
        ),
        drawer: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Aligning the Educare ERP text at the top
                Padding(
                  padding: EdgeInsets.all(
                    ScreenUtils().screenWidth(context) * 0.05,
                  ),
                  child: GradientText(
                    "Hospital User",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: ScreenUtils().screenWidth(context) * 0.07,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Philosopher",
                    ),
                    gradientType: GradientType.linear,
                    gradientDirection: GradientDirection.ttb,
                    radius: 2.5,
                    colors: [
                      AppColors.white,
                      AppColors.gray3,
                      AppColors.gray7,
                    ],
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Adding space between title and logout menu
                SizedBox(
                    height: ScreenUtils().screenHeight(context) *
                        0.01), // Adjust height as needed

                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      MenuItem(
                        title: 'Dashboard',
                        icon: Icons.home,
                        onClicked: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/UserHomeScreen",
                                (Route<dynamic> route) => false,
                          );

                          //Navigator.pushNamed(context, "/UserHomeScreen");
                        },
                      ),
                      MenuItem(
                        title: 'Profile',
                        icon: Icons.person,
                        onClicked: () {
                          Navigator.pushNamed(context, "/ProfileUser");
                        },
                      ),
                      MenuItem(
                        title: 'Departments',
                        icon: Icons.design_services,
                        onClicked: () {
                          Navigator.pushNamed(context, "/DashboardDepartments");
                        },
                      ),
                      // MenuItem(
                      //   title: 'Designations',
                      //   icon: Icons.work,
                      //   onClicked: () {
                      //     Navigator.pushNamed(context, "/WorkModuleScreenEmployee");
                      //   },
                      //
                      // ),
                      MenuItem(
                        title: 'Events',
                        icon: Icons.calendar_month,
                        onClicked: () {
                          Navigator.pushNamed(context, "/DashboardEvent");
                        },
                      ),
                      MenuItem(
                        title: 'Attendance',
                        icon: Icons.groups,
                        onClicked: () {
                          Navigator.pushNamed(context, "/DashboardAttendanceUser");
                        },
                      ),
                      MenuItem(
                        title: 'Payroll',
                        icon: Icons.payment,
                        onClicked: () {
                          Navigator.pushNamed(context, "/DashboardPayrollUser");
                        },
                      ),
                      MenuItem(
                        title: 'Notice',
                        icon: Icons.note_alt,
                        onClicked: () {
                          Navigator.pushNamed(context, "/DashboardNotice");

                        },
                      ),
                      MenuItem(
                        title: 'Log Out',
                        icon: Icons.logout,
                        onClicked: () {
                          CommonDialog(
                              icon: Icons.logout,
                              title: "Log Out",
                              msg:
                              "You are about to logout of your account. Please confirm.",
                              activeButtonLabel: "Log Out",
                              context: context,
                              activeButtonOnClicked: () {
                                _pref.clearOnLogout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/LogInTypeScreens",
                                      (Route<dynamic> route) => false,
                                );

                              }, activeButtonName: 'Confirm', activeButtonSolidColor: AppColors.colorGreen);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.screenContentPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          _advancedDrawerController.showDrawer();
                        },
                        child: Icon(Icons.menu, color: AppColors.white,)),
                    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Avatar with Border
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage:  NetworkImage('https://picsum.photos/200/300?random=2'),
                            backgroundColor: Colors.grey.shade200,
                          ),
                        ),
                        Column(
                          children: [
                            const Text(
                              'Sourav Mondal',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                            const Text(
                              'Software Engineer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                    SizedBox(height: ScreenUtils().screenHeight(context) * 0.02),

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
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
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
                          SizedBox(height: ScreenUtils().screenHeight(context) * 0.001),
                          Divider(),
                          _detailRow('Joining Date', '12-02-2022'),
                          _detailRow('Blood Group', 'AB+'),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtils().screenHeight(context) * 0.001),

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
                            SizedBox(height: ScreenUtils().screenHeight(context) * 0.001),

                            // Tab Bar
                            TabBar(
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.black54,
                              // indicator: BoxDecoration(
                              //   color: Colors.pinkAccent,
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              tabs: const [
                                Tab(text: "Upcoming Events"),
                                Tab(text: "Past Events"),
                              ],
                            ),
                            SizedBox(height: ScreenUtils().screenHeight(context) * 0.001),

                            // Tab Views
                            SizedBox(
                              height: ScreenUtils().screenHeight(context) * 0.01,
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
                                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.001),
                                              Text('Details: Sample details of the event.'),
                                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.001),
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
                                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.001),
                                              Text('Details: Sample details of the event.'),
                                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.001),
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
                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
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
                          SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

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
                                    SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
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
                                          SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                                          Text(
                                            'This is a sample description of notice ${index + 1}. It can be a bit longer to test scrolling.',
                                            style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                          ),
                                          SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
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
                              SizedBox(width: ScreenUtils().screenHeight(context) * 0.01),
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
                          SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                          Divider(),
                          _detailRow('Work Experience', '2 years'),
                          _detailRow('Specialist', 'Heart Specialist'),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

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
                          SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                          Divider(),
                          // Detail Rows
                          _detailRow('Email Id', 'sourav.dits@gmail.com'),
                          _detailRow('Mobile No', '1234567890'),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                  ],
                ),
              ),
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


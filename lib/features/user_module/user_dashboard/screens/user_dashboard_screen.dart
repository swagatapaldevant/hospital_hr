import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../../core/utils/commonWidgets/dashboard_drawer_menu.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart'; // For time formatting


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

  bool agreeWithTerm = false;
  bool isLoading = false;
  bool startEditing = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.darkBlue,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: [ Color(0xffB4D1D8),
        //       AppColors.colorPrimaryText2,
        //       Color(0xff467483),],
        //   ),
        // ),
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
                        Navigator.pushNamed(context, "/DashboardModuleScreen");
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
                    MenuItem(
                      title: 'Designations',
                      icon: Icons.work,
                      onClicked: () {
                        Navigator.pushNamed(context, "/WorkModuleScreenEmployee");
                      },

                    ),
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
                              //_pref.clearOnLogout();

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
              child: Padding(
                  padding: EdgeInsets.all(AppDimensions.screenContentPadding),
                  child: SingleChildScrollView(

                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                                Text(
                                  '  Hi User',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Expanded(child:
                            //     Text(
                            //       'Users List',
                            //       style: TextStyle(
                            //         fontSize: 18,
                            //         fontWeight: FontWeight.bold,
                            //         color: AppColors.white,
                            //       ),
                            //     ),
                            //     ),
                            //
                            //
                            //     Text(
                            //       '  Add User',
                            //       style: TextStyle(
                            //         fontSize: 18,
                            //         fontWeight: FontWeight.bold,
                            //         color: AppColors.white,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                           // SizedBox(height: 10),



                            // TextField(
                            //   controller: searchController,
                            //   decoration: InputDecoration(
                            //     hintText: 'Search users...',
                            //     hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500), // Hint text in black
                            //     prefixIcon: Icon(Icons.search, color: Colors.black), // Search icon in black
                            //     filled: true,
                            //     fillColor: Colors.white, // White background
                            //     border: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //       borderSide: BorderSide(color: Colors.black),
                            //     ),
                            //     enabledBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //       borderSide: BorderSide(color: Colors.black),
                            //     ),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(12),
                            //       borderSide: BorderSide(color: Colors.black, width: 1.5),
                            //     ),
                            //     contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            //   ),
                            // ),

                            //SizedBox(height: 10),


                          //   ListView.builder(itemCount: 10, shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
                          //   itemBuilder: (BuildContext context, int index) {
                          //    return Padding(
                          //      padding:  EdgeInsets.only(bottom:10 ),
                          //      child: Container(
                          //       padding: EdgeInsets.all(20),
                          //       decoration: BoxDecoration(
                          //         color: Color(0xFFe0f7fa), // Light blue background
                          //         borderRadius: BorderRadius.circular(16),
                          //         boxShadow: [
                          //           BoxShadow(
                          //             color: Colors.black26,
                          //             blurRadius: 10,
                          //             offset: Offset(0, 6),
                          //           ),
                          //         ],
                          //       ),
                          //       child: SingleChildScrollView(
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Column(
                          //                   crossAxisAlignment: CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       'Sourav Mondal',
                          //                       style: TextStyle(
                          //                         fontSize: 22,
                          //                         fontWeight: FontWeight.w600,
                          //                         color: Color(0xFF006064),
                          //                       ),
                          //                     ),
                          //                     SizedBox(height: 4),
                          //                     Text(
                          //                       'EId: 213',
                          //                       style: TextStyle(
                          //                         fontSize: 16,
                          //                         color: Color(0xFF004d40),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 PopupMenuButton<int>(
                          //                   icon: Icon(Icons.more_vert, color: Colors.black87),
                          //                   onSelected: (value) {
                          //                     if (value == 1) {
                          //                       Navigator.pushNamed(context, "/ViewUser");
                          //                     } else if (value == 2) {
                          //                       Navigator.pushNamed(context, "/EditUser");
                          //                       // Edit functionality here
                          //                     }
                          //                   },
                          //                   itemBuilder: (BuildContext context) => [
                          //                     PopupMenuItem<int>(
                          //                       value: 1,
                          //                       child: Text('View'),
                          //                     ),
                          //                     PopupMenuItem<int>(
                          //                       value: 2,
                          //                       child: Text('Edit'),
                          //                     ),
                          //                   ],
                          //                 )
                          //               ],
                          //             ),
                          //             SizedBox(height: 16),
                          //             Row(
                          //               children: [
                          //                 Icon(Icons.email, color: Colors.teal[800]),
                          //                 SizedBox(width: 8),
                          //                 Text(
                          //                   'sourav.dits@gmail.com',
                          //                   style: TextStyle(
                          //                     fontSize: 16,
                          //                     color: Color(0xFF004d40),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(height: 8),
                          //             Row(
                          //               children: [
                          //                 Icon(Icons.phone, color: Colors.teal[800]),
                          //                 SizedBox(width: 8),
                          //                 Text(
                          //                   '9807654321',
                          //                   style: TextStyle(
                          //                     fontSize: 16,
                          //                     color: Color(0xFF004d40),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(height: 8),
                          //             Row(
                          //               children: [
                          //                 Icon(Icons.work_outline, color: Colors.teal[800]),
                          //                 SizedBox(width: 8),
                          //                 Text(
                          //                   'Software Engineer',
                          //                   style: TextStyle(
                          //                     fontSize: 16,
                          //                     color: Color(0xFF004d40),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(height: 8),
                          //             Row(
                          //               children: [
                          //                 Icon(Icons.check_circle, color: Colors.green),
                          //                 SizedBox(width: 8),
                          //                 Text(
                          //                   'Status: Active',
                          //                   style: TextStyle(
                          //                     fontSize: 16,
                          //                     color: Color(0xFF00796B),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //                                  ),
                          //    );
                          // },
                          //   ),

                            SizedBox(height: 12),

                            SizedBox(
                              height: ScreenUtils().screenHeight(context) * 0.05,
                            ),
                          ]))))),
    );
  }
}


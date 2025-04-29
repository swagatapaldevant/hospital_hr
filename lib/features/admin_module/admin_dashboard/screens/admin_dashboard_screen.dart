import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:hospital_hr/core/utils/commonWidgets/common_dialog.dart';
import 'package:hospital_hr/core/utils/commonWidgets/dashboard_drawer_menu.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
                  "Hospital Admin",
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
                          "/AdminHomeScreen",
                              (Route<dynamic> route) => false,
                        );
                      },
                    ),

                    MenuItem(
                      title: 'Users',
                      icon: Icons.person,
                      onClicked: () {
                        Navigator.pushNamed(context, "/DashboardUsersAdmin");
                      },
                    ),
                    MenuItem(
                      title: 'Departments',
                      icon: Icons.design_services,
                      onClicked: () {
                        Navigator.pushNamed(context, "/DashboardDepartmentsAdmin");
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
                        Navigator.pushNamed(context, "/DashboardEventAdmin");

                      },
                    ),
                    MenuItem(
                      title: 'Attendance',
                      icon: Icons.groups,
                      onClicked: () {
                        Navigator.pushNamed(context, "/DashboardAttendanceAdmin");
                      },
                    ),
                    MenuItem(
                      title: 'Payroll',
                      icon: Icons.payment,
                      onClicked: () {
                        Navigator.pushNamed(context, "/DashboardPayrollAdmin");

                      },
                    ),
                    MenuItem(
                      title: 'Notice',
                      icon: Icons.note_alt,
                      onClicked: () {
                        Navigator.pushNamed(context, "/DashboardNoticeAdmin");

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
        backgroundColor: Colors.blue[900],
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                // Admin Info
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: _boxDecoration(),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                      ),
                    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                      Text('Admin Name',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('HR Manager',
                          style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                    ],
                  ),
                ),

               SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                // Employee Overview
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: _boxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(Icons.people, '  Employee Overview'),
                      const Divider(),
                      _detailRow('Total Employees', '57'),
                      _detailRow('New Joinees This Month', '3'),
                      _detailRow('Pending Onboarding', '2'),
                    ],
                  ),
                ),

    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                // Leave Requests
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: _boxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(Icons.assignment_turned_in, '  Leave Requests'),
                      const Divider(),
                      _detailRow('Pending Approvals', '4'),
                      _detailRow('Approved Today', '2'),
                      _detailRow('Rejected Today', '1'),
                    ],
                  ),
                ),

                    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                // Events
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: _boxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(Icons.event, '  Upcoming Events'),
                      SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                      ...List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Event ${index + 1}',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('Details of event ${index + 1}'),
                              Text('Date: 2025-04-${index + 20}'),
                              const Divider(),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                // Notices
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: _boxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(Icons.notifications_active, '  Notices'),
                      SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                      ...List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.circle, size: 8, color: Colors.black54),
    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Notice ${index + 1}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600, fontSize: 16)),
    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                                    Text(
                                        'Details for notice ${index + 1}. Could be an announcement, update, or alert.'),
                                    Text(
                                      'Date: 2025-04-${index + 10}',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
    SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 24),
        SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
        Text(
          title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
        ),
      ],
    );
  }
  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.primaryColor)),
        ],
      ),
    );
  }
  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}


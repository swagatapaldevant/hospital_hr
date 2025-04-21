// import 'package:flutter/material.dart';
// import '../../../../core/utils/commonWidgets/common_header.dart';
// import '../../../../core/utils/helper/app_dimensions.dart';
//
// class DashboardDepartmentsAdmin extends StatefulWidget {
//   @override
//   _DashboardDepartmentsAdminState createState() => _DashboardDepartmentsAdminState();
// }
//
// class _DashboardDepartmentsAdminState extends State<DashboardDepartmentsAdmin> {
//   // Variables to hold project details
//   String slno = "1";
//   String departmentname = "Test";
//   String departmentcode = "28821";
//
//
//   TextEditingController projectNameController = TextEditingController();
//   TextEditingController startDateController = TextEditingController();
//   TextEditingController dueDateController = TextEditingController();
//   TextEditingController searchController = TextEditingController();
//
//
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     AppDimensions.init(context);
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(AppDimensions.screenContentPadding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CommonHeader(
//                 headerName: 'Dashboard',
//               ),
//               SizedBox(height: 10),
//
//               Expanded(
//                 child: ListView.builder(
//                     itemCount: 10,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Card(
//                         elevation: 8.0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Sl. No.: $slno',
//                                   style: TextStyle(
//                                       fontSize: 16, fontWeight: FontWeight.bold)),
//                               SizedBox(height: 8),
//                               Text('Department Name: $departmentname',
//                                   style: TextStyle(fontSize: 16)),
//                               SizedBox(height: 8),
//                               Text('Department Code: $departmentcode',
//                                   style: TextStyle(fontSize: 16)),
//                               SizedBox(height: 8),
//
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
// }

import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF6200EE);
  static const cardBackgroundColor = Colors.white;
  static const white = Colors.white;
  static const black = Colors.black;
  static const white70 = Colors.white70;
  static const gray3 = Color(0xFFB0BEC5);
  static const gray7 = Color(0xFF455A64);
  static const darkBlue = Color(0xFF003366);
  static const colorGreen = Color(0xFF4CAF50);
}

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 20),

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
                    const SizedBox(height: 12),
                    Text('Admin Name',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('HR Manager',
                        style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Employee Overview
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: _boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeader(Icons.people, 'Employee Overview'),
                    const Divider(),
                    _detailRow('Total Employees', '57'),
                    _detailRow('New Joinees This Month', '3'),
                    _detailRow('Pending Onboarding', '2'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Leave Requests
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: _boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeader(Icons.assignment_turned_in, 'Leave Requests'),
                    const Divider(),
                    _detailRow('Pending Approvals', '4'),
                    _detailRow('Approved Today', '2'),
                    _detailRow('Rejected Today', '1'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Events
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: _boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeader(Icons.event, 'Upcoming Events'),
                    const SizedBox(height: 10),
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

              const SizedBox(height: 20),

              // Notices
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: _boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionHeader(Icons.notifications_active, 'Notices'),
                    const SizedBox(height: 10),
                    ...List.generate(3, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.circle, size: 8, color: Colors.black54),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Notice ${index + 1}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600, fontSize: 16)),
                                  const SizedBox(height: 4),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 24),
        const SizedBox(width: 8),
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

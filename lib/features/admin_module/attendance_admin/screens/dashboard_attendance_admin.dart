import 'package:flutter/material.dart';
import 'package:hospital_hr/core/utils/commonWidgets/custom_dropdown.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class DashboardAttendanceAdmin extends StatefulWidget {
  const DashboardAttendanceAdmin({super.key});

  @override
  _DashboardAttendanceAdminState createState() => _DashboardAttendanceAdminState();
}

class _DashboardAttendanceAdminState extends State<DashboardAttendanceAdmin> {
  Map<String, int> departmentstype = {"Cardiology": 1, "Radiology": 2, "Pediatrics": 3, "General": 4};

  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> allUsers = [
    {'name': 'Dr. Ayesha', 'department': 'Cardiology', 'status': 'Present'},
    {'name': 'Nurse John', 'department': 'Radiology', 'status': 'Absent'},
    {'name': 'Dr. Kamal', 'department': 'Pediatrics', 'status': 'Present'},
    {'name': 'Nurse Tina', 'department': 'Cardiology', 'status': 'Absent'},
    {'name': 'Dr. Sameer', 'department': 'General', 'status': 'Present'},
  ];

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _toggleStatus(int index) {
    setState(() {
      allUsers[index]['status'] =
      allUsers[index]['status'] == 'Present' ? 'Absent' : 'Present';
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.screenContentPadding),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonHeader(headerName: 'Attendance Details'),

                  PopupMenuButton<int>(
                    icon: Icon(Icons.person, color: Colors.white),
                    onSelected: (value) {
                      if (value == 1) {
                        Navigator.pushNamed(context, "/MyAttendanceAdmin");
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Text('My Attendance'),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

              // Date Picker
              InkWell(
                onTap: _pickDate,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Icon(Icons.calendar_today, color: AppColors.primaryColor),
                    ],
                  ),
                ),
              ),

              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

              CustomDropDownForTaskCreation(
                placeHolderText: 'Choose Department',
                onValueSelected: (String , int ) {  },

                data: departmentstype,

              ),

              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

              // Always show all users
              Expanded(
                child: ListView.builder(
                  itemCount: allUsers.length,
                  itemBuilder: (context, index) {
                    var user = allUsers[index];
                    bool isPresent = user['status'] == 'Present';

                    return GestureDetector(
                      onTap: () => _toggleStatus(index),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user['name'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins")),
                                Text(user['department'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        color: Colors.grey)),
                              ],
                            ),
                            Icon(
                              isPresent ? Icons.check_circle : Icons.cancel,
                              color: isPresent ? Colors.green : Colors.red,
                              size: 28,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

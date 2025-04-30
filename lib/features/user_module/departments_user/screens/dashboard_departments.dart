import 'package:flutter/material.dart';
import 'package:hospital_hr/core/utils/helper/screen_utils.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardDepartments extends StatefulWidget {
  @override
  _DashboardDepartmentsState createState() => _DashboardDepartmentsState();
}

class _DashboardDepartmentsState extends State<DashboardDepartments> {
  // Variables to hold project details
  String slno = "1";
  String departmentname = "Test";
  String departmentcode = "28821";


  TextEditingController projectNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();



  // Function to update start date
  void _updateStartDate(String date) {
    setState(() {
      startDateController.text = date;
    });
  }

  // Function to update due date
  void _updateDueDate(String date) {
    setState(() {
      dueDateController.text = date;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.screenContentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHeader(
                headerName: 'Departments List',
              ),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),



              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search departments...',
                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontFamily: "Poppins"), // Hint text in black
                  prefixIcon: Icon(Icons.search, color: Colors.black), // Search icon in black
                  filled: true,
                  fillColor: Colors.white, // White background
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),

              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),


              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sl. No.: $slno',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Poppins")),
                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                              Text('Department Name: $departmentname',
                                  style: TextStyle(fontSize: 16, fontFamily: "Poppins")),
                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                              Text('Department Code: $departmentcode',
                                  style: TextStyle(fontSize: 16, fontFamily: "Poppins")),
                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

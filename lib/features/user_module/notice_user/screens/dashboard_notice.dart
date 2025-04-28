import 'package:flutter/material.dart';
import 'package:hospital_hr/core/utils/helper/screen_utils.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardNotice extends StatefulWidget {
  @override
  _DashboardNoticeState createState() => _DashboardNoticeState();
}

class _DashboardNoticeState extends State<DashboardNotice> {
  // Variables to hold project details
  String slno = "1";
  String noticecontent = "Test";
  String details = "Super Admin";
  String date = "06-04-2025";
  String status = "Active";

  TextEditingController projectNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();


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
                headerName: 'Notice',
              ),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search notices...',
                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500), // Hint text in black
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
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sl. No: $slno',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                              ],),


                              Text('Notice Content: $noticecontent',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                              Text('Details: $details',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                              Text('Date: $date',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                              Text('Status: $status',
                                  style: TextStyle(fontSize: 16)),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Place FAB at the center of the screen
    );

  }
}

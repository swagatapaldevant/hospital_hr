import 'package:flutter/material.dart';
import '../../../../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardNoticeAdmin extends StatefulWidget {
  @override
  _DashboardNoticeAdminState createState() => _DashboardNoticeAdminState();
}

class _DashboardNoticeAdminState extends State<DashboardNoticeAdmin> {
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

  void showNoticeChangeDialog(BuildContext context) {
    CommonDialog(
      icon: Icons.save,
      activeButtonSolidColor: Colors.green,
      title: "Notice Deleted",
      msg: "You are about to delete notice. Please confirm.",
      activeButtonLabel: "Confirm",
      context: context,
      activeButtonOnClicked: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      activeButtonName: 'Confirm',
    );
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
                headerName: 'Notice',
              ),
              SizedBox(height: 10),

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

              SizedBox(height: 10),

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
                                  SizedBox(height: 8),


                                  PopupMenuButton<int>(
                                    icon: Icon(Icons.more_vert, color: Colors.black87),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        showNoticeChangeDialog(context);
                                      } else if (value == 2) {
                                        Navigator.pushNamed(context, "/EditNoticeAdmin");
                                        // Edit functionality here
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem<int>(
                                        value: 1,
                                        child: Text('Delete'),
                                      ),
                                      PopupMenuItem<int>(
                                        value: 2,
                                        child: Text('Edit'),
                                      ),
                                    ],
                                  ),],),


                              Text('Notice Content: $noticecontent',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),
                              Text('Details: $details',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),
                              Text('Date: $date',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),
                              Text('Status: $status',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),


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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddNoticeAdmin");

        },
        backgroundColor: AppColors.white, // Customize the button color
        child: Icon(Icons.save, color: Colors.pinkAccent), // Save icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Place FAB at the center of the screen
    );

  }
}

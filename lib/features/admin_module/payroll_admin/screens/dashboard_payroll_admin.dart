import 'package:flutter/material.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardPayrollAdmin extends StatefulWidget {
  @override
  _DashboardPayrollAdminState createState() => _DashboardPayrollAdminState();
}

class _DashboardPayrollAdminState extends State<DashboardPayrollAdmin> {
  // Variables to hold project details
  String month = "Jan,2025";
  String totaldays = "28 Days";
  String grosspay = "45000";
  String netpay = "34000";
  String deduction = "11000";


  TextEditingController projectNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  void showNoticeChangeDialog(BuildContext context) {
    // CommonDialog(
    //   icon: Icons.save,
    //   activeButtonSolidColor: Colors.green,
    //   title: "Notice Deleted",
    //   msg: "You are about to delete notice. Please confirm.",
    //   activeButtonLabel: "Confirm",
    //   context: context,
    //   activeButtonOnClicked: () {
    //     Navigator.pop(context);
    //     Navigator.pop(context);
    //   },
    //   activeButtonName: 'Confirm',
    // );
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
                headerName: 'Payroll List',
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
                                  Text('Month: $month',
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 8),


                                  PopupMenuButton<int>(
                                    icon: Icon(Icons.more_vert, color: Colors.black87),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        Navigator.pushNamed(context, "/ViewPayrollAdmin");
                                      }

                                    },
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem<int>(
                                        value: 1,
                                        child: Text('View'),
                                      ),
                                    ],
                                  ),],),


                              Text('Total Days: $totaldays',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),
                              Text('Gross Pay: $grosspay',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),
                              Text('Net Pay: $netpay',
                                  style: TextStyle(fontSize: 16)),
                              SizedBox(height: 8),
                              Text('Deduction: $deduction',
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
    );
  }
}

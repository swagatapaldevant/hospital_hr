import 'package:flutter/material.dart';
import 'package:hospital_hr/core/utils/helper/screen_utils.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardPayrollUser extends StatefulWidget {
  @override
  _DashboardPayrollUserState createState() => _DashboardPayrollUserState();
}

class _DashboardPayrollUserState extends State<DashboardPayrollUser> {
  DateTime? selectedMonth;

  String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  // Dummy payroll data
  final String totaldays = "28 Days";
  final String grosspay = "45000";
  final String netpay = "34000";
  final String deduction = "11000";

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showMonthPicker(
            context: context,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            initialDate: selectedMonth ?? DateTime.now(),
          ).then((DateTime? pickedDate) {
            if (pickedDate != null) {
              setState(() {
                selectedMonth = pickedDate;
              });
              print("Selected: $pickedDate");
            }
          });
        },
        child: const Icon(Icons.calendar_today),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppDimensions.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

              const CommonHeader(headerName: 'Payroll List'),
              SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search payroll...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Show selected month
              if (selectedMonth != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Text(
                    'Selected: ${formatMonthYear(selectedMonth!)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                )
              else
                const Text(
                  "No Month Selected",
                  style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: "Poppins"),
                ),

              const SizedBox(height: 20),

              if(selectedMonth != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Month: ${selectedMonth != null ? formatMonthYear(selectedMonth!) : 'Not selected'}',
                                    style: const TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  PopupMenuButton<int>(
                                    icon: const Icon(Icons.more_vert),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        Navigator.pushNamed(context, "/ViewPayrollAdmin");
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => [
                                      const PopupMenuItem<int>(
                                        value: 1,
                                        child: Text('View'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text('Total Days: $totaldays'),
                              Text('Gross Pay: $grosspay'),
                              Text('Net Pay: $netpay'),
                              Text('Deduction: $deduction'),
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

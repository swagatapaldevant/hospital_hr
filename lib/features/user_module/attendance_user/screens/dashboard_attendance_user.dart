
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';


class DashboardAttendanceUser extends StatefulWidget {
  const DashboardAttendanceUser({super.key});

  @override
  _DashboardAttendanceUserState createState() => _DashboardAttendanceUserState();
}

class _DashboardAttendanceUserState extends State<DashboardAttendanceUser> {



  final List<String> monthList = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  int monthIndex = 0;


  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    DateTime now = DateTime.now();
    DateTime firstDay = DateTime(now.year, now.month, 1);
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    List<DateTime> days = List.generate(daysInMonth, (index) => firstDay.add(Duration(days: index)));

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(AppDimensions.screenContentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHeader(headerName: 'Attendance Details',),
              SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monthly Attendance : January',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,fontFamily: "Poppins", color: AppColors.white),
                  ),
                  Text(
                    '  26 Days',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,fontFamily: "Poppins", color: AppColors.white),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        monthIndex--;
                      });

                    },
                    child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: Center(child: Icon(Icons.arrow_back_ios_new ))),
                  ) ,
                  Text(
                    monthList[monthIndex],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,fontFamily: "Poppins", color: AppColors.white),
                  ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        monthIndex++;
                      });

                    },
                    child: CircleAvatar(
                        backgroundColor: AppColors.white,
                        child: Center(child: Icon(Icons.arrow_forward_ios))),
                  )
                ],
              ),
              SizedBox(height: ScreenUtils().screenHeight(context)*0.03,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: days.length,
                  itemBuilder: (context, index) {
                    DateTime day = days[index];
                    bool isSunday = day.weekday == DateTime.sunday;
                    return Container(
                      decoration: BoxDecoration(
                        color: isSunday ? Colors.redAccent : Colors.blue[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        DateFormat('d').format(day),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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

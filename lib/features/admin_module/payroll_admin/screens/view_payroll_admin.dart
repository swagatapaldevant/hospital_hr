import 'package:flutter/material.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class ViewPayrollAdmin extends StatefulWidget {
  const ViewPayrollAdmin({super.key});

  @override
  _ViewPayrollAdminState createState() => _ViewPayrollAdminState();
}

class _ViewPayrollAdminState extends State<ViewPayrollAdmin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.screenContentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonHeader(headerName: 'Payroll Details'),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

                Center(
                  child: Column(
                    children: [
                      Text(
                        '  Devant IT Solutions',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'Sourav Mondal',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'Software Engineer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Text(
                        'Emp Id: 2134',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Icon(Icons.payment, color: AppColors.primaryColor, size: 28),
                          SizedBox(width: ScreenUtils().screenHeight(context) * 0.01),
                          Text(
                            'Payslip',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                      Divider(),

                      // Detail Rows
                      _detailRow('Basic Pay', '22000'),
                      _detailRow('Incentive Pay', '1455'),
                      _detailRow('Total Days', '28 Days'),
                      _detailRow('Gross Pay', '45000'),
                      _detailRow('Net Pay', '34000'),
                      _detailRow('Deduction', '11000'),

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

}

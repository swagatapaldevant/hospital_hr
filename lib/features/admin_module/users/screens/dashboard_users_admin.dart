import 'package:flutter/material.dart';
import '../../../../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class DashboardUsersAdmin extends StatefulWidget {
  @override
  _DashboardUsersAdminState createState() => _DashboardUsersAdminState();
}

class _DashboardUsersAdminState extends State<DashboardUsersAdmin> {

  TextEditingController projectNameController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool agreeWithTerm = false;
  bool isLoading = false;
  bool startEditing = false;



  // Function to update start date
  void _updateStartDate(String date) {
    setState(() {
      startDateController.text = date;
    });
  }


  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return
      Scaffold(

          body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(AppDimensions.screenContentPadding),
                  child: SingleChildScrollView(

                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child:
                                Text(
                                  'Users List',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),



                            TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Search users...',
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


                            ListView.builder(itemCount: 10, shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:  EdgeInsets.only(bottom:10 ),
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFe0f7fa), // Light blue background
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Sourav Mondal',
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xFF006064),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    'EId: 2134',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF004d40),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              PopupMenuButton<int>(
                                                icon: Icon(Icons.more_vert, color: Colors.black87),
                                                onSelected: (value) {
                                                  if (value == 1) {
                                                    Navigator.pushNamed(context, "/ViewUserAdmin");
                                                  } else if (value == 2) {
                                                    Navigator.pushNamed(context, "/EditUserAdmin");
                                                    // Edit functionality here
                                                  }
                                                },
                                                itemBuilder: (BuildContext context) => [
                                                  PopupMenuItem<int>(
                                                    value: 1,
                                                    child: Text('View'),
                                                  ),
                                                  PopupMenuItem<int>(
                                                    value: 2,
                                                    child: Text('Edit'),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Icon(Icons.email, color: Colors.teal[800]),
                                              SizedBox(width: 8),
                                              Text(
                                                'sourav.dits@gmail.com',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF004d40),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.phone, color: Colors.teal[800]),
                                              SizedBox(width: 8),
                                              Text(
                                                '9807654321',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF004d40),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.work_outline, color: Colors.teal[800]),
                                              SizedBox(width: 8),
                                              Text(
                                                'Software Engineer',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF004d40),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.check_circle, color: Colors.green),
                                              SizedBox(width: 8),
                                              Text(
                                                'Status: Active',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF00796B),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: 12),

                            SizedBox(
                              height: ScreenUtils().screenHeight(context) * 0.05,
                            ),
                          ]
                      )
                  )
              )
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/AddUserAdmin");

          },
          backgroundColor: AppColors.white, // Customize the button color
          child: Icon(Icons.save, color: Colors.pinkAccent), // Save icon
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
  }
}

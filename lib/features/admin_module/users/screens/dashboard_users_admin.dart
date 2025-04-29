import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/core/utils/commonWidgets/common_header.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/features/admin_module/users/data/users_usecase.dart';
import 'package:hospital_hr/features/admin_module/users/model/user_list_model.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class DashboardUsersAdmin extends StatefulWidget {
  const DashboardUsersAdmin({super.key});

  @override
  _DashboardUsersAdminState createState() => _DashboardUsersAdminState();
}

class _DashboardUsersAdminState extends State<DashboardUsersAdmin> {
  TextEditingController searchController = TextEditingController();
  final UsersUseCase _usersUseCase = getIt<UsersUseCase>();
  final SharedPref _pref = getIt<SharedPref>();
  List<UserListModel> allUserList = [];
  bool agreeWithTerm = false;
  bool isLoading = false;
  bool startEditing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allUserListApi();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenContentPadding),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: ScreenUtils().screenHeight(context)*0.02,),
                    const CommonHeader(
                      headerName: 'Users List',
                    ),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.03,
                    ),
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search users...',
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500), // Hint text in black
                        prefixIcon: const Icon(Icons.search,
                            color: Colors.black), // Search icon in black
                        filled: true,
                        fillColor: Colors.white, // White background
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    SizedBox(
                        height: ScreenUtils().screenHeight(context) * 0.03),
                   isLoading?const Center(
                     child: CircularProgressIndicator(
                       color: AppColors.white,
                     ),
                   ): ListView.builder(
                      itemCount: allUserList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color(
                                  0xFFe0f7fa), // Light blue background
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${allUserList[index].salutation != null ? '${allUserList[index].salutation} ' : ''}${allUserList[index].name}',
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF006064),
                                              fontFamily: "Poppins"
                                            ),
                                          ),

                                          SizedBox(
                                              height: ScreenUtils()
                                                      .screenHeight(context) *
                                                  0.01),
                                           Text(
                                            'EId: ${allUserList[index].empId}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF004d40),
                                                fontFamily: "Poppins"
                                            ),
                                          ),
                                        ],
                                      ),
                                      PopupMenuButton<int>(
                                        icon: const Icon(Icons.more_vert,
                                            color: Colors.black87),
                                        onSelected: (value) {
                                          if (value == 1) {
                                            Navigator.pushNamed(
                                                context, "/ViewUserAdmin", arguments: allUserList[index].id);
                                          }
                                          // else if (value == 2) {
                                          //   Navigator.pushNamed(
                                          //       context, "/EditUserAdmin");
                                          //
                                          // }
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          const PopupMenuItem<int>(
                                            value: 1,
                                            child: Text('View'),
                                          ),
                                          // const PopupMenuItem<int>(
                                          //   value: 2,
                                          //   child: Text('Edit'),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          ScreenUtils().screenHeight(context) *
                                              0.01),
                                  Row(
                                    children: [
                                      Icon(Icons.email,
                                          color: Colors.teal[800]),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                       Text(
                                        allUserList[index].email.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF004d40),
                                            fontFamily: "Poppins"
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          ScreenUtils().screenHeight(context) *
                                              0.01),
                                  Row(
                                    children: [
                                      Icon(Icons.phone,
                                          color: Colors.teal[800]),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                      ),
                                       Text(
                                        allUserList[index].phoneNo.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF004d40),
                                            fontFamily: "Poppins"
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.person,
                                          color: Colors.teal[800]),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                       Text(
                                         allUserList[index].gender.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF004d40),
                                            fontFamily: "Poppins"
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            allUserList[index].isActive == 1 ? Icons.check_circle : Icons.cancel,
                                            color: allUserList[index].isActive == 1 ? Colors.green : Colors.red,
                                          ),
                                          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                                          Text(
                                            'Login Status: ${allUserList[index].isActive == 1 ? "Active" : "Inactive"}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF00796B),
                                                fontFamily: "Poppins"
                                            ),
                                          ),
                                        ],
                                      ),
                                      Switch(
                                        value: allUserList[index].isActive == 1,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            allUserList[index].isActive = newValue ? 1 : 0;
                                          });
                                          updateActiveStatus(
                                            allUserList[index].id ?? 0,
                                            allUserList[index].isActive ?? 0,
                                          );
                                          // TODO: Call your backend API here to update the status
                                          // await yourApi.updateUserStatus(userId: allUserList[index].id, isActive: newValue ? 1 : 0);
                                        },
                                        activeColor: Colors.green,
                                        inactiveThumbColor: Colors.red,
                                      ),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    SizedBox(
                      height: ScreenUtils().screenHeight(context) * 0.05,
                    ),
                  ])))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddUserAdmin");
        },
        backgroundColor: AppColors.white, // Customize the button color
        child: const Icon(
          Icons.add,
          color: Colors.pinkAccent,
          size: 40,
        ), // Save icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  allUserListApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> requestData = {};

    Resource resource = await _usersUseCase.userList(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      allUserList = (resource.data as List)
          .map((x) => UserListModel.fromJson(x))
          .toList();

      setState(() {
        isLoading = false;

        CommonUtils().flutterSnackBar(
          context: context,
          mes: resource.message ?? "",
          messageType: 1,
        );
      });
    } else {
      CommonUtils().flutterSnackBar(
        context: context,
        mes: resource.message ?? "",
        messageType: 4,
      );
    }
  }


  updateActiveStatus(int userId, int isActive) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> requestData = {
      "id":userId,
      "is_active":isActive
    };

    Resource resource = await _usersUseCase.updateStatus(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {


      setState(() {
        isLoading = false;

        CommonUtils().flutterSnackBar(
          context: context,
          mes: resource.message ?? "",
          messageType: 1,
        );
      });
    } else {
      CommonUtils().flutterSnackBar(
        context: context,
        mes: resource.message ?? "",
        messageType: 4,
      );
    }
  }
}

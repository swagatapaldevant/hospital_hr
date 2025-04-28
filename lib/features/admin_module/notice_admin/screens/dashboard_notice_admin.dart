import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/utils/commonWidgets/common_dialog.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/data/notice_usecase.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/model/notice_list_model.dart';
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
  bool isLoading = false;
  List<NoticeListModel> allNoticeList = [];
  TextEditingController searchController = TextEditingController();
  final NoticeUsecase _noticeUseCase = getIt<NoticeUsecase>();

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
  void initState() {
    // TODO: implement initState
    super.initState();
    allNoticeListApi();
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
              const CommonHeader(
                headerName: 'Notice',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search notices...',
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Expanded(
                child: ListView.builder(
                    itemCount: allNoticeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Sl. No: ${allNoticeList[index].id}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  PopupMenuButton<int>(
                                    icon: const Icon(Icons.more_vert,
                                        color: Colors.black87),
                                    onSelected: (value) {
                                      if (value == 1) {
                                        showNoticeChangeDialog(context);
                                      } else if (value == 2) {
                                        Navigator.pushNamed(
                                            context, "/EditNoticeAdmin");
                                        // Edit functionality here
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => [
                                      const PopupMenuItem<int>(
                                        value: 1,
                                        child: Text('Delete'),
                                      ),
                                      const PopupMenuItem<int>(
                                        value: 2,
                                        child: Text('Edit'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Notice Content: ',
                                  style:  const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor
                                  ),
                                  children:  <TextSpan>[
                                    TextSpan(text:  allNoticeList[index].notice,
                                        style:  const TextStyle(
                                          fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          color: AppColors.colorBlack
                                        )),
                                  ],
                                ),
                              ),

                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),

                              RichText(
                                text: TextSpan(
                                  text: 'Details: ',
                                  style:  const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor
                                  ),
                                  children:  <TextSpan>[
                                    TextSpan(text:  allNoticeList[index].description,
                                        style:  const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.colorBlack
                                        )),
                                  ],
                                ),
                              ),

                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),


                              Text(
                                'Date: ${formatDate(allNoticeList[index].createdAt.toString())}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),

                              RichText(
                                text: TextSpan(
                                  text: 'Status: ',
                                  style:  const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor
                                  ),
                                  children:  <TextSpan>[
                                    TextSpan(text:  allNoticeList[index].isActive == 1 ? "Active" : "InActive",
                                        style:   TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: allNoticeList[index].isActive == 1? AppColors.colorGreen:AppColors.colorTomato
                                        )),
                                  ],
                                ),
                              ),


                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.01),
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
        child: const Icon(
          Icons.add,
          color: Colors.pinkAccent,
          size: 40,
        ), // Save icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Place FAB at the center of the screen
    );
  }

  allNoticeListApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> requestData = {};

    Resource resource =
        await _noticeUseCase.noticeList(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      allNoticeList = (resource.data as List)
          .map((x) => NoticeListModel.fromJson(x))
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

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return '${dateTime.day.toString().padLeft(2, '0')}-'
        '${dateTime.month.toString().padLeft(2, '0')}-'
        '${dateTime.year}';
  }
}

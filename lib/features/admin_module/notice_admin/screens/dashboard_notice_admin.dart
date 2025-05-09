import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/utils/commonWidgets/common_dialog.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/core/utils/helper/screen_utils.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/data/notice_usecase.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/model/notice_list_model.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardNoticeAdmin extends StatefulWidget {
  const DashboardNoticeAdmin({super.key});

  @override
  _DashboardNoticeAdminState createState() => _DashboardNoticeAdminState();
}

class _DashboardNoticeAdminState extends State<DashboardNoticeAdmin> {

  bool isLoading = false;

  TextEditingController searchController = TextEditingController();
  final NoticeUsecase _noticeUseCase = getIt<NoticeUsecase>();
  List<NoticeListModel> allNoticeList = [];
  List<NoticeListModel> filteredNoticeList = [];



  void showNoticeChangeDialog(BuildContext context, int id) {
    CommonDialog(
      icon: Icons.save,
      activeButtonSolidColor: Colors.green,
      title: "Notice Deleted",
      msg: "You are about to delete notice. Please confirm.",
      activeButtonLabel: "Confirm",
      context: context,
      activeButtonOnClicked: () {
        Navigator.pop(context);
        setState(() {
          deleteNoticeApi(id);
        });


      },
      activeButtonName: 'Confirm',
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(_onSearchChanged);
    allNoticeListApi();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }


  void _onSearchChanged() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredNoticeList = allNoticeList.where((notices) {
        final notice = notices.notice?.toLowerCase() ?? '';
        final description = notices.description?.toLowerCase() ?? '';

        return notice.contains(query) || description.contains(query) ;
      }).toList();
    });
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate a network call
    setState(() {
      allNoticeListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: AppColors.white,
          color: AppColors.colorBlue700,
          onRefresh: _refreshData,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenContentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                const CommonHeader(
                  headerName: 'Notice',
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Expanded(
                  child: isLoading?const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ): ListView.builder(
                    physics: const BouncingScrollPhysics(),
                      itemCount: filteredNoticeList.length,
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
                                    Text('Sl. No: ${filteredNoticeList[index].id}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Poppins",
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
                                          showNoticeChangeDialog(context,filteredNoticeList[index].id?? 0);
                                        } else if (value == 2) {
                                          Navigator.pushNamed(
                                              context, "/EditNoticeAdmin", arguments:filteredNoticeList[index].id);
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
                                    text: 'Notice: ',
                                    style:  const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                      fontFamily: "Poppins",
                                    ),
                                    children:  <TextSpan>[
                                      TextSpan(text:  filteredNoticeList[index].notice,
                                          style:  const TextStyle(
                                            fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            color: AppColors.colorBlack,
                                            fontFamily: "Poppins",
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      fontFamily: "Poppins",
                                    ),
                                    children:  <TextSpan>[
                                      TextSpan(text:  filteredNoticeList[index].description,
                                          style:  const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.colorBlack,
                                            fontFamily: "Poppins",
                                          )),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),
                                RichText(
                                  text: TextSpan(
                                    text: 'Priority Level: ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                        fontFamily: "Poppins"),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: filteredNoticeList[index]
                                              .priorityLevel
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: filteredNoticeList[index]
                                                  .priorityLevel
                                                  .toString() ==
                                                  "high"
                                                  ? AppColors.colorTomato
                                                  : Colors.orange,
                                              fontFamily: "Poppins")),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01),

                                RichText(
                                  text: TextSpan(
                                    text: 'Posted Date: ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                        fontFamily: "Poppins"),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: formatDate(filteredNoticeList[index]
                                              .createdAt
                                              .toString()),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.colorBlack,
                                              fontFamily: "Poppins")),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: ScreenUtils().screenHeight(context) *
                                        0.01),
                                RichText(
                                  text: TextSpan(
                                    text: 'Status: ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                        fontFamily: "Poppins"),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: filteredNoticeList[index]
                                              .isActive
                                              .toString() ==
                                              "1"
                                              ? "Active"
                                              : "Not Active",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.colorBlack,
                                              fontFamily: "Poppins")),
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
      filteredNoticeList = allNoticeList;

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


  deleteNoticeApi(int id) async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> requestData = {
      "id": id
    };

    Resource resource =
    await _noticeUseCase.deleteNoticeApi(requestData: requestData);

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

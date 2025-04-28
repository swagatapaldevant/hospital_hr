import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/core/utils/helper/screen_utils.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/data/notice_usecase.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/model/notice_list_model.dart';
import '../../../../core/network/apiHelper/locator.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardNotice extends StatefulWidget {
  const DashboardNotice({super.key});

  @override
  _DashboardNoticeState createState() => _DashboardNoticeState();
}

class _DashboardNoticeState extends State<DashboardNotice> {


  TextEditingController searchController = TextEditingController();
  final NoticeUsecase _noticeUseCase = getIt<NoticeUsecase>();
  List<NoticeListModel> allNoticeList = [];
  bool isLoading = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allNoticeListApi();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.screenContentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonHeader(
                headerName: 'Notice',
              ),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
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
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
             Expanded(
                child:  isLoading? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ):ListView.builder(
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
                              RichText(
                                text: TextSpan(
                                  text: 'Notice: ',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                      fontFamily: "Poppins"),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: allNoticeList[index]
                                            .notice
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
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
                                  text: 'Description: ',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                      fontFamily: "Poppins"),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: allNoticeList[index]
                                            .description
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
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
                                  text: 'Priority Level: ',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                      fontFamily: "Poppins"),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: allNoticeList[index]
                                            .priorityLevel
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: allNoticeList[index]
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
                                  height: ScreenUtils().screenHeight(context) *
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
                                        text: formatDate(allNoticeList[index]
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
                                        text: allNoticeList[index]
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
                                  height: ScreenUtils().screenHeight(context) *
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



import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/core/utils/helper/screen_utils.dart';
import 'package:hospital_hr/features/admin_module/events_admin/data/events_admin_usecase.dart';
import 'package:hospital_hr/features/admin_module/events_admin/models/event_list_model.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardEvent extends StatefulWidget {
  const DashboardEvent({super.key});

  @override
  _DashboardEventState createState() => _DashboardEventState();
}

class _DashboardEventState extends State<DashboardEvent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  final EventsAdminUsecase _eventsAdminUsecase = getIt<EventsAdminUsecase>();
  List<EventListModel> eventList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getAllEventList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppDimensions.init(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.screenContentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonHeader(headerName: 'Events'),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

              // Search Box
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
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
                    borderSide: const BorderSide(color: Colors.black, width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

              // Tab Bar
              TabBar(
                controller: _tabController,
                unselectedLabelStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(text: "Upcoming Events"),
                  Tab(text: "Past Events"),
                ],
              ),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),

              // Tab Views
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(
                  color: AppColors.white,
                ))
                    : TabBarView(
                  controller: _tabController,
                  children: [
                    buildEventList(isUpcoming: true),
                    buildEventList(isUpcoming: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEventList({required bool isUpcoming}) {
    final now = DateTime.now();

    List<EventListModel> filteredEvents = eventList.where((event) {
      if (event.eventDate == null) return false;
      DateTime? eventDate;
      try {
        eventDate = DateTime.parse(event.eventDate!);
      } catch (e) {
        return false;
      }
      return isUpcoming ? eventDate.isAfter(now) : eventDate.isBefore(now);
    }).toList();

    // Optional: sort the list
    filteredEvents.sort((a, b) {
      DateTime aDate = DateTime.tryParse(a.eventDate ?? '') ?? DateTime(1900);
      DateTime bDate = DateTime.tryParse(b.eventDate ?? '') ?? DateTime(1900);
      return isUpcoming ? aDate.compareTo(bDate) : bDate.compareTo(aDate);
    });

    if (filteredEvents.isEmpty) {
      return const Center(child: Text("No events found.", style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 16,
        color: AppColors.white,
        fontFamily: "Poppins"

      ),));
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) {
        final event = filteredEvents[index];
        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [




                Text(event.event ?? 'No Title',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: "Poppins")),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                RichText(
                  text: TextSpan(
                    text: 'Details: ',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontFamily: "Poppins"),
                    children: <TextSpan>[
                      TextSpan(
                          text: event.description ?? "No Description",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.colorBlack,
                              fontFamily: "Poppins")),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),

                RichText(
                  text: TextSpan(
                    text: 'Date: ',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontFamily: "Poppins"),
                    children: <TextSpan>[
                      TextSpan(
                          text: event.eventDate?.split('T').first ?? "No Date",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.colorBlack,
                              fontFamily: "Poppins")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  getAllEventList() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {};
    Resource resource = await _eventsAdminUsecase.eventList(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      eventList = (resource.data as List)
          .map((x) => EventListModel.fromJson(x))
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
      setState(() => isLoading = false);
      CommonUtils().flutterSnackBar(
        context: context,
        mes: resource.message ?? "",
        messageType: 4,
      );
    }
  }
}

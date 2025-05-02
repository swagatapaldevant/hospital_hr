
import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/core/utils/helper/screen_utils.dart';
import 'package:hospital_hr/features/admin_module/events_admin/data/events_admin_usecase.dart';
import 'package:hospital_hr/features/admin_module/events_admin/models/event_list_model.dart';
import 'package:intl/intl.dart';
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
  List<EventListModel> filteredEventList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
    _tabController = TabController(length: 2, vsync: this);
    getAllEventList();
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate a network call
      setState(() {
         getAllEventList();

      });

  }


  void _onSearchChanged() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredEventList = eventList.where((events) {
        final name = events.event?.toLowerCase() ?? '';
        final details = events.description?.toLowerCase() ?? '';

        return name.contains(query) || details.contains(query);
      }).toList();
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
                SizedBox(height: ScreenUtils().screenHeight(context)*0.01,),

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
                  child:  TabBarView(
                    controller: _tabController,
                    children: [
                      isLoading ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      ) :buildEventList(isUpcoming: true),
                      isLoading ?const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      ) :buildEventList(isUpcoming: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEventList({required bool isUpcoming}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Filter events based on search text
    final searchText = searchController.text.toLowerCase();
    List<EventListModel> searchedEvents = eventList.where((event) {
      return event.event?.toLowerCase().contains(searchText) ?? false;
    }).toList();

    // Filter events based on date (past/upcoming)
    List<EventListModel> filteredEvents = searchedEvents.where((event) {
      if (event.eventDate == null) return false;

      DateTime? eventDate = parseEventDate(event.eventDate!);
      if (eventDate == null) return false;

      final eventDateOnly = DateTime(eventDate.year, eventDate.month, eventDate.day);

      return isUpcoming
          ? eventDateOnly.isAfter(today) || eventDateOnly.isAtSameMomentAs(today)
          : eventDateOnly.isBefore(today);
    }).toList();

    // Sort events - upcoming in ascending order, past in descending order
    filteredEvents.sort((a, b) {
      DateTime? aDate = parseEventDate(a.eventDate ?? '');
      DateTime? bDate = parseEventDate(b.eventDate ?? '');

      if (aDate == null || bDate == null) return 0;
      return isUpcoming ? aDate.compareTo(bDate) : bDate.compareTo(aDate);
    });

    if (filteredEvents.isEmpty) {
      return Center(
        child: Text(
          isUpcoming ? "No upcoming events found." : "No past events found.",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.white,
            fontFamily: "Poppins",
          ),
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: filteredEvents.length,
      itemBuilder: (context, index) {
        final event = filteredEvents[index];
        DateTime? eventDate = parseEventDate(event.eventDate ?? '');

        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        event.event ?? 'No Title',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: "Poppins"
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                  ],
                ),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                RichText(
                  text: TextSpan(
                    text: 'Details: ',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontFamily: "Poppins"
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: event.description ?? "No Description",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorBlack,
                            fontFamily: "Poppins"
                        ),
                      ),
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
                        fontFamily: "Poppins"
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: eventDate != null
                            ? DateFormat('dd/MM/yyyy').format(eventDate)
                            : "Invalid Date",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.colorBlack,
                            fontFamily: "Poppins"
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.01),
                RichText(
                  text: TextSpan(
                    text: 'Status: ',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontFamily: "Poppins"
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: event.isActive == 1?"Active":"Not Active",
                        style:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: event.isActive == 1? AppColors.colorGreen:AppColors.colorTomato,
                            fontFamily: "Poppins"
                        ),
                      ),
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

  DateTime? parseEventDate(String dateString) {
    try {
      // Try parsing ISO format (2025-05-10)
      if (dateString.contains('-')) {
        return DateTime.parse(dateString);
      }
      // Try parsing dd/MM/yyyy or d/M/yyyy format (29/4/2025 or 10/4/2025)
      else if (dateString.contains('/')) {
        final parts = dateString.split('/');
        if (parts.length == 3) {
          return DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      }
    } catch (e) {
      debugPrint("Error parsing date '$dateString': $e");
    }
    return null;
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
      filteredEventList = eventList;

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



import 'package:flutter/material.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardEventAdmin extends StatefulWidget {
  @override
  _DashboardEventAdminState createState() => _DashboardEventAdminState();
}

class _DashboardEventAdminState extends State<DashboardEventAdmin> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          padding: EdgeInsets.all(AppDimensions.screenContentPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHeader(headerName: 'Events'),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),

              // Search Box
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search events...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              // Tab Bar
              TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                indicatorColor: Colors.pinkAccent,
                tabs: [
                  Tab(text: "Upcoming Events"),
                  Tab(text: "Past Events"),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),

              // Tab Views
              Expanded(
                child: TabBarView(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddEventsAdmin");

        },
        backgroundColor: AppColors.white, // Customize the button color
        child: Icon(Icons.add, color: Colors.pinkAccent), // Save icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildEventList({required bool isUpcoming}) {
    return ListView.builder(
      itemCount: 5, // Replace with actual count
      itemBuilder: (context, index) {
        String type = isUpcoming ? "Upcoming" : "Past";
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
                    Text('$type Event ${index + 1}',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    PopupMenuButton<int>(
                      icon: Icon(Icons.more_vert, color: Colors.black87),
                      onSelected: (value) {
                        if (value == 1) {
                          Navigator.pushNamed(context, "/EditEventsAdmin");
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<int>(
                          value: 1,
                          child: Text('Edit'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text('Details: Sample details of the event.'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text('Date: 2025-04-${index + 10}'),
              ],
            ),
          ),
        );
      },
    );

  }

}

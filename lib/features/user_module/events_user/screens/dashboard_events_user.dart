// import 'package:flutter/material.dart';
//
// import '../../../../core/utils/commonWidgets/common_header.dart';
// import '../../../../core/utils/helper/app_dimensions.dart';
//
// class EventScreen extends StatefulWidget {
//   @override
//   _EventScreenState createState() => _EventScreenState();
// }
//
// class _EventScreenState extends State<EventScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this); // Two tabs
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose(); // Clean up controller
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//               padding: EdgeInsets.all(AppDimensions.screenContentPadding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CommonHeader(
//                 headerName: 'Events',
//               ),
//               SizedBox(height: 10),
//               bottom: TabBar(
//                 controller: _tabController,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 indicatorColor: Colors.white,
//                 tabs: [
//                   Tab(text: "Upcoming"),
//                   Tab(text: "Past"),
//                 ],
//               ),
//
//
//
//
//             ],
//
//               ],,
//           ),))
//       appBar: AppBar(
//
//         title: Text("Events"),
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           indicatorColor: Colors.white,
//           tabs: [
//             Tab(text: "Upcoming"),
//             Tab(text: "Past"),
//           ],
//         ),
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           UpcomingEventsTab(),
//           PastEventsTab(),
//         ],
//       ),
//     );
//   }
// }
//
// class UpcomingEventsTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(16),
//       children: [
//         EventCard(title: "Tech Conference 2025", date: "May 10, 2025"),
//         EventCard(title: "Flutter Workshop", date: "June 15, 2025"),
//       ],
//     );
//   }
// }
//
// class PastEventsTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: EdgeInsets.all(16),
//       children: [
//         EventCard(title: "AI Meetup", date: "Jan 20, 2025"),
//         EventCard(title: "Mobile Dev Summit", date: "Feb 5, 2025"),
//       ],
//     );
//   }
// }
//
// class EventCard extends StatelessWidget {
//   final String title;
//   final String date;
//
//   const EventCard({required this.title, required this.date});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 6,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: Icon(Icons.event, color: Colors.pinkAccent),
//         title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(date),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/helper/app_dimensions.dart';

class DashboardEvent extends StatefulWidget {
  @override
  _DashboardEventState createState() => _DashboardEventState();
}

class _DashboardEventState extends State<DashboardEvent> with SingleTickerProviderStateMixin {
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
              SizedBox(height: 10),

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
              SizedBox(height: 10),

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
              SizedBox(height: 10),

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
                Text('$type Event ${index + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text('Details: Sample details of the event.'),
                SizedBox(height: 4),
                Text('Date: 2025-04-${index + 10}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

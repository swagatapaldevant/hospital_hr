import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/features/admin_module/events_admin/data/events_admin_usecase.dart';
import 'package:intl/intl.dart'; // For formatting the date
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import '../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class EditEventsAdmin extends StatefulWidget {
  final int eventId;
  const EditEventsAdmin({super.key, required this.eventId});

  @override
  _EditEventsAdminState createState() => _EditEventsAdminState();
}

class _EditEventsAdminState extends State<EditEventsAdmin> {

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EventsAdminUsecase _eventsAdminUsecase = getIt<EventsAdminUsecase>();
  late int postBy;
  late int activeStatus;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEventDetails();
  }
  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_dateController.text) ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  Widget editableField(String label,int? maxLines, TextEditingController controller, {bool isDate = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: isDate,
        maxLines: maxLines??1,
        onTap: isDate ? pickDate : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: isDate ? Icon(Icons.calendar_today) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:isLoading?const Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        ): SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.screenContentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonHeader(headerName: 'Edit Events'),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
                buildEditableSection(
                  icon: Icons.event,
                  title: 'Edit Event',
                  fields: [
                    editableField('Event Name',1, _eventNameController),
                    editableField('Event Description',4, _eventDescriptionController,),
                    editableField('Date',1,  _dateController, isDate: true,),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                isLoading? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ):CommonButton(
                  onTap: () {
                    CommonDialog(
                      icon: Icons.save,
                      activeButtonSolidColor: Colors.green,
                      title: "Changes Done",
                      msg: "You are about to make changes. Please confirm.",
                      activeButtonLabel: "Confirm",
                      context: context,
                      activeButtonOnClicked: () {
                        Navigator.pop(context);
                        updateEventDetails();

                      },
                      activeButtonName: 'Confirm',
                    );
                  },
                  fontSize: 18,
                  borderRadius: 12,
                  height: 50,
                  width: ScreenUtils().screenWidth(context),
                  buttonColor: AppColors.white,
                  buttonName: 'Edit',
                  buttonTextColor: Colors.pinkAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditableSection({
    required IconData icon,
    required String title,
    required List<Widget> fields,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 28),
              SizedBox(width: ScreenUtils().screenHeight(context) * 0.01),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          const Divider(),
          ...fields,
        ],
      ),
    );
  }



  getEventDetails() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {
      "id": widget.eventId
    };
    Resource resource = await _eventsAdminUsecase.getEventDetails(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      _eventNameController.text = resource.data["event"];
      _eventDescriptionController.text = resource.data["description"];
      _dateController.text = resource.data["event_date"];
      postBy =resource.data["post_by"];
      activeStatus = resource.data["is_active"];

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


  updateEventDetails() async {
    setState(() {
      isLoading = true;
    });

    final
    Map<String, dynamic> requestData = {

        "id":widget.eventId,
        "event": _eventNameController.text.trim(),
        "description": _eventDescriptionController.text.trim(),
        "event_date": _dateController.text.trim(),
        "post_by": postBy,
        "is_active": activeStatus
    };
    Resource resource = await _eventsAdminUsecase.updateEventDetails(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {

      Navigator.pop(context);
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

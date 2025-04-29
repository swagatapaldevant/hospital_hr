import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/features/admin_module/events_admin/data/events_admin_usecase.dart';
import '../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class AddEventsAdmin extends StatefulWidget {
  const AddEventsAdmin({super.key});

  @override
  _AddEventsAdminState createState() => _AddEventsAdminState();
}

final _eventNameController = TextEditingController(text: '');
final _eventDescriptionController = TextEditingController(text: '');
final _dateController = TextEditingController(text: '');
bool isLoading  = false;
final EventsAdminUsecase _eventsAdminUsecase = getIt<EventsAdminUsecase>();
final SharedPref _pref = getIt<SharedPref>();

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class _AddEventsAdminState extends State<AddEventsAdmin> {
  Widget editableField(String label, TextEditingController controller, int? maxLines) {
    final isDateField = label.toLowerCase() == 'date';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: isDateField
            ? () async {
          FocusScope.of(context).requestFocus(FocusNode());
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            controller.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          }
        }
            : null,
        child: AbsorbPointer(
          absorbing: isDateField,
          child: TextFormField(
            controller: controller,
            maxLines:maxLines??1 ,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: isDateField ? Icon(Icons.calendar_today) : null,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.screenContentPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonHeader(headerName: 'Add Event'),
                SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
                buildEditableSection(
                  icon: Icons.event,
                  title: 'Add Event',
                  fields: [
                    editableField('Event Name',_eventNameController , 1),
                    editableField('Event Description',_eventDescriptionController , 4),
                    editableField('Date', _dateController, 1),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
               isLoading?const Center(
                 child: CircularProgressIndicator(
                   color: AppColors.white,
                 ),
               ): CommonButton(
                  onTap: () {
                    CommonDialog(
                      icon: Icons.save,
                      activeButtonSolidColor: Colors.green,
                      title: "Event Added",
                      msg: "You are about to add event. Please confirm.",
                      activeButtonLabel: "Confirm",
                      context: context,
                      activeButtonOnClicked: () {
                        Navigator.pop(context);
                        _eventDescriptionController.text.isNotEmpty && _eventNameController.text.isNotEmpty&& _dateController.text.isNotEmpty?
                        addEvent():
                        CommonUtils().flutterSnackBar(
                          context: context,
                          mes:"Please give event no, event name and date",
                          messageType: 4,
                        );
                      },
                      activeButtonName: 'Confirm',
                    );
                  },
                  fontSize: 18,
                  borderRadius: 12,
                  height: 50,
                  width: ScreenUtils().screenWidth(context),
                  buttonColor: AppColors.white,
                  buttonName: 'Add',
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
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 12),
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
              SizedBox(width: MediaQuery.of(context).size.width * 0.01),
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


  addEvent() async {
    setState(() {
      isLoading = true;
    });

    final userId = await _pref.getUserId();
    Map<String, dynamic> requestData = {
      "event": _eventNameController.text.trim(),
      "description": _eventDescriptionController.text.trim() ,
      "event_date": _dateController.text.trim(),
      "post_by": userId
    };
    Resource resource = await _eventsAdminUsecase.addEvent(requestData: requestData);

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

import 'package:flutter/material.dart';
import 'package:hospital_hr/core/network/apiHelper/locator.dart';
import 'package:hospital_hr/core/network/apiHelper/resource.dart';
import 'package:hospital_hr/core/network/apiHelper/status.dart';
import 'package:hospital_hr/core/services/localStorage/shared_pref.dart';
import 'package:hospital_hr/core/utils/constants/app_colors.dart';
import 'package:hospital_hr/core/utils/helper/common_utils.dart';
import 'package:hospital_hr/features/admin_module/notice_admin/data/notice_usecase.dart';
import '../../../../core/utils/commonWidgets/common_dialog.dart';
import '../../../../core/utils/commonWidgets/common_header.dart';
import '../../../../core/utils/commonWidgets/custom_button.dart';
import '../../../../core/utils/commonWidgets/custom_dropdown.dart';
import '../../../../core/utils/helper/app_dimensions.dart';
import '../../../../core/utils/helper/screen_utils.dart';

class EditNoticeAdmin extends StatefulWidget {
  final int noticeId;
  const EditNoticeAdmin({super.key, required this.noticeId});

  @override
  _EditNoticeAdminState createState() => _EditNoticeAdminState();
}

class _EditNoticeAdminState extends State<EditNoticeAdmin> {
  late final TextEditingController _enterNoticeController = TextEditingController();
  late final TextEditingController _enterDescriptionController =
      TextEditingController();
  final NoticeUsecase _noticeUseCase = getIt<NoticeUsecase>();
  bool isLoading = false;
  Map<String, int> priorityTypeMap = {"High": 1, "Medium": 2, "Low": 3};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String selectedPriorityLevel = "";
  final SharedPref _pref = getIt<SharedPref>();

  Widget editableField(
      String label, TextEditingController controller, int? maxLines) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.colorBlack.withOpacity(0.3)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNoticeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.screenContentPadding),
          child: isLoading?const Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ): Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonHeader(headerName: 'Edit Notice'),
              SizedBox(height: ScreenUtils().screenHeight(context) * 0.03),
              buildEditableSection(
                icon: Icons.edit,
                title: 'Edit Notice',
                fields: [
                  editableField('Enter Notice', _enterNoticeController, 1),
                  editableField(
                      'Enter Description', _enterDescriptionController, 4),
                ],
              ),
              CustomDropDownForTaskCreation(
                placeHolderText: selectedPriorityLevel.isEmpty ? "Choose priority level" : selectedPriorityLevel,
                onValueSelected: (String value, int id) {
                  selectedPriorityLevel = value;
                },
                data: priorityTypeMap,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              CommonButton(
                onTap: () {
                  CommonDialog(
                      icon: Icons.save,
                      activeButtonSolidColor: Colors.green,
                      title: "Notice Changed",
                      msg: "You are about to change notice. Please confirm.",
                      activeButtonLabel: "Confirm",
                      context: context,
                      activeButtonOnClicked: () {
                        Navigator.pop(context);
                        setState(() {

                         // isLoading = true;
                        });
                        updateNoticeApi();
                      },
                      activeButtonName: 'Confirm');
                },
                fontSize: 18,
                borderRadius: 12,
                height: 50,
                width: ScreenUtils().screenWidth(context),
                buttonColor: AppColors.white,
                buttonName: 'Change Notice',
                buttonTextColor: Colors.pinkAccent,
              ),
            ],
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

  getNoticeDetails() async {
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> requestData = {"id": widget.noticeId};

    Resource resource =
        await _noticeUseCase.getNoticeDetails(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      setState(() {
        _enterNoticeController.text = resource.data["notice"];
        _enterDescriptionController.text = resource.data["description"];
        selectedPriorityLevel = resource.data["priority_level"];
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


  updateNoticeApi() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> requestData = {
      "notice": _enterNoticeController.text.trim(),
      "description": _enterDescriptionController.text.trim(),
      "priority_level": selectedPriorityLevel,
      "id":widget.noticeId
    };

    Resource resource =
    await _noticeUseCase.updateNoticeDetails(requestData: requestData);

    if (resource.status == STATUS.SUCCESS) {
      setState(() {
        isLoading = false;
        Navigator.pop(context);
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


import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../helper/screen_utils.dart';

class CustomDropDownForTaskCreation extends StatefulWidget {
  final String placeHolderText;
  final Function(String, int) onValueSelected;
  final Map<String, int>? data;
  final bool isDisabled; // Added flag to disable dropdown

  const CustomDropDownForTaskCreation({
    super.key,
    required this.placeHolderText,
    required this.onValueSelected,
    this.data,
    this.isDisabled = false, // Default to false (enabled)
  });

  @override
  _CustomDropDownForTaskCreationState createState() => _CustomDropDownForTaskCreationState();
}

class _CustomDropDownForTaskCreationState extends State<CustomDropDownForTaskCreation> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtils().screenWidth(context) * 0.05),
      decoration: BoxDecoration(
        color: widget.isDisabled ? Colors.grey[300] : Color(0xFFF5F5FA), // Change color when disabled
        borderRadius: BorderRadius.circular(ScreenUtils().screenWidth(context) * 0.03),
        boxShadow: [
          if (!widget.isDisabled) // Remove shadow when disabled
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 0,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          hint: Text(
            widget.placeHolderText,
            style: TextStyle(
              color: widget.isDisabled ? Colors.grey : AppColors.colorPrimaryText, // Change text color when disabled
              fontSize:  14,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins",
            ),
          ),
          icon: Icon(Icons.keyboard_arrow_down, color: widget.isDisabled ? Colors.grey : AppColors.colorPrimaryText),
          isExpanded: true,
          onChanged: widget.isDisabled
              ? null // Disable selection when isDisabled is true
              : (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedValue = newValue;
              });
              int? selectedId = widget.data?[newValue];
              if (selectedId != null) {
                widget.onValueSelected(newValue, selectedId);
              }
            }
          },
          items: widget.data?.keys.map((String key) {
            return DropdownMenuItem<String>(
              value: key,
              child: Text(
                key,
                style: TextStyle(
                  color: widget.isDisabled ? Colors.grey : AppColors.colorBlack, // Gray text if disabled
                  fontSize:  ScreenUtils().screenWidth(context)*0.032,
                  fontFamily: "Poppins",
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
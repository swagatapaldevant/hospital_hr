import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final TextInputType? textInputType;
  final int? textLimit;
  final String? prefixText;
  final Widget? suffixButton;
  final Function(String)? onChanged;
  final bool? obscureText;
  final bool? readOnly;
  final String? errorText;
  final Function()? onClick;
  final String? Function(String?)? validation;

  const KTextField({
    Key? key,
    required this.title,
    this.controller,
    this.textInputType,
    this.textLimit,
    this.prefixText,
    this.suffixButton,
    this.onChanged,
    this.obscureText,
    this.readOnly,
    this.validation,
    this.errorText,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
      child: TextFormField(
        onTap: onClick ?? () {},
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        keyboardType: textInputType,
        controller: controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(textLimit),
        ],
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: "Poppins"),
        decoration: InputDecoration(
          border: outlineBorderStyle(),
          focusedBorder: focusBorderStyle(),
          enabledBorder: enableBorderStyle(),
          errorText: errorText,
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          filled: true,
          fillColor: Colors.grey.shade900,
          hintText: title,
          hintStyle: hintTextStyle(),
          labelText: title,
          labelStyle: const TextStyle(color: Colors.grey, fontFamily: "Poppins"),
          prefixText: prefixText,
          suffixIcon: suffixButton,
          suffixIconColor: Colors.grey,
        ),
        validator: validation ?? (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}

TextStyle hintTextStyle() {
  return const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w400,
      fontFamily: "Poppins"
  );
}

OutlineInputBorder outlineBorderStyle() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
  );
}

OutlineInputBorder focusBorderStyle() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(width: 1, color: Colors.white),
  );
}

OutlineInputBorder enableBorderStyle() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(width: 0.5, color: Colors.grey.shade700),
  );
}

class MessageTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final bool? validate;
  final Function(String)? onChanged;

  const MessageTextField({
    Key? key,
    required this.title,
    this.controller,
    this.validate,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
      child: TextFormField(
        maxLines: 3,
        keyboardType: TextInputType.text,
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white, fontFamily: "Poppins"),
        decoration: InputDecoration(
          border: outlineBorderStyle(),
          focusedBorder: focusBorderStyle(),
          enabledBorder: enableBorderStyle(),
          filled: true,
          fillColor: Colors.grey.shade900,
          labelText: title,
          labelStyle: const TextStyle(color: Colors.grey, fontFamily: "Poppins"),
          errorText: validate == true ? 'Fill the required field' : null,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}

class SmallTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Widget? suffixButton;
  final bool? readOnly;
  final Function()? onClick;

  const SmallTextField({
    super.key,
    required this.title,
    this.controller,
    this.suffixButton,
    this.readOnly,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        onTap: onClick ?? () {},
        readOnly: readOnly ?? false,
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          hintText: title,
          hintStyle: const TextStyle(color: Colors.grey, fontFamily: "Poppins"),
          suffixIcon: suffixButton,
        ),
      ),
    );
  }
}

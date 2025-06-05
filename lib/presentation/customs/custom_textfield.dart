import 'package:flutter/material.dart';
import 'package:time_reg/statics/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final double? height;
  final String? labelText;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextfield({super.key, this.height, this.labelText, this.controller, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: TextField(
        controller: controller,
        expands: !obscureText,
        maxLines: obscureText ? 1 : null,
        textAlignVertical: TextAlignVertical.top,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          alignLabelWithHint: true,
          labelStyle: TextStyle(fontSize: 14, color: AppColors.lightGray, fontFamily: "Montserrat"),
          contentPadding: EdgeInsets.only(left: 15, top: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide(color: AppColors.lightGray, width: 2)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide(color: AppColors.lightBackgroundGray, width: 2)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide(color: AppColors.lightBackgroundGray, width: 2)),
        ),
      ),
    );
  }
}

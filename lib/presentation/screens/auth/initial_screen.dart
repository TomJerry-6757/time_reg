import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_button.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hideAppBar: true,
      title: "title",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(text: "TimeReg", fontSize: 50, fontWeight: FontWeight.w700, color: AppColors.darkGray),
          CustomText(text: "Simple and Reliable Time Registration", fontWeight: FontWeight.w600, color: AppColors.darkGray),
          SizedBox(height: 10),
          CustomText(text: "Easily record clock-in and clock-out times to keep accurate work hour logs for your company.", fontWeight: FontWeight.w600, maxLines: 3, textAlign: TextAlign.center, color: AppColors.lightGray),
          SizedBox(height: 50),
          CustomButton(
            text: "Нэвтрэх",
            backgroundColor: AppColors.darkGray,
            textColor: AppColors.white,
            onTap: () {
              Navigator.pushNamed(context, '/homeScreen');
            },
          ),
          SizedBox(height: 10),
          CustomButton(
            text: "Бүртгүүлэх",
            borderEnabled: true,
            backgroundColor: AppColors.white,
            textColor: AppColors.darkGray,
            onTap: () {
              Navigator.pushNamed(context, '/signUpScreen');
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final bool? borderEnabled;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;

  const CustomButton({super.key, this.text, this.borderEnabled, this.backgroundColor, this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: backgroundColor ?? AppColors.darkGray, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: borderEnabled == true ? const BorderSide(color: AppColors.darkGray, width: 2) : BorderSide.none)),
        onPressed: onTap,
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), child: CustomText(text: text ?? "", color: textColor, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

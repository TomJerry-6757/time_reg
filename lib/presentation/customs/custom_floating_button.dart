import 'package:flutter/material.dart';
import 'package:time_reg/statics/app_colors.dart';

class CustomFloatingButton extends StatelessWidget {
  final Color? color;
  final VoidCallback? ontap;

  const CustomFloatingButton({super.key, this.color, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(right: 15.0), child: FloatingActionButton(backgroundColor: color, onPressed: ontap, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)), child: const Icon(Icons.add, color: AppColors.white)));
  }
}

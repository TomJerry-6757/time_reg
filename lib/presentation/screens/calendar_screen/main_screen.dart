import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_calendar.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(title: "Календар", body: SingleChildScrollView(child: Column(children: [CustomCalendar(), SizedBox(height: 20), _item()])));
  }

  _item() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: AppColors.lightBlue, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Column(children: [CustomText(text: "OCT", fontWeight: FontWeight.w500, color: AppColors.darkGray), CustomText(text: "08", fontSize: 25, fontWeight: FontWeight.w800, color: AppColors.darkGray)]),
          SizedBox(width: 20),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [CustomText(text: "08:00 am - 17:00 am", fontWeight: FontWeight.w600, color: AppColors.darkGray), CustomText(text: "Хоцролт: 00:00", fontSize: 13), CustomText(text: "Илүү цаг : 00:00", fontSize: 13)]),
        ],
      ),
    );
  }
}

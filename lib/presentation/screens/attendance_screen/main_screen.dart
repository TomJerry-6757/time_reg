import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_calendar.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<Map<String, String>> data = [
    {"date": "08", "month": "OCT", "time": "08:00 am - 17:00 pm", "late": "Хоцролт: 00:00", "overtime": "Илүү цаг : 00:00"},
    {"date": "08", "month": "OCT", "time": "08:00 am - 17:00 pm", "late": "Хоцролт: 00:00", "overtime": "Илүү цаг : 00:00"},
    {"date": "08", "month": "OCT", "time": "08:00 am - 17:00 pm", "late": "Хоцролт: 00:00", "overtime": "Илүү цаг : 00:00"},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Ирц",
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32), //
            CustomCalendar(), const SizedBox(height: 20), //
            ...data.map((item) => _item(item)), //
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _item(Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: AppColors.lightBackgroundGray, borderRadius: BorderRadius.circular(15), border: Border.all(width: 2, color: AppColors.lightGray)),
              child: Row(
                children: [
                  Column(children: [CustomText(text: item["month"]!, fontWeight: FontWeight.w500, color: AppColors.darkGray), CustomText(text: item["date"]!, fontSize: 25, fontWeight: FontWeight.w800, color: AppColors.darkGray)]),
                  SizedBox(width: 20),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [CustomText(text: item["time"]!, fontWeight: FontWeight.w600, color: AppColors.darkGray), CustomText(text: item["late"]!, fontSize: 13), CustomText(text: item["overtime"]!, fontSize: 13)]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

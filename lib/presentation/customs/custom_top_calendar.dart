import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class CalendarWidget extends StatefulWidget {
  final bool onTap;
  final void Function(DateTime)? onDateSelected;

  const CalendarWidget({super.key, this.onDateSelected, this.onTap = true});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime today = DateTime.now();
  late DateTime monday;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    monday = today.subtract(Duration(days: today.weekday - 1));
  }

  String weekdayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> dayWidgets = List.generate(7, (index) {
      DateTime date = monday.add(Duration(days: index));
      bool isToday = date.day == today.day && date.month == today.month && date.year == today.year;
      bool isSelected = selectedDate != null && date.day == selectedDate!.day && date.month == selectedDate!.month && date.year == selectedDate!.year;

      return GestureDetector(
        onTap: () {
          widget.onTap
              ? setState(() {
                selectedDate = date;
              })
              : null;
          if (widget.onDateSelected != null) {
            widget.onDateSelected!(date);
          }
        },
        child: Container(
          height: 60,
          width: 50,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: isToday || isSelected ? AppColors.darkGray : const Color.fromARGB(255, 230, 230, 230), width: 2), borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomText(text: date.day.toString(), color: isToday || isSelected ? AppColors.darkGray : const Color.fromARGB(255, 230, 230, 230), fontWeight: FontWeight.w600, fontSize: 14),
                CustomText(text: weekdayName(date.weekday), color: isToday || isSelected ? AppColors.darkGray : const Color.fromARGB(255, 230, 230, 230), fontWeight: FontWeight.w600, fontSize: 13),
              ],
            ),
          ),
        ),
      );
    });

    return SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: dayWidgets));
  }
}

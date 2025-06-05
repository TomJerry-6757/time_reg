import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_reg/statics/app_colors.dart';

class CustomCalendar extends StatefulWidget {
  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime?> _selectedDay = ValueNotifier(null);

  @override
  void dispose() {
    _focusedDay.dispose();
    _selectedDay.dispose();
    super.dispose();
  }

  List<Widget> _buildDaysOfWeek() {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days.map((d) => Center(child: Text(d, style: TextStyle(fontWeight: FontWeight.bold)))).toList();
  }

  List<Widget> _buildDateGrid(DateTime focusedDay, DateTime? selectedDay) {
    final firstDayOfMonth = DateTime(focusedDay.year, focusedDay.month, 1);
    final daysInMonth = DateTime(focusedDay.year, focusedDay.month + 1, 0).day;
    final startingWeekday = firstDayOfMonth.weekday % 7;

    final today = DateTime.now();
    final isSameDate = (DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

    List<Widget> dayWidgets = [];

    for (int i = 0; i < startingWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final currentDate = DateTime(focusedDay.year, focusedDay.month, day);
      final isSelected = selectedDay != null && isSameDate(selectedDay, currentDate);
      final isToday = isSameDate(today, currentDate);

      Color bgColor;
      Color textColor;

      if (isSelected) {
        bgColor = AppColors.darkGray;
        textColor = Colors.white;
      } else if (isToday) {
        bgColor = AppColors.darkGray;
        textColor = AppColors.purple;
      } else {
        bgColor = Colors.transparent;
        textColor = Colors.black87;
      }

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            _selectedDay.value = currentDate;
          },
          child: Container(margin: const EdgeInsets.all(4), decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle), alignment: Alignment.center, child: Text('$day', style: TextStyle(color: textColor, fontWeight: FontWeight.w500))),
        ),
      );
    }

    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DateTime>(
      valueListenable: _focusedDay,
      builder: (context, focusedDay, _) {
        return ValueListenableBuilder<DateTime?>(
          valueListenable: _selectedDay,
          builder: (context, selectedDay, _) {
            final monthLabel = DateFormat.yMMMM().format(focusedDay);

            return Container(
              decoration: BoxDecoration(color: AppColors.lightBackgroundGray, borderRadius: BorderRadius.circular(15), border: Border.all(width: 1, color: AppColors.lightGray)),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, right: 30, left: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(monthLabel, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.chevron_left),
                              onPressed: () {
                                _focusedDay.value = DateTime(focusedDay.year, focusedDay.month - 1);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.chevron_right),
                              onPressed: () {
                                _focusedDay.value = DateTime(focusedDay.year, focusedDay.month + 1);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    GridView.count(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), crossAxisCount: 7, children: _buildDaysOfWeek()),
                    GridView.count(shrinkWrap: true, physics: NeverScrollableScrollPhysics(), crossAxisCount: 7, children: _buildDateGrid(focusedDay, selectedDay)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

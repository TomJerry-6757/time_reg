import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_button.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/presentation/customs/custom_textfield.dart';
import 'package:time_reg/statics/app_colors.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  State<CreateRequestScreen> createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final ValueNotifier<String> selectedProject = ValueNotifier('Хүсэлтийн төрөл');
  final List<String> projects = ['Амралт', 'Чөлөө', 'Remote'];

  final GlobalKey _menuKey = GlobalKey();

  final ValueNotifier<DateTime> startDateNotifier = ValueNotifier(DateTime.now());
  final ValueNotifier<DateTime> endDateNotifier = ValueNotifier(DateTime.now());

  final ValueNotifier<TimeOfDay> startTimeNotifier = ValueNotifier(TimeOfDay.now());
  final ValueNotifier<TimeOfDay> endTimeNotifier = ValueNotifier(TimeOfDay.now());

  Future<void> _selectDate(BuildContext context, ValueNotifier<DateTime> notifier) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: notifier.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            scaffoldBackgroundColor: Colors.white, //
            colorScheme: ColorScheme.light(
              primary: Colors.blue, //
              onPrimary: Colors.white, //
              onSurface: Colors.black, //
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      notifier.value = picked;
    }
  }

  Future<void> _selectTime(BuildContext context, ValueNotifier<TimeOfDay> notifier) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: notifier.value,
      builder: (context, child) {
        return Theme(data: Theme.of(context).copyWith(timePickerTheme: const TimePickerThemeData(backgroundColor: Colors.white, hourMinuteColor: Colors.blue), colorScheme: ColorScheme.light(primary: Colors.blue, onPrimary: Colors.white, onSurface: Colors.black)), child: child!);
      },
    );
    if (picked != null) {
      notifier.value = picked;
    }
  }

  void _showCustomDropdown(BuildContext context) {
    final RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double containerWidth = renderBox.size.width;

    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height + 8, //
        offset.dx + containerWidth,
        offset.dy,
      ),
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      items:
          projects.map((String value) {
            return PopupMenuItem<String>(
              value: value,
              padding: EdgeInsets.zero, //
              child: Container(
                width: containerWidth, //
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(value),
              ),
            );
          }).toList(),
    ).then((String? value) {
      if (value != null) {
        selectedProject.value = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Хүсэлт",
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              key: _menuKey,
              onTap: () => _showCustomDropdown(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.lightBackgroundGray, width: 2), borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ValueListenableBuilder<String>(
                      valueListenable: selectedProject,
                      builder: (context, value, _) {
                        return CustomText(text: value, fontSize: 14, fontWeight: FontWeight.w500, color: value == 'Хүсэлтийн төрөл' ? AppColors.darkGray : Colors.black);
                      },
                    ),
                    const Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _selectDate(context, startDateNotifier),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 2, color: AppColors.lightBackgroundGray), borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                      child: ValueListenableBuilder<DateTime>(valueListenable: startDateNotifier, builder: (_, date, __) => CustomText(text: "${date.year}, ${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}", fontSize: 14)),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () => _selectDate(context, endDateNotifier),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 2, color: AppColors.lightBackgroundGray), borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                      child: ValueListenableBuilder<DateTime>(valueListenable: endDateNotifier, builder: (_, date, __) => CustomText(text: "${date.year}, ${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}", fontSize: 14)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => _selectTime(context, startTimeNotifier),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 2, color: AppColors.lightBackgroundGray), borderRadius: BorderRadius.circular(12)),
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15), child: ValueListenableBuilder<TimeOfDay>(valueListenable: startTimeNotifier, builder: (_, time, __) => CustomText(text: time.format(context), fontSize: 14))),
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectTime(context, endTimeNotifier),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width: 2, color: AppColors.lightBackgroundGray), borderRadius: BorderRadius.circular(12)),
                    child: Padding(padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15), child: ValueListenableBuilder<TimeOfDay>(valueListenable: endTimeNotifier, builder: (_, time, __) => CustomText(text: time.format(context), fontSize: 14))),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            CustomTextfield(height: 150, labelText: "Тайлбар"),
            const SizedBox(height: 10),
            CustomButton(text: "Илгээх"),
          ],
        ),
      ),
    );
  }
}

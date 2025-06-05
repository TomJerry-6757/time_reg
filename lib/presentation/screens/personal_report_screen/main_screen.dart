import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_button.dart';
import 'package:time_reg/presentation/customs/custom_floating_button.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/presentation/customs/custom_top_calendar.dart';
import 'package:time_reg/statics/app_colors.dart';

class PersonalReportScreen extends StatefulWidget {
  const PersonalReportScreen({super.key});

  @override
  State<PersonalReportScreen> createState() => _PersonalReportScreenState();
}

class _PersonalReportScreenState extends State<PersonalReportScreen> {
  int? selectedIndex;
  final List<bool> _animatedFlags = [];

  final List<Map<String, String>> notes = [
    {"title": "Zeely", "content": "AppStore, Play Store publish, Page Fix2, Page Fix2, Page Fix2, Page Fix2, Page Fix2", "subtitle2": "Loan repay fixed", "date": "May 2, 12:20 pm"},
    {"title": "Zeely", "content": "UI Fixes, Page Fix2, Page Fix2, Page Fix2, Page Fix2, Page Fix2", "date": "May 2, 12:20 pm"},
    {"title": "Zeely", "content": "UI Fixes, Page Fix2, Page Fix2, Page Fix2, Page Fix2, Page Fix2, Page Fix2,Page Fix2 Page Fix2,Page Fix2,Page Fix2, Page Fix2, Page Fix2, Page Fix2, Page Fix2, Page Fix2", "date": "May 2, 12:20 pm"},
  ];

  @override
  void initState() {
    super.initState();
    _animatedFlags.addAll(List.generate(notes.length, (_) => false));
    _runStaggeredAnimation();
  }

  void _runStaggeredAnimation() {
    for (int i = 0; i < notes.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          setState(() {
            _animatedFlags[i] = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Тайлан",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Column(
            children: [
              CalendarWidget(
                onDateSelected: (date) {
                  print('Selected date: $date');
                },
              ),
              const SizedBox(height: 32),
              ...List.generate(notes.length, (index) {
                final note = notes[index];
                final isSelected = selectedIndex == index;
                final isVisible = _animatedFlags.length > index && _animatedFlags[index];

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: isVisible ? 1.0 : 0.0,
                  curve: Curves.easeOut,
                  child: Transform.translate(
                    offset: isVisible ? const Offset(0, 0) : const Offset(0, 20),
                    child: Column(
                      children: [
                        _note(index: index, title: note['title']!, content: note['content']!, isSelected: isSelected, date: note['date']!),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) => SizeTransition(sizeFactor: animation, axisAlignment: -1, child: child),
                          child:
                              isSelected
                                  ? Padding(
                                    key: ValueKey(index),
                                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            text: "Засах",
                                            onTap: () {
                                              Navigator.pushNamed(context, '/writeReportScreen');
                                            },
                                            backgroundEnabled: true,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(child: CustomButton(text: "Илгээх", onTap: () {}, backgroundEnabled: true)),
                                      ],
                                    ),
                                  )
                                  : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingButton(
        color: AppColors.darkGray,
        ontap: () {
          Navigator.pushNamed(context, '/writeReportScreen');
        },
      ),
    );
  }

  Widget _note({required int index, required String title, required String content, required bool isSelected, required String date}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = selectedIndex == index ? null : index;
            });
          },
          child: Container(
            decoration: BoxDecoration(color: AppColors.lightBackgroundGray, borderRadius: BorderRadius.circular(15), border: Border.all(width: 2, color: AppColors.lightGray)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [CustomText(text: title, fontWeight: FontWeight.w600, color: AppColors.darkGray), CustomText(text: content, fontSize: 14, color: AppColors.darkGray, maxLines: 5)])),
                  Container(height: 23, width: 23, decoration: BoxDecoration(color: isSelected ? AppColors.darkGray : Colors.white, shape: BoxShape.circle), child: isSelected ? const Center(child: Icon(Icons.check, size: 16, color: Colors.white)) : null),
                ],
              ),
            ),
          ),
        ),
        Padding(padding: const EdgeInsets.only(bottom: 10.0, top: 5), child: CustomText(text: date, fontSize: 12, color: AppColors.darkGray)),
      ],
    );
  }
}

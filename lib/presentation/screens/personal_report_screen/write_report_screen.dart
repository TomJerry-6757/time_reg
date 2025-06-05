import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_button.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/presentation/customs/custom_textfield.dart';
import 'package:time_reg/statics/app_colors.dart';

class WriteReportScreen extends StatefulWidget {
  const WriteReportScreen({super.key});

  @override
  State<WriteReportScreen> createState() => _WriteReportScreenState();
}

class _WriteReportScreenState extends State<WriteReportScreen> {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<String> selectedProject = ValueNotifier('Төслийн Нэр');
    final List<String> projects = ['Zeely', 'Mind', 'Time'];
    final GlobalKey _menuKey = GlobalKey();

    void _showCustomDropdown(BuildContext context) {
      final RenderBox renderBox = _menuKey.currentContext!.findRenderObject() as RenderBox;
      final Offset offset = renderBox.localToGlobal(Offset.zero);
      final double containerWidth = renderBox.size.width;

      showMenu<String>(
        context: context,
        position: RelativeRect.fromLTRB(offset.dx, offset.dy + renderBox.size.height + 8, offset.dx + containerWidth, offset.dy),
        color: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        items:
            projects.map((String value) {
              return PopupMenuItem<String>(value: value, padding: EdgeInsets.zero, child: Container(width: containerWidth, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Text(value)));
            }).toList(),
      ).then((String? value) {
        if (value != null) {
          selectedProject.value = value;
        }
      });
    }

    return CustomScaffold(
      title: "Тайлан",
      body: Column(
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
                      return CustomText(text: value, fontSize: 14, fontWeight: FontWeight.w500, color: value == 'Төслийн нэр' ? AppColors.darkGray : Colors.black);
                    },
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomTextfield(height: 150, labelText: "Тайлан"),
          const SizedBox(height: 10),
          CustomButton(text: "Хадгалах"),
        ],
      ),
    );
  }
}

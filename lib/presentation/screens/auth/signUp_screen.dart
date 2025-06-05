import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_button.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/presentation/customs/custom_textfield.dart';
import 'package:time_reg/statics/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey _menuKey = GlobalKey();
  final ValueNotifier<String> selectedProject = ValueNotifier('Албан тушаал');
  final List<String> projects = ['boss1', 'boss2', 'boss3'];

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
      title: "Бүртгэл",
      showNotifIcon: false,
      body: Column(
        children: [
          CustomTextfield(labelText: "Нэр"), //
          SizedBox(height: 10), //
          CustomTextfield(labelText: "Утасны дугаар"),
          SizedBox(height: 10), //
          CustomTextfield(labelText: "Нууц үг"),
          SizedBox(height: 10), //
          CustomTextfield(labelText: "Нууц үг давтах"),
          SizedBox(height: 10), //
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
                      return CustomText(text: value, fontSize: 14, fontWeight: FontWeight.w500, color: value == 'Албан тушаал' ? AppColors.darkGray : Colors.black);
                    },
                  ),
                  const Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          CustomButton(text: "Sign In"),
        ],
      ),
    );
  }
}

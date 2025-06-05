import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class ToggleButton extends StatefulWidget {
  final Function(bool isArrived)? onToggle;
  final bool enabled;

  const ToggleButton({super.key, this.onToggle, this.enabled = true});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

const double height = 50.0;
const double leftAlign = -1;
const double rightAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _ToggleButtonState extends State<ToggleButton> {
  double xAlign = leftAlign;
  Color leftColor = selectedColor;
  Color rightColor = AppColors.darkGray;

  double dragPosition = 0.0;

  void updateToggle(bool isArrived) {
    setState(() {
      if (isArrived) {
        xAlign = leftAlign;
        leftColor = selectedColor;
        rightColor = AppColors.darkGray;
        dragPosition = leftAlign * (MediaQuery.of(context).size.width / 2);
      } else {
        xAlign = rightAlign;
        rightColor = selectedColor;
        leftColor = AppColors.darkGray;
        dragPosition = rightAlign * (MediaQuery.of(context).size.width / 2);
      }
      widget.onToggle?.call(isArrived);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.45;

    return Container(
      width: screenWidth,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0), border: Border.all(width: 2, color: AppColors.darkGray)),
      child: Stack(
        children: [
          AnimatedAlign(alignment: Alignment(xAlign, 0), duration: const Duration(milliseconds: 200), curve: Curves.easeOut, child: Container(width: buttonWidth, height: height, decoration: BoxDecoration(color: AppColors.darkGray, borderRadius: BorderRadius.circular(50.0)))),

          GestureDetector(
            onPanUpdate:
                widget.enabled
                    ? (details) {
                      setState(() {
                        dragPosition += details.delta.dx;
                        double newAlign = (dragPosition / (screenWidth / 2)).clamp(-1.0, 1.0);
                        xAlign = newAlign;
                      });
                    }
                    : null,
            onPanEnd:
                widget.enabled
                    ? (details) {
                      setState(() {
                        if (xAlign < 0) {
                          updateToggle(true);
                        } else {
                          updateToggle(false);
                        }
                      });
                    }
                    : null,

            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: widget.enabled ? () => updateToggle(true) : null,
                    child: Container(alignment: Alignment.center, height: height, color: Colors.transparent, child: CustomText(text: 'Ирсэн', color: leftColor, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: widget.enabled ? () => updateToggle(false) : null,
                    child: Container(alignment: Alignment.center, height: height, color: Colors.transparent, child: CustomText(text: 'Явсан', color: rightColor, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

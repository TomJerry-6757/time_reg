import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign textAlign;

  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({super.key, required this.text, this.fontSize, this.fontWeight, this.color, this.textAlign = TextAlign.start, this.maxLines, this.overflow});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: fontSize ?? 16, fontWeight: fontWeight ?? FontWeight.normal, color: color, fontFamily: "Montserrat"), textAlign: textAlign, maxLines: maxLines, overflow: overflow ?? TextOverflow.ellipsis);
  }
}

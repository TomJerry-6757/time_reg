import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class RequestDetailScreen extends StatefulWidget {
  const RequestDetailScreen({super.key});

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Ирсэн хүсэлт",
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppColors.lightBackgroundGray, borderRadius: BorderRadius.circular(15), border: Border.all(width: 2, color: AppColors.lightGray)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Нэр :", fontWeight: FontWeight.w600),
                CustomText(text: "Батаа"),
                SizedBox(height: 10),
                CustomText(text: "Албан тушаал :", fontWeight: FontWeight.w600),
                CustomText(text: "Хөгжүүлэгч"),
                SizedBox(height: 10),
                CustomText(text: "Тайлбар :", fontWeight: FontWeight.w600),
                CustomText(text: "Эмнэлэг орно Эмнэлэг Эмнэлэг орно  Эмнэлэг орно  Эмнэлэг Эмнэлэг орно  Эмнэлэг орно  Эмнэлэг орно.", maxLines: 5),
                SizedBox(height: 10),
                CustomText(text: "Хугацаа :", fontWeight: FontWeight.w600),
                CustomText(text: "12:30 - 13:00 May 21"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

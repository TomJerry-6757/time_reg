import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(title: "Мэдэгдлүүд", showNotifIcon: false, body: SingleChildScrollView(child: Column(children: [_item(), _item(), _item()])));
  }

  _item() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: AppColors.lightBackgroundGray, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(width: 50, height: 50, decoration: BoxDecoration(color: AppColors.lightGray, borderRadius: BorderRadius.circular(10))),
          SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [CustomText(text: "Танд хүсэлт ирлээ", fontWeight: FontWeight.w600, color: AppColors.darkGray), CustomText(text: "Чөлөө", fontSize: 13)]),
        ],
      ),
    );
  }
}

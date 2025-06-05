import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/statics/app_colors.dart';

class CustomScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final bool hideAppBar;
  final bool isHomeScreen;
  final Color backgroundColor;
  final bool homeAppbar;
  final Widget? floatingActionButton;
  final bool? showNotifIcon;

  const CustomScaffold({super.key, required this.title, required this.body, this.hideAppBar = false, this.isHomeScreen = false, this.backgroundColor = Colors.white, this.homeAppbar = false, this.floatingActionButton, this.showNotifIcon});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar:
          widget.hideAppBar
              ? null
              : AppBar(
                backgroundColor: Colors.white,
                title: CustomText(text: widget.title, fontWeight: FontWeight.w600),
                leading: widget.homeAppbar ? const Circle() : Padding(padding: const EdgeInsets.only(left: 30.0), child: IconButton(icon: const Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop())),
                actions:
                    widget.showNotifIcon ?? true
                        ? [
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: IconButton(
                              iconSize: 28,
                              icon: const Icon(Icons.notifications_none),
                              onPressed: () {
                                Navigator.pushNamed(context, "/notificationScreen");
                              },
                            ),
                          ),
                        ]
                        : [],
              ),

      body: Padding(padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 32), child: widget.body),
      floatingActionButton: widget.floatingActionButton,
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/menuScreen');
      },
      child: const Padding(padding: EdgeInsets.only(left: 30.0), child: CircleAvatar(radius: 16, backgroundColor: AppColors.primary)),
    );
  }
}

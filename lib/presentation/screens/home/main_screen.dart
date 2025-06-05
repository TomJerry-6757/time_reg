import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_reg/assets/assets.dart';
import 'package:time_reg/presentation/customs/custom_blurred_loader.dart';
import 'package:time_reg/presentation/customs/custom_draggable_button.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/presentation/customs/custom_top_calendar.dart';
import 'package:time_reg/service/work_area_service.dart';
import 'package:time_reg/statics/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WorkAreaService _workAreaService = WorkAreaService();
  String officeLong = '107';
  String officeLat = '48';
  String officeWifiName = 'Tanasoft';
  String officeWifiBSSID = 'bc:7:1d:e0:c4:29';
  String userCurrentLong = '';
  String userCurrentLat = '';
  String userWifiName = '';
  String userWifiBSSID = '';
  bool _isFetchingInfo = false;
  bool _isInWorkArea = false;

  Future<void> _fetchWorkAreaInfo() async {
    setState(() {
      _isFetchingInfo = true;
    });

    final WorkAreaInfo info = await _workAreaService.getWorkAreaDetails();
    setState(() {
      _isFetchingInfo = false;
      if (info.isSuccessful) {
        userWifiBSSID = info.wifiBSSID ?? '';
        userWifiName = info.wifiName ?? '';
        userCurrentLat = info.position?.latitude.toStringAsFixed(0) ?? '';
        userCurrentLong = info.position?.longitude.toStringAsFixed(0) ?? '';
        print("userwifibssid--- ${userWifiBSSID}");
        print("userwifiname--- ${userWifiName}");
        print("userlat--- ${userCurrentLat}");
        print("userlong--- ${userCurrentLong}");

        _isInWorkArea = userWifiBSSID.toLowerCase().trim() == officeWifiBSSID.toLowerCase().trim() && userWifiName.toLowerCase().trim() == officeWifiName.toLowerCase().trim();
      } else {
        _isInWorkArea = false;

        if (info.statusMessage.contains('permanently denied')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Location permissions permanently denied. Please enable in settings.'),
              action: SnackBarAction(
                label: 'Open Settings',
                onPressed: () {
                  _workAreaService.openAppSettingsForPermissions();
                },
              ),
              duration: const Duration(seconds: 5),
            ),
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchWorkAreaInfo();

    print("------------------------");
    print("${officeLong}-----------");
    print("${officeLat}-----------");
    print("${officeWifiBSSID}-----------");
    print("${officeWifiName}-----------");
    print("_isInWorkArea --------  ${_isInWorkArea}");
  }

  @override
  Widget build(BuildContext context) {
    return BlurredLoader(
      isLoading: _isFetchingInfo,
      child: CustomScaffold(
        title: "Hi, User",
        homeAppbar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 84, decoration: BoxDecoration(color: AppColors.lightBackgroundGray, borderRadius: BorderRadius.circular(20)), alignment: Alignment.center, child: CustomText(text: "Today's Daily - 12:00 pm", fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.darkGray)),
              const SizedBox(height: 15),

              CalendarWidget(
                onTap: false,
                onDateSelected: (date) {
                  // print('Selected date: $date');
                },
              ),
              const SizedBox(height: 35),
              ToggleButton(
                onToggle: (isArrived) {
                  print("userwifibssid--- ${userWifiBSSID}");
                  print("userwifiname--- ${userWifiName}");
                  print("userlat--- ${userCurrentLat}");
                  print("userlong--- ${userCurrentLong}");
                  print("------------------------");
                  print("${officeLong}-----------");
                  print("${officeLat}-----------");
                  print("${officeWifiBSSID}-----------");
                  print("${officeWifiName}-----------");
                  print("_isInWorkArea --------  ${_isInWorkArea}");
                },
                enabled: _isInWorkArea,
              ),

              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _mainWidget(
                    context: context,
                    title: 'Ирц',
                    mainColor: AppColors.purple,
                    ontap: () {
                      Navigator.pushNamed(context, '/attendanceScreen');
                    },
                    icon: Assets.attendanceIcon,
                  ),
                  _mainWidget(
                    context: context,
                    title: 'Тайлан',
                    mainColor: AppColors.pink,
                    ontap: () {
                      Navigator.pushNamed(context, '/personalReportScreen');
                    },
                    icon: Assets.reportIcon,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _mainWidget(
                    context: context,
                    title: 'Хүсэлт',
                    mainColor: AppColors.lightGreen,
                    ontap: () {
                      Navigator.pushNamed(context, '/requestScreen');
                    },
                    icon: Assets.requestIcon,
                  ),
                  _mainWidget(
                    context: context,
                    title: '',
                    mainColor: AppColors.lightBlue,
                    ontap: () {
                      // _fetchWorkAreaInfo();
                    },
                    icon: Assets.calendarIcon,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _mainWidget({required BuildContext context, String title = '', Color? mainColor, GestureTapCallback? ontap, String? icon}) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = 30.0;
    final double spacing = 15.0;
    final double tileWidth = (screenWidth - horizontalPadding * 2 - spacing) / 2;

    return SizedBox(
      width: tileWidth,
      height: tileWidth,
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(color: mainColor ?? Colors.amberAccent, borderRadius: BorderRadius.circular(15)),
          child: Stack(children: [Positioned(top: 15, left: 15, child: CustomText(text: title, fontWeight: FontWeight.w700, color: AppColors.darkGray)), Positioned(bottom: 15, right: 15, child: SvgPicture.asset(icon ?? '', width: 24, height: 24))]),
        ),
      ),
    );
  }
}

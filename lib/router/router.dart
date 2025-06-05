import 'package:flutter/material.dart';
import 'package:time_reg/presentation/screens/attendance_screen/main_screen.dart';
import 'package:time_reg/presentation/screens/auth/signIn_screen.dart';
import 'package:time_reg/presentation/screens/home/main_screen.dart';
import 'package:time_reg/presentation/screens/menu_screen/main_screen.dart';
import 'package:time_reg/presentation/screens/personal_report_screen/main_screen.dart';
import 'package:time_reg/presentation/screens/personal_report_screen/write_report_screen.dart';
import 'package:time_reg/presentation/screens/request_screen/create_request_screen.dart';
import 'package:time_reg/presentation/screens/request_screen/main_screen.dart';

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/homeScreen':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/menuScreen':
        return MaterialPageRoute(builder: (_) => const MenuScreen());
      case '/requestScreen':
        return MaterialPageRoute(builder: (_) => const RequestScreen());
      case '/personalReportScreen':
        return MaterialPageRoute(builder: (_) => const PersonalReportScreen());
      case '/writeReportScreen':
        return MaterialPageRoute(builder: (_) => const WriteReportScreen());
      case '/attendanceScreen':
        return MaterialPageRoute(builder: (_) => const AttendanceScreen());
      case '/createRequestScreen':
        return MaterialPageRoute(builder: (_) => const CreateRequestScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
    }
  }
}

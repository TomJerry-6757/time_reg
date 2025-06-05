import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_reg/bloc/auth/auth_cubit.dart';
import 'package:time_reg/firebase_options.dart';
import 'package:time_reg/presentation/screens/auth/signIn_screen.dart';
import 'package:time_reg/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(BlocProvider(create: (_) => AuthCubit(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Time Reg', debugShowCheckedModeBanner: false, onGenerateRoute: _appRouter.onGenerateRoute, theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), home: SignInScreen());
  }
}

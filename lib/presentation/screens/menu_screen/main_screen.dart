import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/presentation/screens/auth/signIn_screen.dart';
import 'package:time_reg/statics/app_colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignInScreen()), (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Гарах үед алдаа гарлаа: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 20.0), child: CustomText(text: "Menu", fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/requestScreen');
            },
            child: const CustomText(text: "Илгээсэн Хүсэлтүүд", fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          const CustomText(text: "Ирцийн мэдээлэл", fontWeight: FontWeight.w500),
          const SizedBox(height: 50),
          GestureDetector(onTap: _signOut, child: const CustomText(text: "Гарах", fontWeight: FontWeight.w500, color: AppColors.red)),
        ],
      ),
    );
  }
}

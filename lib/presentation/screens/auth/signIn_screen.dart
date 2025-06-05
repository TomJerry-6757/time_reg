import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_reg/bloc/auth/auth_cubit.dart';
import 'package:time_reg/presentation/customs/custom_blurred_loader.dart';
import 'package:time_reg/presentation/customs/custom_button.dart';
import 'package:time_reg/presentation/customs/custom_scaffold.dart';
import 'package:time_reg/presentation/customs/custom_text.dart';
import 'package:time_reg/presentation/customs/custom_textfield.dart';
import 'package:time_reg/statics/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/homeScreen');
        }
      },
      builder: (context, state) {
        return BlurredLoader(
          isLoading: state is AuthLoading,
          child: CustomScaffold(
            title: '',
            hideAppBar: true,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: 'TimeReg', fontSize: 50, fontWeight: FontWeight.w600, color: AppColors.darkGray),
                    const SizedBox(height: 30),
                    CustomTextfield(labelText: "И-Мэйл", controller: _emailController),
                    const SizedBox(height: 20),
                    CustomTextfield(labelText: "Нууц үг", controller: _passwordController, obscureText: true),
                    const SizedBox(height: 10),
                    if (state is AuthFailure) Text(state.message, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "Нэвтрэх",
                      backgroundColor: AppColors.darkGray,
                      textColor: AppColors.white,
                      onTap: () {
                        context.read<AuthCubit>().signIn(_emailController.text, _passwordController.text);
                      },
                    ),
                    const SizedBox(height: 20),
                    const CustomText(text: "Нууц үг мартсан?", fontSize: 14),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Бүртгүүлэх",
                      borderEnabled: true,
                      backgroundColor: AppColors.white,
                      textColor: AppColors.darkGray,
                      onTap: () {
                        Navigator.of(context).pushNamed('/signUpScreen');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

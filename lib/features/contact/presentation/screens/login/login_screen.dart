import 'package:contact_app_sqflite/config/theme/color/light_color.dart';
import 'package:contact_app_sqflite/config/theme/images/app_imiage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/local/shared_pref.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_navigation.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_toast.dart';
import '../home/home.dart';
import '../register/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(SharedPreferencesHelper()),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: LightColor.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppImage.loginImage),
                      ),
                    ),
                    width: 188,
                    height: 174,
                  ),
                  Column(
                    children: [
                      CustomTextField(
                        controller: textController1,
                        hintText: 'Username',
                        isPassword: false,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: textController2,
                        hintText: 'Password',
                        isPassword: true,
                      ),
                    ],
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginFailure) {
                        CustomToast.show(
                          state.message,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      } else if (state is LoginSuccess) {
                        CustomToast.show(
                          "Login Success",
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                        CustomNavigation.pushAndRemoveUntil(
                          context,
                          const HomeScreen(),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomButton(
                            onPressed: () {
                              context.read<LoginBloc>().add(LoginUser(
                                  textController1.text, textController2.text));
                            },
                            text: 'Log In',
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              CustomNavigation.push(
                                context,
                                const RegisterScreen(),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Don’t have an account yet? ',
                                  style: TextStyle(
                                    fontFamily: 'PaynetB',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    height: 1.6,
                                    letterSpacing: -0.4,
                                    color: Color(0xFF8E8E93),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Sign up here',
                                      style: TextStyle(
                                        fontFamily: 'PaynetB',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        height: 1.3,
                                        color: Color(0xFF8E8E93),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

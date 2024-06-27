import 'package:contact_app_sqflite/config/theme/color/light_color.dart';
import 'package:contact_app_sqflite/config/theme/images/app_imiage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../data/local/shared_pref.dart';
import '../../bloc/register/register_bloc.dart';
import '../../bloc/register/register_event.dart';
import '../../bloc/register/register_state.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../home/home.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final textController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(SharedPreferencesHelper()),
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
                    height: 176,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          AppImage.registerImage,
                        ),
                      ),
                    ),
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
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: textController3,
                        hintText: 'Confirm Password',
                        isPassword: true,
                      ),
                    ],
                  ),
                  BlocConsumer<RegisterBloc, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterFailure) {
                        Fluttertoast.showToast(
                            msg: state.message,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (state is RegisterSuccess) {
                        Fluttertoast.showToast(
                            msg: "Success",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                              (Route<dynamic> route) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          if (state is RegisterLoading)
                            const CircularProgressIndicator(),
                          CustomButton(
                            onPressed: () {
                              context.read<RegisterBloc>().add(RegisterUser(
                                  textController1.text,
                                  textController2.text,
                                  textController3.text));
                            },
                            text: 'Register',
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                      text: 'Log in',
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

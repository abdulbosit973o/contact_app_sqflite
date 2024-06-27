import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/local/shared_pref.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../../bloc/splash/splash_event.dart';
import '../../bloc/splash/splash_state.dart';
import '../home/home.dart';
import '../login/login_screen.dart';
import 'package:contact_app_sqflite/config/theme/color/light_color.dart';
import 'package:contact_app_sqflite/config/theme/images/app_imiage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenBloc(SharedPreferencesHelper())
        ..add(CheckVerificationStatus()),
      child: Scaffold(
        backgroundColor: LightColor.white,
        body: BlocListener<SplashScreenBloc, SplashScreenState>(
          listener: (context, state) {
            if (state is SplashAuthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (state is SplashUnauthenticated) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
          child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      AppImage.splashImage,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:peanut_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:peanut_app/features/home/presentation/screens/landing_screen.dart';
import 'package:peanut_app/core/di.dart';
import 'package:peanut_app/core/presentation/widgets/splash.dart';
import 'package:peanut_app/core/shared_prefs/shared_prefs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 1000)),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Splash();
        } else {
           String token = injector<SharedPreferencesUtils>().getToken()??'';
           String login = injector<SharedPreferencesUtils>().getLogin()??'0';
           print("my token =>$token");
           print("my user =>$login");
           if (token!='') {
             return const LandingScreen();
           }
          return const SignInScreen();
          // return const LandingScreen();
         // return const HomeScreen();
        }
      }),
    );
  }
}

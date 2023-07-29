import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peanut_app/core/constants/app_constants.dart';
import 'package:peanut_app/core/constants/colors.dart';
import 'package:peanut_app/core/di.dart';
import 'package:peanut_app/core/presentation/blocs/internet_bloc/internet_bloc.dart';
import 'package:peanut_app/core/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: injector<InternetBloc>()),
      ],
      child: MaterialApp(
        title: 'peanut_app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          primarySwatch: Colors.blue,
          textTheme:  const TextTheme(
            bodyLarge: TextStyle(fontFamily: AppConstants.fontFamily),
            bodyMedium: TextStyle(fontFamily: AppConstants.fontFamily),
            displayLarge: TextStyle(fontFamily: AppConstants.fontFamily),
            displayMedium: TextStyle(fontFamily: AppConstants.fontFamily),
            displaySmall: TextStyle(fontFamily: AppConstants.fontFamily),
            headlineMedium: TextStyle(fontFamily: AppConstants.fontFamily),
            headlineSmall:
                TextStyle(fontFamily: AppConstants.fontFamily, fontSize: 24),
            titleLarge: TextStyle(fontFamily: AppConstants.fontFamily),
            bodySmall: TextStyle(fontFamily: AppConstants.fontFamily),
            labelLarge: TextStyle(fontFamily: AppConstants.fontFamily),
            labelSmall: TextStyle(fontFamily: AppConstants.fontFamily),
            titleMedium: TextStyle(fontFamily: AppConstants.fontFamily),
            titleSmall: TextStyle(fontFamily: AppConstants.fontFamily),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: kBlueColor,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedLabelStyle: TextStyle(fontFamily: AppConstants.fontFamily),
            selectedItemColor: kDarkGreyColor,
            unselectedItemColor: kLightGreyColor,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

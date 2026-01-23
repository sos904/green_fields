import 'package:flutter/material.dart';
import 'package:green_fields/screens/forgot_password.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const GreenFieldsApp());
}

class GreenFieldsApp extends StatelessWidget {
  const GreenFieldsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Green Fields',
      theme: ThemeData(
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/signup': (_) => const SignupScreen(),
        '/home': (_) => const HomeScreen(),

        '/forgot-password': (_) => const ForgotPasswordScreen(),
      },
    );
  }
}

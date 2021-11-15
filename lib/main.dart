import 'package:delivery_app/constants.dart';
import 'package:delivery_app/screens/main_screen.dart';
import 'package:delivery_app/screens/sign_in.dart';
import 'package:delivery_app/screens/sign_up.dart';
import 'package:delivery_app/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => WelcomeScreen(),
        '/signin' :(context)=> const SignIn(),
        '/signup':(context)=>SignUp(),
        '/user-profile':(context)=>UserProfile(),
        '/main' :(context)=> const HomeScreen()
      },
    );
  }
}
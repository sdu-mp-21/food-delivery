//import 'package:delivery_app/screens/main_screen.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/screens/restaurant_details_screen.dart';
import 'package:delivery_app/screens/main_screen.dart';
import 'package:flutter/material.dart';

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
        primaryColor: kPrimaryColor,
        //scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/main',
      routes: {
        '/main': (context) => WelcomeScreen(),
        '/restaurants': (context) => RestaurantDetailsScreen(),
      },
    );
  }
}

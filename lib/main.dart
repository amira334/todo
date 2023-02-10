import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color(0xFFFFFFFF),
          secondary: const Color(0xFFB2DFDB),
          tertiary: const Color(0xFF82ADA9),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.blueGrey,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF82ADA9),
          ),
        ),
        textTheme: theme.textTheme.copyWith(
          bodySmall: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.black26,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: const TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold),
          titleLarge: const TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Color(0xFF1d2c2a),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

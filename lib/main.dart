import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    SystemChrome.setSystemUIOverlayStyle(
         const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color(0xFFFFFFFF),
          secondary: const Color(0xFFb2dfdb),
          tertiary: const Color(0xFF82ada9)
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.blueGrey,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF82ada9),

          ),
        ),
        textTheme: theme.textTheme.copyWith(
          bodyText1: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.black12,
          ),
          bodyText2: const TextStyle(
            color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold
          ),

          headline6: const TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodySmall: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.black,
        )
        ),
    ),
        home: HomeScreen(),
    );
  }
}


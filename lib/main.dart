import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twnsqr/presentation/screens/activities_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TwnSqr',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFPRO',
        useMaterial3: true,
        brightness: Brightness.light,
        iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black))
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff35baf8),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      darkTheme: ThemeData(
        fontFamily: 'SFPRO',
        useMaterial3: true,
        brightness: Brightness.dark,
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white))
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff35baf8),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xff0e0e0e),
      ),
      home: ResponsiveActivitiesScreen(),
    );
  }
}
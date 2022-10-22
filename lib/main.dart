import 'package:flutter/material.dart';
import 'package:wavsound/constants/colors.dart';
import 'package:wavsound/persistence_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      title: "WavSound",
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        primaryColor: AppColors.primaryColor,
        textTheme: const TextTheme(
            headline1: TextStyle(color: AppColors.primaryTextColor),
            headline2: TextStyle(color: AppColors.primaryTextColor),
            bodyText2: TextStyle(color: AppColors.primaryTextColor)),
        scaffoldBackgroundColor: AppColors.primaryColor,
        useMaterial3: true,
      ),
      home: const SafeArea(child: PersistentBottomBarScaffold()),
    );
  }
}

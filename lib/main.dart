import 'package:flutter/material.dart';
import 'package:wavsound/classes/colors.dart';
import 'package:wavsound/functions/player.dart';
import 'package:wavsound/functions/shared_pref.dart';
import 'package:wavsound/persistence_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initGetX();
  PlayerFunc.initPlayer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      title: "Wav Sounds",
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

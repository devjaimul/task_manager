import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/splash_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});
static GlobalKey<NavigatorState> navigatorKey=GlobalKey<NavigatorState>();
  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: lightThemeData(),
    );
  }

  ThemeData lightThemeData() {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.themeColor),
        appBarTheme: AppBarTheme(backgroundColor: AppColors.themeColor),
        inputDecorationTheme:  InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
          hintStyle: TextStyle(color: Colors.grey.shade500)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                fixedSize: Size.fromWidth(double.maxFinite),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))));
  }
}

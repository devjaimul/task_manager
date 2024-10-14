import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/screens/navBar/cutom_navBar.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/assets_path.dart';

import 'package:task_manager/ui/widgets/backgorund_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    if (mounted) {
      await Future.delayed(const Duration(seconds: 1));
      bool isUserLogin=await AuthController.checkAuthState();
      Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => isUserLogin?CustomNavbar(): SignInScreen(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeH=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: BackGroundWidget(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AssetsPath.logoJson, height: sizeH*.2),
            DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.themeColor,
                  fontWeight: FontWeight.bold),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Task Manager'),
                ],
                isRepeatingAnimation: true,
              ),
            ),
          ],
        ),
      )),
    );
  }
}

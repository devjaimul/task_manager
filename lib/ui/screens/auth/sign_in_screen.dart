import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/email_verification_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager/ui/screens/navBar/cutom_navBar.dart';

import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: BackGroundWidget(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(
                  height: sizeH * .25,
                ),
                HeadingTwo(data: 'Get Started With'),
                SizedBox(
                  height: sizeH * .03,
                ),
                TextFormField(
                  controller: _emailTEController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(hintText: 'Email'),
                ),
                SizedBox(
                  height: sizeH * .010,
                ),
                TextFormField(
                  controller: _passTEController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(
                  height: sizeH * .018,
                ),
                ElevatedButton(
                    onPressed: _OnTapNavBarButton,
                    child: Icon(Icons.arrow_circle_right_outlined)),
                SizedBox(
                  height: sizeH * .018,
                ),
                TextButton(onPressed: _onTapForgetPassButton, child: HeadingThree(data: 'Forgot Password?',color: Colors.black.withOpacity(0.5),)),
                RichText(text: TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(color: Colors.black,fontSize: sizeH*0.018,letterSpacing: .4),
                  children: [
                    TextSpan(
                      text: ' Sing Up',
                      style: TextStyle(color: AppColors.themeColor),
                      recognizer: TapGestureRecognizer()..onTap= (){

                        _OnTapSignUpButton();
                      }
                    )
                  ]
                ))
              ],
            ),
          ),
        )),
      ),
    );

  }

  void _OnTapSignUpButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
  }
  void _OnTapNavBarButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => CustomNavbar(),));
  }

  void _onTapForgetPassButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EmailVerificationScreen(),));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passTEController.dispose();
  }
}

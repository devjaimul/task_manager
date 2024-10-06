import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/auth/reset_pass_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';

import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {


  final TextEditingController _pinTEController = TextEditingController();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: sizeH * .25,
                    ),
                    HeadingTwo(data: 'Pin Verification'),
                    SizedBox(
                      height: sizeH * .01,
                    ),
                    HeadingThree(data: 'A 6 Digits Verification Code has been Sent to your Email',color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w400,),
                    SizedBox(
                      height: sizeH * .03,
                    ),
                    _buildPinCodeTextField(),
                    SizedBox(
                      height: sizeH * .02,
                    ),

                    ElevatedButton(
                        onPressed: _OnTapVerify,
                        child: HeadingThree(data: 'Verify',color: Colors.white,)),
                    SizedBox(
                      height: sizeH * .018,
                    ),

                    _buildSignInSection(sizeH)
                  ],
                ),
              ),
            )),
      ),
    );

  }

  Widget _buildSignInSection(double sizeH) {
    return Center(
                    child: RichText(text: TextSpan(
                        text: "Have an Account?",
                        style: TextStyle(color: Colors.black,fontSize: sizeH*0.018,letterSpacing: .4),
                        children: [
                          TextSpan(
                              text: ' Sing In',
                              style: TextStyle(color: AppColors.themeColor),
                              recognizer: TapGestureRecognizer()..onTap= (){

                                _OnTapSignInButton();
                              }
                          )
                        ]
                    )),
                  );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: AppColors.themeColor,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.black.withOpacity(0.1),
                      errorBorderColor: Colors.red
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                   keyboardType: TextInputType.number,
                   // errorAnimationController: errorController,
                    controller: _pinTEController,
                    onCompleted: (v) {
                      print("Completed");
                    }, appContext: context,


                  );
  }

  void _OnTapSignInButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen(),), (route) => false,);
  }

  void _OnTapVerify(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassScreen(),));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinTEController.dispose();

  }
}

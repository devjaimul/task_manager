import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/auth/reset_pass_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';

import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';

import '../../../data/models/network_response.dart';
import '../../../data/network caller/network_caller.dart';
import '../../utility/urls.dart';
import '../../widgets/snackbar.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;
  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
  bool otpProgress = false;

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
                HeadingThree(
                  data:
                      'A 6 Digits Verification Code has been Sent to your Email',
                  color: Colors.black.withOpacity(.4),
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(
                  height: sizeH * .03,
                ),
                _buildPinCodeTextField(),
                SizedBox(
                  height: sizeH * .02,
                ),
                Visibility(
                  visible: otpProgress==false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                      onPressed: _OnTapVerify,
                      child: HeadingThree(
                        data: 'Verify',
                        color: Colors.white,
                      )),
                ),
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
      child: RichText(
          text: TextSpan(
              text: "Have an Account?",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: sizeH * 0.018,
                  letterSpacing: .4),
              children: [
            TextSpan(
                text: ' Sing In',
                style: TextStyle(color: AppColors.themeColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _OnTapSignInButton();
                  })
          ])),
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
          errorBorderColor: Colors.red),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      // errorAnimationController: errorController,
      controller: _pinTEController,
      onCompleted: (v) {
        print("Completed");
      },
      appContext: context,
    );
  }

  void _OnTapSignInButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
      (route) => false,
    );
  }

  void _OnTapVerify()async {
   String otp=_pinTEController.text.trim();
   if(otp.length==6){
     await _getOtp(widget.email, otp);
   }
   else{
     showSnackBar('Please enter a valid OtP of 6 digits', context);
   }
  }

  //verify otp api

  Future<void> _getOtp(String email, otp) async {
    if (mounted) {
      setState(() {
        otpProgress = true;
      });
    }
    NetworkResponse response =
        await NetWorkCaller.getRequest(Urls.otpVerify(email, otp));

    if (response.isSuccess) {
      showSnackBar('OTp Verified Successfully', context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  ResetPassScreen(email:email ,otp: otp,),
          ));
    } else {
      if (mounted) {
        showSnackBar(
            response.errorMessage ?? 'Get status count failed', context);
      }
    }
    if (mounted) {
      setState(() {
        otpProgress = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pinTEController.dispose();
  }
}

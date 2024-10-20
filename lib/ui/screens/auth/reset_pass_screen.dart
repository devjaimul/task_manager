import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';

import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';

import '../../../data/models/login_model.dart';
import '../../../data/models/network_response.dart';
import '../../../data/network caller/network_caller.dart';
import '../../utility/urls.dart';
import '../../widgets/snackbar.dart';

class ResetPassScreen extends StatefulWidget {
  //ager page theke otp ante hbe
  final String email;
  final String otp;
  const ResetPassScreen({super.key, required this.email, required this.otp});

  @override
  State<ResetPassScreen> createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {

  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _confirmPassTEController = TextEditingController();
  bool  resetInProgress = false;

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: BackGroundWidget(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: sizeH * .25,
                    ),
                    const HeadingTwo(data: 'Set Password'),
                    SizedBox(
                      height: sizeH * .001,
                    ),
                    HeadingThree(data: 'Minimum length password 8 character with letter'
                        'and number combination ',color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w400,),
                    SizedBox(
                      height: sizeH * .03,
                    ),
                    TextFormField(
                      controller: _passTEController,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    SizedBox(
                      height: sizeH * .01,
                    ),
                    TextFormField(
                      controller: _confirmPassTEController,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(hintText: 'Confirm Password'),
                    ),
                    SizedBox(
                      height: sizeH * .02,
                    ),

                    Visibility(
                      visible: resetInProgress==false,
                      replacement: Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: _OnTapConfirmButton,
                          child: const HeadingThree(data: 'Confirm',color: Colors.white,)),
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

  Center _buildSignInSection(double sizeH) {
    return Center(
                    child: RichText(text: TextSpan(
                        text: "Have an Account?",
                        style: TextStyle(color: Colors.black,fontSize: sizeH*0.018,letterSpacing: .4),
                        children: [
                          TextSpan(
                              text: ' Sing In',
                              style: const TextStyle(color: AppColors.themeColor),
                              recognizer: TapGestureRecognizer()..onTap= (){

                                _OnTapSignInButton();
                              }
                          )
                        ]
                    )),
                  );
  }

  void _OnTapSignInButton(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen(),), (route) => false,);
  }


  void _OnTapConfirmButton() {
    String password = _passTEController.text.trim();
    String confirmPassword = _confirmPassTEController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      showSnackBar('Please fill in all fields', context);
      return;
    }
    if (password.length < 8 || !RegExp(r'^(?=.*[A-Za-z])(?=.*\d).{8,}$').hasMatch(password)) {
      showSnackBar('Password must be at least 8 characters long and include letters and numbers', context);
      return;
    }
    if (password != confirmPassword) {
      showSnackBar('Passwords do not match', context);
      return;
    }

    // Call the reset password API
    resetPass(widget.email, widget.otp, password);
  }

//reset password api
  Future<void> resetPass(String email,otp,password) async {
    if (mounted) {
      setState(() {
        resetInProgress = true;
      });
    }

    Map<String, dynamic> requestInput = {
      "email":email,
      "OTP": otp,
      "password":password
    };

    // API call
    NetworkResponse response =
    await NetWorkCaller.postRequest(Urls.resetPass, body: requestInput);

    if (mounted) {
      setState(() {
        resetInProgress = false;
      });
    }

    if (response.isSuccess) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInScreen(),));
    } else {
      if (mounted) {
        // Show error message if sign-in fails
        showSnackBar(response.errorMessage ?? 'Error ', context);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passTEController.dispose();
    _confirmPassTEController.dispose();

  }
}

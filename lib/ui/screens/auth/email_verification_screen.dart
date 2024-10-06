import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/auth/pin_verification_screen.dart';


import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

  final TextEditingController _emailTEController = TextEditingController();

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
                    const HeadingTwo(data: 'Your Email Address'),
                    SizedBox(
                      height: sizeH * .01,
                    ),
                    HeadingThree(data: 'A 6 Digits Verification Code will Sent to your Email',color: Colors.black.withOpacity(.4),fontWeight: FontWeight.w400,),
                    SizedBox(
                      height: sizeH * .03,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    SizedBox(
                      height: sizeH * .02,
                    ),

                    ElevatedButton(
                        onPressed: _OnTapConfirmButton,
                        child: const Icon(Icons.arrow_circle_right_outlined)),
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
   Navigator.pop(context);
  }

  void _OnTapConfirmButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const PinVerificationScreen(),));
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();

  }
}

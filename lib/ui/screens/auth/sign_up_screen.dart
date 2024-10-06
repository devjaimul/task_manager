import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
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
                      height: sizeH * .12,
                    ),
                    HeadingTwo(data: 'Join With Us'),
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
                      controller: _firstNameTEController,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(hintText: 'First Name'),
                    ),
                    SizedBox(
                      height: sizeH * .018,
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(hintText: 'Last Name'),
                    ),
                    SizedBox(
                      height: sizeH * .018,
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(hintText: 'Mobile'),
                    ),
                    SizedBox(
                      height: sizeH * .018,
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
                        onPressed: () {},
                        child: Icon(Icons.arrow_circle_right_outlined)),
                    SizedBox(
                      height: sizeH * .018,
                    ),

                    _buildRichText(sizeH)
                  ],
                ),
              ),
            )),
      ),
    );
  }

  RichText _buildRichText(double sizeH) {
    return RichText(text: TextSpan(
                      text: "Have account?",
                      style: TextStyle(color: Colors.black,fontSize: sizeH*0.018,letterSpacing: .4),
                      children: [
                        TextSpan(
                            text: ' Sing In',
                            style: TextStyle(color: AppColors.themeColor),
                            recognizer: TapGestureRecognizer()..onTap= _onTapSignInButton
                        )
                      ]
                  ));
  }

  void _onTapSignInButton (){
    Navigator.pop(context);
}
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
  }
}

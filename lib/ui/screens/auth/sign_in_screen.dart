import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/data/models/login_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network%20caller/network_caller.dart';
import 'package:task_manager/ui/screens/auth/email_verification_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager/ui/screens/navBar/cutom_navBar.dart';

import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/utility/urls.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';
import 'package:task_manager/ui/widgets/snackbar.dart';

import '../../utility/app_constant.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool signInProgress = false;
  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: BackGroundWidget(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: sizeH * .25,
                  ),
                  const HeadingTwo(data: 'Get Started With'),
                  SizedBox(
                    height: sizeH * .03,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Email";
                      }
                      if (!AppConstant.emailValidator.hasMatch(value!)) {
                        return 'Enter a Valid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: sizeH * .010,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passTEController,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(hintText: 'Password'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "Enter Your Password";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: sizeH * .018,
                  ),
                  Visibility(
                    visible: signInProgress == false,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: ElevatedButton(
                        onPressed: _onTapNavBarButton,
                        child: const Icon(Icons.arrow_circle_right_outlined)),
                  ),
                  SizedBox(
                    height: sizeH * .018,
                  ),
                  TextButton(
                      onPressed: _onTapForgetPassButton,
                      child: HeadingThree(
                        data: 'Forgot Password?',
                        color: Colors.black.withOpacity(0.5),
                      )),
                  RichText(
                      text: TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: sizeH * 0.018,
                              letterSpacing: .4),
                          children: [
                        TextSpan(
                            text: ' Sing Up',
                            style: const TextStyle(color: AppColors.themeColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _onTapSignUpButton();
                              })
                      ]))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

//sign in api
  Future<void> signIn() async {
    if (mounted) {
      setState(() {
        signInProgress = true;
      });
    }

    Map<String, dynamic> requestInput = {
      "email": _emailTEController.text.trim(),
      "password": _passTEController.text
    };

    // API call
    NetworkResponse response =
        await NetWorkCaller.postRequest(Urls.login, body: requestInput);

    if (mounted) {
      setState(() {
        signInProgress = false;
      });
    }

    if (response.isSuccess) {
      // Parse login model from the response
      LoginModel loginModel = LoginModel.fromJson(response.responseData);

      // Save the token and user data
      await AuthController.saveUserAccessToken(loginModel.token!);
      await AuthController.saveUserData(
          loginModel.users![0]); // Access the first user in the list

      // Navigate to the next screen after successful login
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const CustomNavbar(),
          ),
        );
      }
    } else {
      if (mounted) {
        // Show error message if sign-in fails
        showSnackBar(response.errorMessage ?? 'Error during login', context);
      }
    }
  }

// Navigate to bottom navigation bar after form validation
  void _onTapNavBarButton() {
    if (_formKey.currentState!.validate()) {
      signIn();
    }
  }

  void _onTapSignUpButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        ));
  }

  void _onTapForgetPassButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EmailVerificationScreen(),
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passTEController.dispose();
  }
}

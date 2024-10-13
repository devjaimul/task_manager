import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network%20caller/network_caller.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/utility/app_constant.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/utility/urls.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';
import 'package:task_manager/ui/widgets/snackbar.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool registrationInProgress = false;
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: sizeH * .12,
                    ),
                    const HeadingTwo(data: 'Join With Us'),
                    SizedBox(
                      height: sizeH * .03,
                    ),
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
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
                      controller: _firstNameTEController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: 'First Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Your First Name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: sizeH * .018,
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(hintText: 'Last Name'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Your Last Name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: sizeH * .018,
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: 'Mobile'),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter Your Mobile Number";
                        }
                        if (!AppConstant.mobileValidator.hasMatch(value!) ==
                            false) {
                          return 'Enter Valid Mobile Number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: sizeH * .018,
                    ),
                    TextFormField(
                      obscureText: _showPassword == false,
                      controller: _passTEController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                _showPassword = !_showPassword;
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              icon: Icon(_showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
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
                      visible: registrationInProgress == false,
                      replacement: const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _registerUser();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
                    SizedBox(
                      height: sizeH * .018,
                    ),
                    _buildRichText(sizeH)
                  ],
                )),
          ),
        )),
      ),
    );
  }

  RichText _buildRichText(double sizeH) {
    return RichText(
        text: TextSpan(
            text: "Have account?",
            style: TextStyle(
                color: Colors.black,
                fontSize: sizeH * 0.018,
                letterSpacing: .4),
            children: [
          TextSpan(
              text: ' Sing In',
              style: const TextStyle(color: AppColors.themeColor),
              recognizer: TapGestureRecognizer()..onTap = _onTapSignInButton)
        ]));
  }
//registration api call
  void _registerUser() async {
    registrationInProgress=true;
    if (mounted) {
      setState(() {});
    }

    Map<String, dynamic> requestInput = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
      "password": _passTEController.text
    };
    NetworkResponse networkResponse =
        await NetWorkCaller.postRequest(Urls.registration, body: requestInput);
    registrationInProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (networkResponse.isSuccess) {
      _clearText();
      if (mounted) {
        showSnackBar('Registration Complete', context);
      }
    } else {
      if (mounted) {
        showSnackBar(networkResponse.errorMessage ?? ' Registration Failed', context);
      }
    }
  }

  void _clearText() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passTEController.clear();
  }

  void _onTapSignInButton() {
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

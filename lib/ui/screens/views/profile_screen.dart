import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network%20caller/network_caller.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/utility/urls.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';
import 'package:task_manager/ui/widgets/profile_appbar.dart';
import 'package:task_manager/ui/widgets/snackbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final TextEditingController _firstNameTEController=TextEditingController();
  final TextEditingController _lastNameTEController=TextEditingController();
  final TextEditingController _mobileTEController=TextEditingController();
  final TextEditingController _passwordTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  XFile? selectedImage;
  bool updateProfileInProgress=false;

  //get user data
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userData=AuthController.userData!;
    _emailTEController.text=AuthController.userData!.email ??'';
    _firstNameTEController.text=AuthController.userData!.firstName ??'';
    _lastNameTEController.text=AuthController.userData!.lastName ??'';
    _mobileTEController.text=AuthController.userData!.mobile ??'';
    _passwordTEController.text=AuthController.userData!.password ??'';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context,true),
      body: BackGroundWidget(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                const HeadingTwo(data: 'Update Profile'),
                const SizedBox(height: 20,),
                _buildPhotoPicker(),
                const SizedBox(height: 25,),
                TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailTEController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(
                      hintText: 'Last Name'
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _mobileTEController,
                  decoration: const InputDecoration(
                      hintText: 'Mobile'
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordTEController,
                  decoration: const InputDecoration(
                      hintText: 'Password'
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_circle_right_outlined)),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      )),
    );
  }
Future<void> updateProfile()async{
    updateProfileInProgress=true;
    if(mounted){
      setState(() {

      });
    }
    Map<String,dynamic> requestBody={
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    if(_passwordTEController.text.isNotEmpty){
      requestBody['password']=_passwordTEController.text;
    }
    if(selectedImage!=null){
      File file=File(selectedImage!.path);
      requestBody['photo']=base64Encode(file.readAsBytesSync());
    }
    final NetworkResponse response=await NetWorkCaller.postRequest(Urls.profileUpdate);
    
    if(response.isSuccess){
      
    }else{
     if(mounted){
       showSnackBar(response.errorMessage??'Profile Update Failed!', context);
     }
    }

}
  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _pickProfileImage,
      child: Container(
              height: 48,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    height: 48,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: const Center(child: HeadingThree(data: 'Photos',color: Colors.white,)),
                  ),
                  SizedBox(width: 10,),
                  Expanded(child: HeadingThree(data: selectedImage?.name?? 'No Image Found'))
                ],
              ),
            ),
    );
  }

  Future<void> _pickProfileImage() async{
    ImagePicker imagePicker=ImagePicker();
    final XFile? result=await imagePicker.pickImage(source: ImageSource.gallery);
    if(result!=null){
      selectedImage=result;
      if(mounted){
        setState(() {

        });
      }
    }
  }
}

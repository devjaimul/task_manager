import 'package:flutter/material.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/screens/views/profile_screen.dart';

import '../utility/text_style.dart';

AppBar profileAppBar(context ,[bool isProfile=false]) {
  void onTapProfile(){
    if(isProfile){
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen(),));
  }
  return AppBar(
    title: GestureDetector(
      onTap: (){
     onTapProfile();
      },
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingThree(data: AuthController.userData?.fullName ??'',color: Colors.white,),
          HeadingThree(data: AuthController.userData?.email ??'',color: Colors.white,),
        ],
      ),
    ),
    leading: GestureDetector(
      onTap: ()=>onTapProfile(),
      child: const Padding(
        padding: EdgeInsets.all(5),
        child: CircleAvatar(
        //  child: Image.memory(base64Decoded(AuthController.userData.photo??'')),
        ),
      ),
    ),
    actions: [
      IconButton(onPressed: () async{

        await AuthController.clearAllData();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen(),), (route) => false,);
      }, icon: const Icon(Icons.login_outlined,color: Colors.white,))
    ],


  );


}
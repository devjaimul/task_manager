import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/views/profile_screen.dart';

import '../utility/text_style.dart';

AppBar ProfileAppBar(context ,[bool isProfile=false]) {
  void _OnTapProfile(){
    if(isProfile){
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen(),));
  }
  return AppBar(
    title: GestureDetector(
      onTap: (){
     _OnTapProfile();
      },
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeadingThree(data: 'Kakashi Hatake',color: Colors.white,),
          HeadingThree(data: 'kakashiHatake@gmail.com',color: Colors.white,),
        ],
      ),
    ),
    leading: GestureDetector(
      onTap: ()=>_OnTapProfile(),
      child: const Padding(
        padding: EdgeInsets.all(5),
        child: CircleAvatar(),
      ),
    ),
    actions: [
      IconButton(onPressed: (){}, icon: const Icon(Icons.login_outlined,color: Colors.white,))
    ],


  );


}
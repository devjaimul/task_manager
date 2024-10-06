import 'package:flutter/material.dart';

import '../utility/text_style.dart';

AppBar ProfileAppBar() {
  return AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingThree(data: 'Kakashi Hatake',color: Colors.white,),
        HeadingThree(data: 'kakashiHatake@gmail.com',color: Colors.white,),
      ],
    ),
    leading: Padding(
      padding: const EdgeInsets.all(5),
      child: CircleAvatar(),
    ),
    actions: [
      IconButton(onPressed: (){}, icon: Icon(Icons.login_outlined,color: Colors.white,))
    ],
  );
}
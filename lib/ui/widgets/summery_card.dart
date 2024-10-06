import 'package:flutter/material.dart';
import 'package:task_manager/ui/utility/text_style.dart';

class SummeryCard extends StatelessWidget {
  final String title;
  final String subTitle;
  const SummeryCard({
    super.key, required this.title, required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            HeadingThree(data: title,fontSize: 22,),
            HeadingThree(data: subTitle,color: Colors.black.withOpacity(.6),),
          ],
        ),
      ),
    );
  }
}
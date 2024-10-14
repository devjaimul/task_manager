import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utility/text_style.dart';

class TaskItem extends StatelessWidget {
  final String? title;
  final String? description;
  final String? time;
  final String? status;
  const TaskItem({
    super.key,  this.title,  this.description,  this.time,  this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: HeadingThree(data: title!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingThree(data: description!,color: Colors.black.withOpacity(0.6),fontSize: 15,),
              HeadingThree(
                data: (time != null)
                    ? DateFormat('d MMMM, h:mm a').format(DateTime.parse(time!))
                    : '',
                color: Colors.black.withOpacity(0.8),
                fontSize: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(label: Text(status!),

                    backgroundColor: Colors.blue,
                    labelStyle: const TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                      side: BorderSide.none,

                    ),
                  ),
                  OverflowBar(
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.edit)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.delete,color: Colors.red,)),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
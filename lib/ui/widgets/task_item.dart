import 'package:flutter/material.dart';

import '../utility/text_style.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: HeadingThree(data: 'Title will be here'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingThree(data: 'Descriptopn',color: Colors.black.withOpacity(0.6),fontSize: 15,),
              HeadingThree(data: 'Date : 12/12/24',color: Colors.black.withOpacity(0.8),fontSize: 17,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(label: Text('New'),

                    backgroundColor: Colors.blue,
                    labelStyle: TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),
                      side: BorderSide.none,

                    ),
                  ),
                  ButtonBar(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                      IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.red,)),
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
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/views/add_new_screen.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/widgets/cached_network_image.dart';

import '../../widgets/profile_appbar.dart';
import '../../widgets/summery_card.dart';
import '../../widgets/task_item.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          _buildSummeryScetion(),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {

              return TaskItem();
            },),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: _OnTapButton,child: Icon(Icons.add),),
    );
  }

  Widget _buildSummeryScetion() {
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SummeryCard(title: '12',subTitle: 'New Task',),
              SummeryCard(title: '12',subTitle: 'Completed',),
              SummeryCard(title: '12',subTitle: 'In Progress',),
              SummeryCard(title: '12',subTitle: 'Cancelded',),
            ],
          ),
        );
  }

void _OnTapButton(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewScreen(),));
}
}





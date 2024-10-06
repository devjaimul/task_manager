import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/task_item.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return TaskItem();
        },
      ),
    );
  }
}

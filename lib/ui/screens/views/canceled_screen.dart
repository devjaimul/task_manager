import 'package:flutter/material.dart';

import '../../widgets/task_item.dart';

class CanceledScreen extends StatelessWidget {
  const CanceledScreen({super.key});

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

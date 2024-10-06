import 'package:flutter/material.dart';

import '../../widgets/task_item.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

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

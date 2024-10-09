import 'package:flutter/material.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';
import 'package:task_manager/ui/widgets/profile_appbar.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  final TextEditingController _titleTEController=TextEditingController();
  final TextEditingController _descriptionTEController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(context),
      body: BackGroundWidget(
          child: SingleChildScrollView(
            child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
            children: [
              TextFormField(
                controller: _titleTEController,
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionTEController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: HeadingThree(
                    data: 'Add',
                    color: Colors.white,
                  ))
            ],
                    ),
                  ),
          )),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/network%20caller/network_caller.dart';
import 'package:task_manager/ui/utility/text_style.dart';
import 'package:task_manager/ui/utility/urls.dart';
import 'package:task_manager/ui/widgets/backgorund_widget.dart';
import 'package:task_manager/ui/widgets/profile_appbar.dart';
import 'package:task_manager/ui/widgets/snackbar.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  final TextEditingController _titleTEController=TextEditingController();
  final TextEditingController _descriptionTEController=TextEditingController();
  final GlobalKey<FormState> _globalKey=GlobalKey<FormState>();
  bool isProgrees=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar(context),
      body: BackGroundWidget(
          child: SingleChildScrollView(
            child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Form(
                        key: _globalKey,
                        child: Column(
                      children: [
                        TextFormField(
                          controller: _titleTEController,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Enter Your title";
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _descriptionTEController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                          ),
                          validator: (String? value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Enter Your Description";
                            }

                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: isProgrees==false,
                          replacement: const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                              onPressed: () {
                                if(_globalKey.currentState!.validate()){
                                  _addNewTask();
                                }
                              },
                              child: const HeadingThree(
                                data: 'Add',
                                color: Colors.white,
                              )),
                        )
                      ],
                    )),
                  ),
          )),
    );
  }
//add new task post api call
  Future<void> _addNewTask()async{

    if(mounted){
      setState(() {
        isProgrees=true;
      });
    }
    Map<String,dynamic> requestInput={
      "title":_titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status":"New"
    };
    NetworkResponse response=await NetWorkCaller.postRequest(Urls.createTask,body: requestInput);

    if(mounted){
      setState(() {
        isProgrees=false;
      });
    }

    if(response.isSuccess){
      _clearTask();
       if(mounted){
         showSnackBar('Task Added Succesfully', context);
       }
       else{
         if(mounted){
           showSnackBar('Task Added failed!', context,true);
         }
       }
    }
  }
void _clearTask(){
    _titleTEController.clear();
    _descriptionTEController.clear();
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}

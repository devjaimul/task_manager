import 'package:flutter/material.dart';

import '../../../data/models/network_response.dart';
import '../../../data/models/task_list_wrapper_model.dart';
import '../../../data/network caller/network_caller.dart';
import '../../utility/urls.dart';
import '../../widgets/snackbar.dart';
import '../../widgets/task_item.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  bool getListIsProgress=false;
  List<TaskModel> completedTaskList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCompletedTask();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          _getCompletedTask();
        },
        child: Visibility(
          visible: getListIsProgress==false,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
            itemCount: completedTaskList.length,
            itemBuilder: (context, index) {
              final data=completedTaskList[index];
              return TaskItem(
                title: data.title,
                description: data.description,
                status: data.status,
                time:data.createdDate ,
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _getCompletedTask()async{
    if(mounted){
      setState(() {
        getListIsProgress=true;
      });
    }

    NetworkResponse response=await NetWorkCaller.getRequest(Urls.completedTaskList);

    if(response.isSuccess){
      TaskListWrapperModel taskListWrapperModel=TaskListWrapperModel.fromJson(response.responseData);
      completedTaskList=taskListWrapperModel.data ?? [];
      print(response.statusCode);
      //showSnackBar('Product Get Successfully', context);
    }
    else{
      if(mounted){
        showSnackBar(response.errorMessage??'Get Completed task failed', context);
      }

    }
    if(mounted){
      setState(() {
        getListIsProgress=false;
      });
    }
  }
}

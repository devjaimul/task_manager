import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/network%20caller/network_caller.dart';
import 'package:task_manager/ui/screens/views/add_new_screen.dart';
import 'package:task_manager/ui/utility/urls.dart';
import 'package:task_manager/ui/widgets/snackbar.dart';

import '../../../data/models/status_count_wrapper_count.dart';
import '../../widgets/summery_card.dart';
import '../../widgets/task_item.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getListIsProgress = false;
  bool getStatusCountIsProgress = false;
  List<TaskModel> newTaskList = [];
  List<StatusCountModel> countStatusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTask();
    _getCountStatus();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSummeryScetion(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _getNewTask();
                _getCountStatus();
              },
              child: Visibility(
                visible: getListIsProgress == false,
                replacement: Center(child: CircularProgressIndicator()),
                child: ListView.builder(
                  itemCount: newTaskList.length,
                  itemBuilder: (context, index) {
                    final data = newTaskList[index];
                    return TaskItem(
                        title: data.title,
                        description: data.description.toString(),
                        time: data.createdDate.toString(),
                        status: data.status.toString());
                  },
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapButton,
        child: const Icon(Icons.add),
      ),
    );
  }

//get all tasks api
  Future<void> _getNewTask() async {
    if (mounted) {
      setState(() {
        getListIsProgress = true;
      });
    }
    NetworkResponse response = await NetWorkCaller.getRequest(Urls.newTaskList);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      newTaskList = taskListWrapperModel.data ?? [];
      //showSnackBar('Product Get Successfully', context);
    } else {
      if (mounted) {
        showSnackBar(response.errorMessage ?? 'Get new task failed', context);
      }
    }
    if (mounted) {
      setState(() {
        getListIsProgress = false;
      });
    }
  }

  //get count status api
  Future<void> _getCountStatus() async {
    if (mounted) {
      setState(() {
        getStatusCountIsProgress = true;
      });
    }
    NetworkResponse response =
        await NetWorkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      StatusCountWrapperModel statusCountWrapperModel =
          StatusCountWrapperModel.fromJson(response.responseData);
      countStatusList = statusCountWrapperModel.data ?? [];
      //showSnackBar('Product Get Successfully', context);
    } else {
      if (mounted) {
        showSnackBar(
            response.errorMessage ?? 'Get status count failed', context);
      }
    }
    if (mounted) {
      setState(() {
        getStatusCountIsProgress = false;
      });
    }
  }

  Widget _buildSummeryScetion() {
    return Visibility(
      visible: getStatusCountIsProgress == false,
      replacement: SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: countStatusList.map(
            (e) {
              return SummeryCard(
                  title: (e.sId ?? 'Unknown').toUpperCase(),
                  subTitle: e.sum.toString());
            },
          ).toList(),
        ),
      ),
    );
  }

  void _onTapButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddNewScreen(),
        ));
  }
}
//37 min task manager iii video 2 iv
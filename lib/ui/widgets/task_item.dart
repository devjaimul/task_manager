import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/ui/widgets/snackbar.dart';

import '../../data/models/network_response.dart';
import '../../data/network caller/network_caller.dart';
import '../utility/text_style.dart';
import '../utility/urls.dart';

class TaskItem extends StatefulWidget {
  final String? title;
  final String? id;
  final String? description;
  final String? time;
  final String? status;
  final VoidCallback onUpdate;

  const TaskItem({
    super.key,
    this.title,
    this.description,
    this.time,
    this.status,
    this.id,
    required this.onUpdate,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteInProgress = false;
  bool _editInProgress = false;
  String dropdownValue = '';
  List<String> statusList = ['New', 'Completed', 'In Progress', 'Canceled'];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: ListTile(
          title: HeadingThree(data: widget.title!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingThree(
                data: widget.description!,
                color: Colors.black.withOpacity(0.6),
                fontSize: 15,
              ),
              HeadingThree(
                data: (widget.time != null)
                    ? DateFormat('d MMMM, h:mm a')
                    .format(DateTime.parse(widget.time!))
                    : '',
                color: Colors.black.withOpacity(0.8),
                fontSize: 17,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(widget.status!),
                    backgroundColor: Colors.blue,
                    labelStyle: const TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide.none,
                    ),
                  ),
                  OverflowBar(
                    children: [
                      // Popup Menu Button for status update
                      Visibility(
                        visible: _editInProgress==false,
                        replacement: Center(child: CircularProgressIndicator()),
                        child: PopupMenuButton<String>(
                          onSelected: (String selectedValue) {
                            // _updateStatus(newStatus);
                            dropdownValue=selectedValue;
                            if(mounted){
                              setState(() {

                              });
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return statusList.map((String value) {
                              return PopupMenuItem<String>(
                                value: value,
                                child: ListTile(title: Text(value),trailing: dropdownValue==value?Icon(Icons.check):null,),
                              );
                            }).toList();
                          },
                          child: Icon(Icons.edit),
                        ),
                      ),
                      Visibility(
                        visible: _deleteInProgress == false,
                        replacement:
                        const Center(child: CircularProgressIndicator()),
                        child: IconButton(
                          onPressed: () {
                            _deleteTask();
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
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

  // Method to update the task status
  // Future<void> _updateStatus(String newStatus) async {
  //   // Logic to call API and update the task status
  //   NetworkResponse response = await NetWorkCaller.postRequest(
  //     Urls.updateTaskStatus(widget.id!, newStatus),
  //   );
  //
  //   if (response.isSuccess) {
  //     setState(() {
  //       dropdownValue = newStatus;
  //       widget.onUpdate();
  //     });
  //   } else {
  //     if (mounted) {
  //       showSnackBar(response.errorMessage ?? 'Status update failed', context);
  //     }
  //   }
  // }

  //delete task api
  Future<void> _deleteTask() async {
    if (mounted) {
      setState(() {
        _deleteInProgress = true;
      });
    }
    NetworkResponse response =
    await NetWorkCaller.getRequest(Urls.deleteTask(widget.id!));

    if (response.isSuccess) {
      widget.onUpdate();
    } else {
      if (mounted) {
        showSnackBar(response.errorMessage ?? 'Delete failed', context);
      }
    }
    if (mounted) {
      setState(() {
        _deleteInProgress = false;
      });
    }
  }
}

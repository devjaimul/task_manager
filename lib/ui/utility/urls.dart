class Urls{
  static const String _baseUrl='http://152.42.163.176:2006/api/v1';
  static const String registration='$_baseUrl/Registration';
  static const String login='$_baseUrl/Login';
  static const String createTask='$_baseUrl/createTask';
  static const String newTaskList='$_baseUrl/listTaskByStatus/New';
  static const String completedTaskList='$_baseUrl/listTaskByStatus/Completed';
  static const String taskStatusCount='$_baseUrl/taskStatusCount';
  static  String deleteTask(String id)=>'$_baseUrl/deleteTask/$id';
}
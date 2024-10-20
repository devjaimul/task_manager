class Urls{
  static const String _baseUrl='http://152.42.163.176:2006/api/v1';
  static const String registration='$_baseUrl/Registration';
  static const String login='$_baseUrl/Login';
  static const String createTask='$_baseUrl/createTask';
  static const String newTaskList='$_baseUrl/listTaskByStatus/New';
  static const String completedTaskList='$_baseUrl/listTaskByStatus/Completed';
  static const String taskStatusCount='$_baseUrl/taskStatusCount';
  static const String profileUpdate='$_baseUrl/ProfileUpdate';
  static const String resetPass='$_baseUrl/RecoverResetPassword';
  static  String deleteTask(String id)=>'$_baseUrl/deleteTask/$id';
  static  String emailVerify(String email)=>'$_baseUrl/RecoverVerifyEmail/$email';
  static  String updateTaskStatus(String id,status)=>'$_baseUrl/updateTaskStatus/$id/$status';
  static  String otpVerify(String email,otp)=>'$_baseUrl/RecoverVerifyOtp/$email/$otp';
}
import 'package:task_manager/data/models/user_model.dart';

class LoginModel {
  String? status;
  List<UserModel>? users; // List of users instead of a single user
  String? token;

  LoginModel({this.status, this.users, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      users = List<UserModel>.from(json['data'].map((user) => UserModel.fromJson(user)));
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (users != null) {
      data['data'] = users!.map((user) => user.toJson()).toList();
    }
    data['token'] = token;
    return data;
  }
}

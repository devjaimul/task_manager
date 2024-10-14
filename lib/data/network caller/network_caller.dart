import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';

class NetWorkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      debugPrint(url);

      Response response = await get(Uri.parse(url),headers: {'token':AuthController.accessToken});
      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if(response.statusCode==401) {
        redirectLogin();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    else {
    return NetworkResponse(
    statusCode: response.statusCode, isSuccess: false);
    }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      debugPrint(url);
      debugPrint(body.toString());
      Response response = await post(
        Uri.parse(url),
        headers: {'Content-type': 'Application/json','token':AuthController.accessToken},
        body: jsonEncode(body),
      );

      debugPrint(response.statusCode.toString());
      debugPrint(response.body.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      }

      else if(response.statusCode==401) {
        redirectLogin();
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
      else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }
static Future<void> redirectLogin()async{
    await AuthController.clearAllData();
    Navigator.pushAndRemoveUntil(TaskManager.navigatorKey.currentContext!, MaterialPageRoute(builder: (context) => const SignInScreen(),), (route) => false,);
  }
}

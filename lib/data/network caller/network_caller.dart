import 'dart:convert';

import 'package:http/http.dart';
import 'package:task_manager/data/models/network_response.dart';

class NetWorkCaller {
 static Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(String url, {Map<String, dynamic>? body}) async {
    try {
      Response response = await post(
        Uri.parse(url),
        headers: {'Content-type': 'Application/json'},
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else {
        return NetworkResponse(
            statusCode: response.statusCode, isSuccess: false);
      }
    } catch (e) {
      return NetworkResponse(
          statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }
}

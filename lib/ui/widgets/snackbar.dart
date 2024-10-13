import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(String message, BuildContext context,
    [bool errorMessage = false]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),

    backgroundColor:errorMessage?Colors.red:null
    ,));
}

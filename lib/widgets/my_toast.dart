import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:vitahealth/colors.dart';

class MyToast {
  void spawnToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
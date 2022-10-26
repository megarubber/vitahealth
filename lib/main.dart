import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vitahealth/screens/login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vitahealth/screens/select_exercise.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return MaterialApp(
          home: SelectExercise(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
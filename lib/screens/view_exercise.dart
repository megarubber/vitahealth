import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/widgets/button.dart';

class ViewExercise extends StatelessWidget {
  ViewExercise({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Center(  
            child: Column(
              children: <Widget>[
                ExerciseButton(
                  diameter: 90.sp,
                  color: Colors.red,
                  message: 'Iniciar'
                )
              ]
            )
          )
        )
      )
    );
  }
}
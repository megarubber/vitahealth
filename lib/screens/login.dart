import 'package:vitahealth/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/widgets/my_text_field.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: 500.0,
              height: 500.0,
              decoration: new BoxDecoration(
                color: ProjectColors().circleBackground,
                shape: BoxShape.circle,
              ),
              transform: Matrix4.translationValues(
              200.0, -200.0, 0.0),
            ),
            Container(
              width: 500.0,
              height: 500.0,
              decoration: new BoxDecoration(
                color: ProjectColors().circleBackground,
                shape: BoxShape.circle,
              ),
              transform: Matrix4.translationValues(
              200.0, -200.0, 0.0),
            ),
            Column(
              children: [
                SizedBox(height: 40.h),
                Container(
                  width: 200.sp,
                  height: 150.sp,
                  child: Image.asset('assets/images/logo_RGB.png'),
                ),
                Text(
                  "Fazer Login na VitaHealth",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: ProjectColors().title
                  )
                ),
                MyTextField().createTextField(hint: 'Teste'),
              ]
            )
          ]
        )
      )
    );
  }
}
import 'package:vitahealth/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:vitahealth/widgets/circle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitahealth/widgets/button.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Circle().createCircle(diameter: 500.0, x: 200.0, y: -200.0),
            Circle().createCircle(diameter: 500.0, x: -200.0, y: 500.0),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  Container(
                    width: 200.sp,
                    height: 150.sp,
                    child: Image.asset('assets/images/logo_RGB.png'),
                  ),
                  Text(
                    "Fazer Login na VitaHealth",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: ProjectColors().title
                    )
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 330.w,
                    child: MyTextField().createTextField(hint: 'E-mail'),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 330.w,
                    child: MyTextField().createTextField(hint: 'Senha'),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 330.w,
                    child: Button().createButton(message: 'Acessar')
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 330.w,
                    child: Button().createButton(message: 'Cadastre-se')
                  )                  
                ]
              )
            )
          ]
        )
      )
    );
  }
}
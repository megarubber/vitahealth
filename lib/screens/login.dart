import 'package:vitahealth/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:vitahealth/widgets/circle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitahealth/widgets/button.dart';
import 'package:vitahealth/widgets/my_toast.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  int loginButtonPressed = 0;
  
  void testLogin() {
    loginButtonPressed++;
    if(loginButtonPressed < 3) MyToast().spawnToast(message: "Usuário/Senha inválidos!");
    else MyToast().spawnToast(message: "Login bloqueado: aguarde 30s!");    
  }

  int changeTextInputColor() {
    if(loginButtonPressed > 0 && loginButtonPressed < 3) return 2;
    else if(loginButtonPressed >= 3) return 1;
    else return 0;
  }

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
                    child: MyTextField().createTextField(
                      hint: 'E-mail', 
                      colorMode: changeTextInputColor()
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: 330.w,
                    child: MyTextField().createTextField(
                      hint: 'Senha',
                      colorMode: changeTextInputColor()
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 330.w,
                    child: Button().createButton(message: 'Acessar', action: () => setState(() => testLogin()))
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 330.w,
                    child: Button().createButton(message: 'Cadastre-se', action: () => setState(() => testLogin()))
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
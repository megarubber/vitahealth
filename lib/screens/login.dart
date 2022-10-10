import 'package:vitahealth/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:vitahealth/widgets/circle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitahealth/widgets/button.dart';
import 'package:vitahealth/widgets/my_toast.dart';
import 'dart:async';
import 'package:vitahealth/screens/register.dart';
import 'package:vitahealth/database.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  // Constants
  static const int maxTries = 3;
  static const int waitAfterTries = 30;

  int loginButtonPressed = 0;
  final formKey = GlobalKey<FormState>();

  MyDatabase database = MyDatabase(name: 'vitahealth');

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    database.dispose();
    super.dispose();
  }

  void wrongLogin() {
    loginButtonPressed++;
    if(loginButtonPressed < maxTries) MyToast().spawnToast(message: "Usuário/Senha inválidos!");
    else {
      MyToast().spawnToast(message: "Login bloqueado: aguarde 30s!");
      if(loginButtonPressed == maxTries) {
        Timer(
          const Duration(seconds: waitAfterTries),
          () {
            setState((){ loginButtonPressed = 0; });
          }
        );
      }
    }
  }

  /*
  int changeTextInputColor() {
    if(loginButtonPressed > 0 && loginButtonPressed < maxTries) return 2;
    else if(loginButtonPressed >= maxTries) return 1;
    else return 0;
  }
  */

  bool blockTextInput() {
    setState(() {});
    return loginButtonPressed >= maxTries ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              const Circle().createCircle(diameter: 500.0, x: 200.0, y: -200.0),
              const Circle().createCircle(diameter: 500.0, x: -200.0, y: 500.0),
              Center(
                child: Form(
                  key: formKey,
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
                          /* colorMode: changeTextInputColor(), */
                          colorMode: loginButtonPressed >= maxTries ? 1 : 0,
                          active: blockTextInput(),
                          validatorText: "E-mail inválido!",
                          controller: emailController
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: 330.w,
                        child: MyTextField().createTextField(
                          hint: 'Senha',
                          /* colorMode: changeTextInputColor(), */
                          colorMode: loginButtonPressed >= maxTries ? 1 : 0,
                          hide: true,
                          active: blockTextInput(),
                          validatorText: "Senha inválida!",
                          controller: passwordController
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: 330.w,
                        child: Button().createButton(
                          message: 'Acessar', 
                          action: () => setState(() {
                            if(formKey.currentState!.validate()) {
                              String password = '';
                              this.database.getSpecificAttributeByEmail(
                                emailController.text, 'password').then((value) {
                                  password = value.toString();
                                }
                              );
                              print(password);
                            } else {
                              wrongLogin();
                            }
                          })
                        )
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: 330.w,
                        child: Button().createButton(
                          message: 'Cadastre-se', 
                          action: () { 
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register()
                              )
                            );
                          },
                          enableButton: blockTextInput()
                        )
                      )
                    ]
                  )
                )
              )
            ]
          )
        )
      )
    );
  }
}
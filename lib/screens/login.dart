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
import 'package:vitahealth/screens/home.dart';
import 'package:vitahealth/database.dart';
import 'package:vitahealth/globals.dart';

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
 
  String? _passwordErrorText;
  String? _emailErrorText;

  @override
  void initState() {
    resetLoginPage();
    super.initState();
  }

  @override
  void dispose() {
    database.dispose();
    super.dispose();
  }

  void accessLogin() {
    this.database.getUserByEmail(emailController.text).then((user) => UserGlobals.sessionUser = user);
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home()
          )
        );
      }
    );
  }

  void resetLoginPage() {
    _passwordErrorText = null;
    _emailErrorText = null;
    emailController.text = '';
    passwordController.text = '';
  }

  Route _accessRegister() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Register(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      }
    );
  }

  void wrongLogin() {
    setState(() { });
    loginButtonPressed++;
    if(loginButtonPressed < maxTries) MyToast().spawnToast(message: "Usuário/Senha inválidos!");
    else {
      MyToast().spawnToast(message: "Login bloqueado: aguarde 30s!");
      if(loginButtonPressed == maxTries) {
        Timer(
          const Duration(seconds: waitAfterTries),
          () {
            setState((){ 
              loginButtonPressed = 0; 
            });
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

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              const Circle().createCircle(diameter: 500.0, x: 200.0, y: -size.height * 0.5),
              const Circle().createCircle(diameter: 500.0, x: -200.0, y: size.height * 0.6),
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
                          controller: emailController,
                          exp: r'^[a-z]{1}[A-Za-z0-9_.]{6,}@[a-z]{3,}\.com(\.br)?$',
                          keyboard: TextInputType.emailAddress,
                          errorText: _emailErrorText
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
                          controller: passwordController,
                          exp: r'^(?=.*\d.*\d)(?=.*[a-z])(?=.*[A-Z]).[A-Za-z0-9_.]{8,}$',
                          errorText: _passwordErrorText
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: 330.w,
                        child: Button().createButton(
                          message: 'Acessar', 
                          action: () {
                            //this.database.getAllUsers(printUsers: true);
                            if(formKey.currentState!.validate()) {
                              String password = '';
                              this.database.getSpecificAttributeByEmail(
                                emailController.text, 'password').then((value) {
                                  password = value.toString();
                                  if(value != null) {  
                                    if(password == passwordController.text) accessLogin();
                                    else {
                                      setState(() {
                                        _passwordErrorText = 'Senha não encontrada. Digite outra!';
                                        _emailErrorText = null;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      _passwordErrorText = 'Senha não encontrada. Digite outra!';
                                      _emailErrorText = 'Email não encontrado. Digite outro!';
                                    });
                                  }
                                }
                              );
                            } else wrongLogin();
                          }
                        )
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: 330.w,
                        child: Button().createButton(
                          message: 'Cadastre-se', 
                          action: () { 
                            Navigator.of(context).push(_accessRegister());
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
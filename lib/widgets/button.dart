import 'package:flutter/material.dart';
import 'package:vitahealth/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Button {
  void pressAction() {
    print("You pressed the button!");
  }

  void showToast(String message) {
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

  Widget createButton({required String message}) {
    return OutlinedButton(
      onPressed: () {
        pressAction();
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
        backgroundColor: MaterialStateProperty.all(ProjectColors().buttonBackground),
        foregroundColor: MaterialStateProperty.all(ProjectColors().buttonText),
        padding: MaterialStateProperty.all(
          EdgeInsets.symmetric(vertical: 14.h)),
        textStyle: MaterialStateProperty.all(GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ))
      ),
      child: Text(message)
    );
  }
}

class LoginButton extends Button {
  int countButtonPressed = 0;

  @override
  void pressAction() {
    countButtonPressed++;
    if(countButtonPressed < 3) {
      showToast("Usuário/Senha inválidos!");
    } else {
      showToast("Login bloqueado: aguarde 30s!");    
    }
  }

  int getCounter() {
    return countButtonPressed;
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitahealth/colors.dart';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:intl/intl.dart';

class RegisterProfile extends StatefulWidget {
  @override
  RegisterProfileStatus createState() => RegisterProfileStatus();
}

class RegisterProfileStatus extends State<RegisterProfile> {
  TextEditingController dateinput = TextEditingController();

  String bmiStatus = 'Coloque seus dados para calcular seu IMC!';

  void updateBMIStatus(double height, double mass) {
    double result = (mass/(height * height));
    
    String baseMsg = 'Seu IMC é de: ' + result.toString();

    if(result < 18.5)
      baseMsg += ', o que indica MAGREZA!';
    else if(result >= 18.5 && result < 25.0)
      baseMsg += ', o que indica NORMAL!';
    else if(result >= 25.0 && result < 30.0)
      baseMsg += ', o que indica SOBREPESO!';
    else if(result >= 30.0 && result < 40.0)
      baseMsg += ', o que indica OBESIDADE!';
    else
      baseMsg += ', o que indica OBESIDADE GRAVE!';
    
    bmiStatus = baseMsg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.h),
                Text(
                  'Olá, Usuário!',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    color: ProjectColors().title
                  )
                ),
                SizedBox(height: 20.h),
                Text(
                  'Seja Bem Vindo!',
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: ProjectColors().title
                  )
                ),
                SizedBox(height: 20.h),
                Text(
                  'Como esse é seu primeiro acesso, precisamos '
                  'de mais algumas informações para continuar!',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: ProjectColors().title
                  ),
                  textAlign: TextAlign.center
                ),
                SizedBox(height: 20.h),
                MyTextField().createDateInput(
                  dateinput: dateinput,
                  myContext: context,
                  hint: 'Data de nascimento',
                ),
                SizedBox(height: 15.h),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 160.w,
                      child: MyTextField(changedValue: setState() => updateBMIStatus(10.0, 10.0)).createNumberField(hint: 'Peso (kg)')
                    ),
                    SizedBox(
                      width: 10.w
                    ),
                    SizedBox(
                      width: 160.w,
                      child: MyTextField(changedValue: setState() => updateBMIStatus(10.0, 10.0)).createNumberField(hint: 'Altura (m)')
                    ),
                  ]
                ),
                SizedBox(height: 20.h),
                Text(
                  bmiStatus,
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: ProjectColors().title
                  ),
                  textAlign: TextAlign.center
                )
              ]
            )
          )
        )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitahealth/colors.dart';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:intl/intl.dart';

class RegisterProfile extends StatelessWidget {
  TextEditingController dateinput = TextEditingController();

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
                    fontSize: 25.sp,
                    color: ProjectColors().title
                  )
                ),
                SizedBox(height: 20.h),
                Text(
                  'Seja Bem Vindo!',
                  style: GoogleFonts.poppins(
                    fontSize: 25.sp,
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
                MyTextField().createNumberField(
                  hint: 'Peso'
                )
              ]
            )
          )
        )
      )
    );
  }
}
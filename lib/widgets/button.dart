import 'package:flutter/material.dart';
import 'package:vitahealth/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Button {
  Widget createButton({required String message}) {
    return OutlinedButton(
      onPressed: () {},
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
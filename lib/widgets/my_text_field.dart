import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField {
  Color changeColor([int mode = 0]) {
    switch(mode) {
      case 0:
        return ProjectColors().textField;
      case 1:
        return ProjectColors().textFieldBlock;
      case 2:
        return ProjectColors().textFieldWrong;
      default:
        return ProjectColors().textField;
    }
  }

  Widget createTextField({required String hint, int colorMode = 0}) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        filled: true,
        fillColor: changeColor(colorMode),
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        )
      ),
    );
  }
}
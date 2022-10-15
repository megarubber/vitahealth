import 'package:flutter/material.dart';
import 'package:vitahealth/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCheckbox {
  bool value;
  final String text;
  void Function(bool?) onChanged;
  Color? checkboxColor;

  MyCheckbox({
    required this.value,
    required this.text,
    required this.onChanged,
    this.checkboxColor
  });

  Widget createSimpleCheckbox() {
    return Row(
      children: <Widget>[
        Checkbox(
          value: this.value,
          onChanged: this.onChanged
        ),
        Text(
          this.text,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: ProjectColors().title
          )
        ),
      ]
    );
  }

  Widget createOneCharCheckbox() {
    return Column(
      children: <Widget>[
        Checkbox(
          value: this.value,
          onChanged: this.onChanged,
          fillColor: MaterialStateProperty.all(this.checkboxColor)
        ),
        Text(
          this.text,
          style: GoogleFonts.poppins(
            fontSize: 15.sp,
            color: ProjectColors().title
          ),
          textAlign: TextAlign.center
        )
      ]
    );
  }
}
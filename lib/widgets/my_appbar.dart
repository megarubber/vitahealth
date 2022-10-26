import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/colors.dart';

class MyAppBar {
  static AppBar logoAppBar({VoidCallback? action}) {
    return AppBar(
      title: Image.asset(
        'assets/images/logo_RGB.png',
        fit: BoxFit.contain,
        height: 35.sp
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios
        ),
        onPressed: action,
        color: ProjectColors().title
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: ProjectColors().appBarBackground,
      foregroundColor: ProjectColors().appBarForeground,
    );
  }

  static AppBar textAppBar(String appBarTitle, {VoidCallback? action}) {
    return AppBar(
      title: Text(
        appBarTitle,
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios
        ),
        onPressed: action,
        color: ProjectColors().title
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: ProjectColors().appBarBackground,
      foregroundColor: ProjectColors().appBarForeground,
    );
  }
}
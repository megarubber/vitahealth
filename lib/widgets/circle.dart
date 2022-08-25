import 'package:flutter/material.dart';
import 'package:vitahealth/colors.dart';

class Circle {

  const Circle();

  Widget createCircle({required double diameter, required double x, required double y}) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: new BoxDecoration(
        color: ProjectColors().circleBackground,
        shape: BoxShape.circle,
      ),
      transform: Matrix4.translationValues(
      x, y, 0.0),
    );
  }
}
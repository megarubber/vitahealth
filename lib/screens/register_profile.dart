import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitahealth/colors.dart';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:vitahealth/widgets/my_checkbox.dart';
import 'package:intl/intl.dart';
import 'package:vitahealth/widgets/button.dart';
import 'package:vitahealth/screens/home.dart';
import 'package:vitahealth/globals.dart';
import 'package:vitahealth/database.dart';
import 'dart:core';

class TrainWeek extends StatefulWidget {
  final String checkboxText;

  TrainWeek({Key? key, required this.checkboxText}) : super(key: key);

  @override
  State<TrainWeek> createState() => _TrainWeekState();
}

class _TrainWeekState extends State<TrainWeek> {
  bool checkboxValue = false;
  TextEditingController timeInput = TextEditingController();
  Color statusCheckbox = ProjectColors().textFieldBlock;

  /*
  // not working :(
  Map<String, bool> daysOfWeek = {
    'sunday' : false,
    'monday' : false,
    'tuesday' : false,
    'wednesday' : false,
    'thursday' : false,
    'friday' : false,
    'saturday' : false
  };
  */
  List<bool> daysOfWeek = List<bool>.filled(7, false, growable: false);

  dynamic testBlock(int index, bool? value) {
    if(this.checkboxValue) {
      setState(() {
        this.daysOfWeek[index] = value!;
        statusCheckbox = ProjectColors().textFieldBlock;
      });
      return;
    } else {
      setState(() { 
        this.daysOfWeek[index] = false;
        statusCheckbox = ProjectColors().textFieldWrong;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column( 
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: MyCheckbox(
                value: this.checkboxValue,
                text: widget.checkboxText,
                onChanged: (bool? value) {
                  setState(() {
                    this.checkboxValue = value!;
                    for(int i = 0; i < daysOfWeek.length; i++)
                      testBlock(i, false);
                  });
                }
              ).createSimpleCheckbox(),
            ),
            SizedBox(width: 10.w),
            SizedBox(
              width: 160.w,
              child: MyTextField().createTimeInput(
                timeInput: this.timeInput,
                myContext: context,
                hint: 'Hora',
                active: this.checkboxValue,
                colorMode: this.checkboxValue ? 0 : 1
              )
            )
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyCheckbox(
              text: 'D',
              value: this.daysOfWeek[0],
              onChanged: (bool? value) => testBlock(0, value!),
              checkboxColor: statusCheckbox 
            ).createOneCharCheckbox(),
            MyCheckbox(
              text: 'S',
              value: this.daysOfWeek[1],
              onChanged: (bool? value) => testBlock(1, value!),
              checkboxColor: statusCheckbox 
            ).createOneCharCheckbox(),
            MyCheckbox(
              text: 'T',
              value: this.daysOfWeek[2],
              onChanged: (bool? value) => testBlock(2, value!),
              checkboxColor: statusCheckbox 
            ).createOneCharCheckbox(),
            MyCheckbox(
              text: 'Q',
              value: this.daysOfWeek[3],
              onChanged: (bool? value) => testBlock(3, value!),
              checkboxColor: statusCheckbox 
            ).createOneCharCheckbox(),
            MyCheckbox(
              text: 'Q',
              value: this.daysOfWeek[4],
              onChanged: (bool? value) => testBlock(4, value!),
              checkboxColor: statusCheckbox 
            ).createOneCharCheckbox(),
            MyCheckbox(
              text: 'S',
              value: this.daysOfWeek[5],
              onChanged: (bool? value) => testBlock(5, value!),
              checkboxColor: statusCheckbox 
            ).createOneCharCheckbox(),
            MyCheckbox(
              text: 'S',
              value: this.daysOfWeek[6],
              onChanged: (bool? value) => testBlock(6, value!),
              checkboxColor: statusCheckbox 
            ).createOneCharCheckbox(),
          ]
        )
      ]
    );
  }
}

class RegisterProfile extends StatefulWidget {
  @override
  RegisterProfileStatus createState() => RegisterProfileStatus();
}

class RegisterProfileStatus extends State<RegisterProfile> {
  // Pick the value from TextFields
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  TextEditingController massInput = TextEditingController();
  TextEditingController heightInput = TextEditingController();
  
  String bmiStatus = 'Coloque seus dados para calcular seu IMC!';
  
  double globalMass = 0;
  double globalHeight = 0;

  void updateBMIStatus([double mass = 10, double height = 10]) {
    globalMass = mass;
    globalHeight = height;

    double result = (mass/(height * height));
    print(height * height);

    String baseMsg = 'Seu IMC é de: ' + result.toStringAsFixed(2);

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
    
    setState(() {
      if(globalMass > 0 && globalHeight > 0)
        bmiStatus = baseMsg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.h),
                  Text(
                    'Olá, ' + UserGlobals.getSeparatedName(0),
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
                  MyTextField().createdateInput(
                    dateInput: dateInput,
                    myContext: context,
                    hint: 'Data de nascimento',
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 160.w,
                        child: MyTextField(
                          changedValue: (String value) {
                            updateBMIStatus(double.parse(massInput.text), globalHeight);
                          }
                        ).createNumberField(hint: 'Peso (kg)', inputValue: massInput)
                      ),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 160.w,
                        child: MyTextField(
                          changedValue: (String value) { 
                            updateBMIStatus(globalMass, double.parse(heightInput.text));
                          }
                        ).createNumberField(hint: 'Altura (m)', inputValue: heightInput)
                      ),
                    ]
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    bmiStatus,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      color: ProjectColors().title
                    ),
                    textAlign: TextAlign.center
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Treino Semanal',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      color: ProjectColors().title
                    ),
                    textAlign: TextAlign.center
                  ),
                  SizedBox(height: 30.h),
                  TrainWeek(checkboxText: 'Caminhada'),
                  SizedBox(height: 30.h),
                  TrainWeek(checkboxText: 'Corrida'),
                  SizedBox(height: 30.h),
                  TrainWeek(checkboxText: 'Pular Corda'),
                  SizedBox(height: 30.h),
                  SizedBox(
                    width: 330.w,  
                    child: Button().createButton(
                      message: 'Salvar',
                      action: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home()
                          )
                        );
                      }
                    )
                  ),
                  SizedBox(height: 30.h),
                ]
              )
            )
          )
        )
      )
    );
  }
}
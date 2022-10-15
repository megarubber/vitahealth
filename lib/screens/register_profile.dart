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
import 'package:vitahealth/widgets/my_alert_dialog.dart';
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
  Color statusCheckbox = ProjectColors().textFieldWrong;

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
  TextEditingController massInput = TextEditingController();
  TextEditingController heightInput = TextEditingController();
  
  String bmiStatus = 'Coloque seus dados para calcular seu IMC!';
  
  double globalMass = 0;
  double globalHeight = 0;
  double resultBMI = 0;
  
  // Globals Keys
  final formKey = GlobalKey<FormState>();
  final dateFieldKey = GlobalKey();
  
  void updateBMIStatus([double mass = 10, double height = 10]) {
    globalMass = mass;
    globalHeight = height;    

    var height_squared = height * height;

    if(height_squared > 0)
      resultBMI = (mass/height_squared);
    else
      resultBMI = 0;
    
    String baseMsg = 'Seu IMC é de: ' + resultBMI.toStringAsFixed(2);

    if(resultBMI < 18.5)
      baseMsg += ', o que indica MAGREZA!\n';
    else if(resultBMI >= 18.5 && resultBMI < 25.0)
      baseMsg += ', o que indica NORMAL!\n';
    else if(resultBMI >= 25.0 && resultBMI < 30.0)
      baseMsg += ', o que indica SOBREPESO!\n';
    else if(resultBMI >= 30.0 && resultBMI < 40.0)
      baseMsg += ', o que indica OBESIDADE!\n';
    else
      baseMsg += ', o que indica OBESIDADE GRAVE!\n';
    
    setState(() {
      // Detecting if is greater than zero or isn't divided by zero
      if(resultBMI > 0) {
        if(globalMass > 0 && globalHeight > 0)
          bmiStatus = baseMsg;
      }
      else
        bmiStatus = 'Ocorreu um problema ao calcular o IMC. Verifique novamente os valores inseridos.';
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
                    'Olá, ' + UserGlobals.getSeparatedName(0) + '!',
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
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        MyTextField().createDateInput(
                          key: dateFieldKey,
                          dateInput: dateInput,
                          myContext: context,
                          hint: 'Data de nascimento',
                          validatorText: 'É necessário colocar a data de nascimento'
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
                              ).createNumberField(hint: 'Peso (kg)', inputValue: massInput, validatorText: 'Insira o peso')
                            ),
                            SizedBox(width: 10.w),
                            SizedBox(
                              width: 160.w,
                              child: MyTextField(
                                changedValue: (String value) { 
                                  updateBMIStatus(globalMass, double.parse(heightInput.text));
                                }
                              ).createNumberField(hint: 'Altura (m)', inputValue: heightInput, validatorText: 'Insira a altura')
                            ),
                          ],
                        ),
                      ],
                    ),
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
                        if(formKey.currentState!.validate()) {
                          if(resultBMI > 0) {  
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home()
                              )
                            );
                          } else {
                            MyAlertDialog(
                              title: 'Erro!',
                              message: 'Ocorreu um problema ao calcular o IMC. Verifique novamente os valores inseridos.',
                              context: context
                            ).showConfirmAlert(
                              execute: () {
                                Scrollable.ensureVisible(dateFieldKey.currentContext!);
                                Navigator.of(context).pop();
                              }
                            );
                          }
                        } else {
                          Scrollable.ensureVisible(dateFieldKey.currentContext!);
                        }
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
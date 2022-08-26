import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitahealth/widgets/button.dart';
import 'package:vitahealth/colors.dart';
import 'dart:io';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:vitahealth/widgets/button.dart';
import 'package:vitahealth/screens/login.dart';
import 'package:path_provider/path_provider.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  File? profileImage;
  final int spaceBetween = 15;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if(image == null) return;
    final imageTemporary = File(image.path);
    setState(() => profileImage = imageTemporary);
  }

  void testForms(BuildContext context) {
    // Turn off the focus from TextField
    FocusNode? currentFocus = FocusScope.of(context).focusedChild;
    if (currentFocus != null) currentFocus.unfocus();

    // Start Alert
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Erro"),
          content: new Text("Teste de erro"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  void returnToLogin(BuildContext context) {
    // Turn off the focus from TextField
    FocusNode? currentFocus = FocusScope.of(context).focusedChild;
    if (currentFocus != null) currentFocus.unfocus();

    // Start Alert
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alerta"),
          content: new Text("Você realmente deseja cancelar o cadastro?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Sim"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login()
                  )
                );
              }
            ),
            new FlatButton(
              child: new Text("Não"),
              onPressed: () {
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors().backgroundV1,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login()
              )
            );            
          }
        ),
        title: Text("Cadastro de Usuários"),
        backgroundColor: ProjectColors().appBarBackground,
        foregroundColor: ProjectColors().appBarForeground,
        elevation: 0
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () => pickImage(), 
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: profileImage != null ? 
                      Image.file(profileImage!, width: 100.sp, height: 100.sp, fit: BoxFit.cover) : 
                      Image.asset('assets/images/user_icon.png', width: 100.sp, height: 100.sp)
                    )
                  ),
                ),
                SizedBox(height: spaceBetween.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: 50.sp,
                    ),
                    SizedBox(
                      width: 270.w,
                      child: MyTextField().createTextField(hint: "Nome e Sobrenome")
                    )
                  ]
                ),
                SizedBox(height: spaceBetween.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.email,
                      size: 50.sp,
                    ),
                    SizedBox(
                      width: 270.w,
                      child: MyTextField().createTextField(hint: "Email")
                    )
                  ]
                ),
                SizedBox(height: spaceBetween.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.local_phone_rounded,
                      size: 50.sp,
                    ),
                    SizedBox(
                      width: 270.w,
                      child: MyTextField().createPhoneTextField(hint: "Telefone")
                    )
                  ]
                ),
                SizedBox(height: spaceBetween.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.star,
                      size: 50.sp,
                    ),
                    SizedBox(
                      width: 270.w,
                      child: MyTextField().createTextField(hint: "Nome de usuário")
                    )
                  ]
                ),
                SizedBox(height: spaceBetween.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.key,
                      size: 50.sp,
                    ),
                    SizedBox(
                      width: 270.w,
                      child: MyTextField().createTextField(hint: "Senha", hide: true)
                    )
                  ]
                ),
                SizedBox(height: spaceBetween.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.lock,
                      size: 50.sp,
                    ),
                    SizedBox(
                      width: 270.w,
                      child: MyTextField().createTextField(hint: "Confirme a senha", hide: true)
                    )
                  ]
                ),
                SizedBox(height: spaceBetween.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [                
                    SizedBox(
                      width: 150.w,
                      child: Button().createButton(message: 'Cancelar', action: () => returnToLogin(context))
                    ),
                    SizedBox(
                      width: 150.w,
                      child: Button().createButton(message: 'Cadastrar', action: () => testForms(context))
                    ),
                  ]
                )
              ]
            )
          )
        )
      )
    );
  }
}
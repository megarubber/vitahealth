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

final int spaceBetween = 15;

class PageOne extends StatelessWidget {
  PageOne({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
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
              child: MyTextField().createTextField(
                hint: "Nome e Sobrenome", 
                validatorText: "Nome e Sobrenome inválidos!",
                exp: r'^\w[A-Za-záàâãéèêíïóôõöúçñ]{2,}\s\w[A-Za-záàâãéèêíïóôõöúçñ]{2,}$',
              )
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
              child: MyTextField().createTextField(
                hint: "E-mail",
                validatorText: "E-mail inválido!",
                exp: r'^[a-z]{1}[A-Za-z0-9_.]{6,}@[a-z]{3,}\.com(\.br)?$',
                keyboard: TextInputType.emailAddress
              )
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
              child: MyTextField().createTextField(
                hint: "Telefone",
                validatorText: 'Telefone Inválido!',
                keyboard: TextInputType.phone,
                exp: r'^\(\d{2}\)\s\d{5}-\d{4}$',
                formatter: '(##) #####-####'
              )
            )
          ]
        ),
      ]
    );
  }
}

class PageTwo extends StatelessWidget {
  PageTwo({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.star,
              size: 50.sp,
            ),
            SizedBox(
              width: 270.w,
              child: MyTextField().createTextField(
                hint: "Nome de usuário", 
                validatorText: "Nome de usuário inválido!",
                exp: r'^[a-z_.]{1}[a-z0-9_.]{5,}$'
              )
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
              child: MyTextField().createTextField(
                hint: "Senha", 
                hide: true, 
                validatorText: "Senha inválida!",
                exp: r'^(?=.*\d.*\d)(?=.*[a-z])(?=.*[A-Z]).[A-Za-z0-9_.]{8,}$'
              )
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
              child: MyTextField().createTextField(
                hint: "Confirme a senha", 
                hide: true, 
                validatorText: "As senhas precisam ser iguais"
              )
            )
          ]
        ),
        SizedBox(height: spaceBetween.h),
        /*
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [                
            SizedBox(
              width: 150.w,
              child: Button().createButton(message: 'Cancelar', action: () => returnToLogin(context))
            ),
            SizedBox(
              width: 150.w,
              child: Button().createButton(message: 'Cadastrar', action: () => formKey.currentState!.validate())
            ),
          ]
        )
        */
      ]
    );
  }
}

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  File? profileImage;
  final formKey = GlobalKey<FormState>();

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
          title: Text("Erro"),
          content: Text("Teste de erro"),
          actions: <Widget>[
            TextButton(
              child: Text("Ok"),
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
          title: Text("Alerta"),
          content: Text("Você realmente deseja cancelar o cadastro?"),
          actions: <Widget>[
            TextButton(
              child: Text("Sim"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login()
                  )
                );
              }
            ),
            TextButton(
              child: Text("Não"),
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
        title: Text("Cadastro de Usuário"),
        backgroundColor: ProjectColors().appBarBackground,
        foregroundColor: ProjectColors().appBarForeground,
        elevation: 0
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
               ]
              )
            )
          )
        )
      )
    );
  }
}
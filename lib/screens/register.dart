import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vitahealth/widgets/button.dart';
import 'package:vitahealth/colors.dart';
import 'dart:io';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:vitahealth/widgets/button.dart';

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
                      child: MyTextField().createTextField(hint: "Telefone")
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
                      child: Button().createButton(message: 'Cancelar', action: () => print("test"))
                    ),
                    SizedBox(
                      width: 150.w,
                      child: Button().createButton(message: 'Cadastrar', action: () => print("test"))
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
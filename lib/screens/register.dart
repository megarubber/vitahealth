// pub.dev packages
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// project packages
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:vitahealth/widgets/button.dart';
import 'package:vitahealth/colors.dart';
import 'package:vitahealth/widgets/my_text_field.dart';
import 'package:vitahealth/widgets/button.dart';
import 'package:vitahealth/screens/login.dart';
import 'package:vitahealth/database.dart';
import 'package:vitahealth/widgets/my_alert_dialog.dart';
import 'package:vitahealth/utility.dart';
import 'package:vitahealth/globals.dart';
import 'package:vitahealth/screens/register_profile.dart';

// dart packages
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

Map<String, TextEditingController> myTextFieldControllers = {
  'name' : new TextEditingController(),
  'email' : new TextEditingController(),
  'phone' : new TextEditingController(),
  'username' : new TextEditingController(),
  'password' : new TextEditingController(),
  'confirm-password' : new TextEditingController(),
}; 

class PageOne extends StatelessWidget {
  final double spaceBetween;
  
  PageOne({
    Key? key,
    this.spaceBetween = 15
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: this.spaceBetween.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(  
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Icon(
                Icons.account_circle_rounded,
                size: 50.sp,
              ),
            ),
            SizedBox(
              width: 270.w,
              child: MyTextField().createTextField(
                controller: myTextFieldControllers['name'],
                hint: "Nome e Sobrenome", 
                validatorText: "Nome e Sobrenome inválidos!",
                exp: r'^\w[A-Za-záàâãéèêíïóôõöúçñ]{2,}\s\w[A-Za-záàâãéèêíïóôõöúçñ]{2,}$',
              )
            )
          ]
        ),
        SizedBox(height: this.spaceBetween.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(  
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Icon(
                Icons.email,
                size: 50.sp,
              ),
            ),
            SizedBox(
              width: 270.w,
              child: MyTextField().createTextField(
                controller: myTextFieldControllers['email'],
                hint: "E-mail",
                validatorText: "E-mail inválido!",
                exp: r'^[a-z]{1}[A-Za-z0-9_.]{6,}@[a-z]{3,}\.com(\.br)?$',
                keyboard: TextInputType.emailAddress
              )
            )
          ]
        ),
        SizedBox(height: this.spaceBetween.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(  
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Icon(
                Icons.local_phone_rounded,
                size: 50.sp,
              ),
            ),
            SizedBox(
              width: 270.w,
              child: MyTextField().createTextField(
                controller: myTextFieldControllers['phone'],
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
  final double spaceBetween;

  PageTwo({
    Key? key,
    this.spaceBetween = 15
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: this.spaceBetween.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(  
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Icon(
                Icons.star,
                size: 50.sp,
              ),
            ),
            SizedBox(
              width: 270.w,
              child: MyTextField().createTextField(
                controller: myTextFieldControllers['username'],
                hint: "Nome de usuário", 
                validatorText: "Nome de usuário inválido!",
                exp: r'^[a-z_.]{1}[a-z0-9_.]{5,}$'
              )
            )
          ]
        ),
        SizedBox(height: this.spaceBetween.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(  
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Icon(
                Icons.key,
                size: 50.sp,
              ),
            ),
            SizedBox(
              width: 270.w,
              child: MyTextField().createTextField(
                controller: myTextFieldControllers['password'],
                hint: "Senha", 
                hide: true, 
                validatorText: 'Senha inválida!',
                exp: r'^(?=.*\d.*\d)(?=.*[a-z])(?=.*[A-Z]).[A-Za-z0-9_.]{8,}$'
              )
            )
          ]
        ),
        SizedBox(height: this.spaceBetween.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(  
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Icon(
                Icons.lock,
                size: 50.sp,
              ),
            ),           
            SizedBox(
              width: 270.w,
              child: MyTextField().createTextField(
                controller: myTextFieldControllers['confirm-password'],
                hint: 'Confirme a senha', 
                hide: true, 
                validatorText: 'Senha inválida!',
                exp: r'^(?=.*\d.*\d)(?=.*[a-z])(?=.*[A-Z]).[A-Za-z0-9_.]{8,}$'
              )
            )
          ]
        ),
        SizedBox(height: this.spaceBetween.h),
      ]
    );
  }
}

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

enum UploadImageState {idle, loading, done}

class RegisterState extends State<Register> {

  File? profileImage;
  final formKey = GlobalKey<FormState>();
  final _pageController = PageController(initialPage: 0);
  int currentPage = 0;
  late MyDatabase database = MyDatabase(name: 'vitahealth');
  String imageString = '';
  
  UploadImageState imgState = UploadImageState.idle;

  /*
  String test = '';
  
  void maisteste() {
  	this.database.getSpecificAttribute(1, 'picture').then(
	  (result) {
	  	setState(() { test = result.toString(); });
	  }
	);
  }
  */

  @override
  void dispose() {
    _pageController.dispose();
    database.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    setState(() => imgState = UploadImageState.loading);

    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if(image == null) {
      setState(() => imgState = UploadImageState.idle);
      return;
    }
    final imageTemporary = File(image.path);
    imageString = Utility.base64String(imageTemporary.readAsBytesSync());
    setState(() {
      profileImage = imageTemporary;
      imgState = UploadImageState.done;
    });
  }

  void submitForm({required BuildContext context, required User user}) {
    // Turn off the focus from TextField
    FocusNode? currentFocus = FocusScope.of(context).focusedChild;
    if (currentFocus != null) currentFocus.unfocus();

    // Send data
    this.database.insertUser(user);

    // Start Alert
    MyAlertDialog(
      context: context,
      title: 'Confirmação',
      message: 'Registro feito com sucesso!'
    ).showConfirmAlert(
      execute: () {
        // Show all users
        //this.database.getAllUsers();

        // Save session (global variable)
        UserGlobals.sessionUser = user;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterProfile()
          )
        );
      }
    );
  }

  void returnToLogin(BuildContext context) {
    // Turn off the focus from TextField
    FocusNode? currentFocus = FocusScope.of(context).focusedChild;
    if (currentFocus != null) currentFocus.unfocus();
	
    // Start Alert
    MyAlertDialog(
      context: context,
      title: 'Alerta',
      message: 'Você realmente deseja cancelar o cadastro?'
    ).showYesOrNoAlert(
      chooseYes: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login()
          )
        );
        // Reset values from all fields
        myTextFieldControllers.updateAll((field, value) => value = TextEditingController(text: ''));
      },
      chooseNo: () => Navigator.of(context).pop()
    );
  }
  
  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ProjectColors().backgroundV1,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            /*
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login()
              )
            );
            */
            returnToLogin(context);           
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
                children: <Widget>[
                  SizedBox(height: 10.h),
                  InkWell(
                    onTap: () => pickImage(), 
                    child: Center(
                      child: imgState != UploadImageState.loading ? 
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: profileImage != null ? 
                        Image.file(profileImage!, width: 100.sp, height: 100.sp, fit: BoxFit.cover) :
                        /*
                          Image.memory(
                          Base64Decoder().convert(test), 
                          width: 100.sp, height: 100.sp, fit: BoxFit.cover)
                        */
                        Image.asset('assets/images/user_icon.png', width: 100.sp, height: 100.sp)
                      ) 
                      : 
                      LoadingAnimationWidget.threeRotatingDots(
                        color: ProjectColors().title,
                        size: 100.sp
                      )
                    ),
                  ),
                  Container(
                    height: size.height * 0.5, 
                    width: size.width,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: <Widget>[
                        PageOne(spaceBetween: 15.h),
                        PageTwo(spaceBetween: 15.h),
                      ]
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [                
                      SizedBox(
                        width: 150.w,
                        child: Button().createButton(
                          message: currentPage == 0 ? 'Cancelar' : 'Voltar', 
                          action: () {
                            if(currentPage == 0)
                              returnToLogin(context);
                            else {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut
                              );
                              setState(() { currentPage--; });
                            }
                          }
                        )
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Button().createButton(
                          message: currentPage == 0 ? 'Continuar' : 'Cadastrar', 
                          action: () {
                            if(formKey.currentState!.validate()) {
                              if(currentPage == 0) {  
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut
                                );
                                setState(() { currentPage++; });
                              } else {
                                List<String> passwords = [];
                                passwords.add(myTextFieldControllers['password']?.text ?? '1234');
                                passwords.add(myTextFieldControllers['confirm-password']?.text ?? '5678');
                                // Tests if the two passwords are equal & profile image exists
                                if(passwords[0] == passwords[1] && profileImage != null) {
                                  submitForm(
                                    context: context,
                                    user: User(
                                      name: myTextFieldControllers['name']?.text ?? 'user',
                                      email: myTextFieldControllers['email']?.text ?? 'user@user.com',
                                      phone: myTextFieldControllers['phone']?.text ?? '(00) 00000-0000',
                                      username: myTextFieldControllers['username']?.text ?? 'user_test',
                                      password: myTextFieldControllers['password']?.text ?? '1234',
                                      picture: imageString
                                    )
                                  );
                                } else if(passwords[0] != passwords[1] && profileImage != null){
                                  MyAlertDialog(
                                    context: context,
                                    title: 'Atenção!',
                                    message: 'As senhas precisam ser iguais.'
                                  ).showConfirmAlert();
                                } else {
                                  MyAlertDialog(
                                    context: context,
                                    title: 'Atenção!',
                                    message: 'É necessário inserir uma foto de perfil.'
                                  ).showConfirmAlert();
                              	}
	              						  }
                            }
                          }
                        )
                      ),
                    ]
                  )
                ]
              )
            )
          )
        )
      )
    );
  }
}
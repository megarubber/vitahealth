import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitahealth/colors.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.format_list_bulleted
          ),
          onPressed: () => _key.currentState!.openDrawer()
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.workspaces,
              color: ProjectColors().appBarForeground
            ),
            onPressed: () => null
          )
        ],
        backgroundColor: ProjectColors().appBarBackground,
        foregroundColor: ProjectColors().appBarForeground,
        elevation: 0
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 5.h),
              Container(
                width: 200.sp,
                height: 150.sp,
                child: Image.asset('assets/images/logo_RGB.png')
              ),
              Text(
                "Para melhorar o bem-estar e manter o corpo das pessoas mais saudáveis, "
                "a startup IANES desenvolveu o aplicativo VitaHealth que permite seus "
                "usuários obter e monitorar as informações corporais, como também planerjar, "
                "definir metas e receber notificações sobre as atividades físicas. Para garantir "
                "a acessibilidade do seu aplicativo, a startup IANES decidiu criar um projeto "
                "para melhorar a usabilidade do aplicativo para todos os seus usuários, incluindo "
                "aqueles com restrições de visão, daltonismo, dificuldades auditivas, comprometimento " 
                "da coordenação motora, deficiências cognitivas e muitas outras deficiências.",
                style: GoogleFonts.poppins(
                  fontSize: 15.sp,
                  color: ProjectColors().title
                ),
                textAlign: TextAlign.center,
              )
            ]
          )
        )        
      ),
      drawer: MyDrawerWidget()
    );
  }
}

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            child: Icon(Icons.flutter_dash, size: 35)
          )
        ]
      )
    );
  }
}
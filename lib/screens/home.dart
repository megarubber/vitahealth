import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vitahealth/colors.dart';
import 'package:vitahealth/globals.dart';
import 'package:vitahealth/utility.dart';

class Home extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: ProjectColors().backgroundV1,
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
                  fontSize: 14.sp,
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
        children: <Widget>[
          Container(
            color: ProjectColors().backgroundV1,
            child: Padding(
              padding: EdgeInsets.all(20.sp),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: UserGlobals.getUsername() == 'vitahealth_user' ? 
                    Image.asset('assets/images/user_icon.png', width: 80.sp, height: 80.sp) :
                    Image.memory(
                      Utility.dataFromBase64String(
                        UserGlobals.getRawPictureString(),
                      ),
                      width: 80.sp, height: 80.sp,
                      fit: BoxFit.cover
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: <Widget>[  
                        Text(
                          UserGlobals.getSeparatedName(0) + ' ' + UserGlobals.getSeparatedName(1),
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            color: ProjectColors().title
                          ),
                          textAlign: TextAlign.center
                        ),
                        Text(
                          UserGlobals.getEmail(),
                          style: GoogleFonts.poppins(
                            fontSize: 10.sp,
                            color: ProjectColors().title
                          ),
                          textAlign: TextAlign.center
                        ),
                      ]
                    )
                  )
                ]
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            //onTap() => null
          ),
          ListTile(
            leading: const Icon(Icons.directions_run),
            title: const Text('Exercícios'),
            //onTap() => null
          ),
          ListTile(
            leading: const Icon(Icons.currency_bitcoin),
            title: const Text('WS Coins'),
            //onTap() => null
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            //onTap() => null
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            //onTap() => null
          )
        ]
      )
    );
  }
}
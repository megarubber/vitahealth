import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  int countLoginTries = 0;
  bool wrongMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/images/logo_RGB.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
              child: Text('Login'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: wrongMode ? Colors.red : Colors.black)
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                  hintText: 'abc@gmail.com'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 35),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: wrongMode ? Colors.red : Colors.black)
                  ),
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  hintText: 'Entre com uma senha!'
                ),
              ),
            ),
            Container(
              height: 70,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20)
              ),
              child: FlatButton(
                onPressed: (){
                  if(countLoginTries <= 3) {
                    setState(() { wrongMode = true; } );
                    Fluttertoast.showToast(
                        msg: "Usuário/Senha inválidos!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    countLoginTries++;
                  }
                  else {
                    Fluttertoast.showToast(
                        msg: "Login bloqueado: aguarde 30s!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );    
                    setState(() { 
                      wrongMode = false; 
                      null;
                    } );           
                  }
                },

                child: Text(
                  'Acessar',
                  style: TextStyle(color: Colors.white, fontSize: 25)
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              height: 70,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20)
              ),
              child: FlatButton(
                onPressed: null,

                child: Text(
                  'Cadastre-se',
                  style: TextStyle(color: Colors.white, fontSize: 25)
                )
              )
            )
          ]
        )
      )
    );
  }
}
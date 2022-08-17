import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vitahealth/size_config.dart';
import '../strings.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 1 * SizeConfig.heightMultiplier),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FittedBox(
                  child: Text(
                    Strings.login,
                    textAlign: TextAlign.center
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:vitahealth/database.dart';
import 'dart:core';

class UserGlobals {
  static User sessionUser = User(
    name: 'User VitaHealth',
    email: 'user@email.com',
    phone: '(99) 99999-9999',
    username: 'vitahealth_user',
    password: '123',
    picture: 'user_picture'
  );

  static String getSeparatedName(int index) {
    final String getName = sessionUser.toMap()['name'].toString();
    final List<String> display = getName.split(' ');

    return display[index];
  }
}
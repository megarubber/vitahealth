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
  
  static String getRawPictureString() {
    final String _picture = sessionUser.toMap()['picture'].toString();
    return _picture;
  }

  static String getSeparatedName(int index) {
    final String getName = sessionUser.toMap()['name'].toString();
    final List<String> display = getName.split(' ');

    return display[index];
  }

  static String getEmail() {
    final String _email = sessionUser.toMap()['email'].toString();
    return _email;
  }

  static String getUsername() {
    final String _username = sessionUser.toMap()['username'].toString();
    return _username;
  }
}
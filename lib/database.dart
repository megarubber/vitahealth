import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*
// Embedding .db files
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:io';
*/

class User {
  final String name;
  final String email;
  final String phone;
  final String username;
  final String password;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.username,
    required this.password
  });

  User.fromMap(Map<String, dynamic> data)
  : this.name = data['name'],
  this.email = data['email'],
  this.phone = data['phone'],
  this.username = data['username'],
  this.password = data['password'];

  Map<String, Object?> toMap() {
    return {'name': this.name, 'email': this.email, 'phone': this.phone, 'username': this.username, 'password': this.password};
  }
}

class MyDatabase {
  final String name;

  MyDatabase({
    required this.name
  });
  
  Future<Database> initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    return openDatabase(
      join(databasePath, this.name + '.db'),
      onCreate: (database, version) async {
        await database.execute(
          '''
          CREATE TABLE user(
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            name VARCHAR(40) NOT NULL,
            email VARCHAR(20) NOT NULL,
            phone VARCHAR(16) NOT NULL,
            username VARCHAR(15) NOT NULL,
            password VARCHAR(20) NOT NULL
          );
          '''
        );
      },
      version: 1
    );
  }

  Future<int> insertUser(User user) async {
    int result = 0;
    final Database database = await initializeDatabase();
    result = await database.insert('user', user.toMap());
    return result;
  }
}

/*
class MyDatabase {
  Database _database;
  final String name;

  MyDatabase({
    required this.name
  });

  initDatabase() async {
    final String fileName = this.name + '.db';
    _database = await openDatabase('assets/databases/' + fileName);
    String databasePath = join(await getDatabasesPath(), fileName);

    bool dbExists = await databaseExists(databasePath);

    if(!dbExists) {
      print('Create a new copy of database from assets!');

      // Copy from assets
      ByteData data = await rootBundle.load(join('assets/databases', fileName));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(databasePath).writeAsBytes(bytes, flush: true);
    }

    // Open the database
    _db = await openDatabase(databasePath);
  }  
}
*/
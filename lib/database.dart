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
  static Database? _database;

  MyDatabase({
    required this.name,
  });

  Future<Database> get database async => _database ??= await initiateDatabase();

  Future<Database> initiateDatabase() async {
    String databasePath = await getDatabasesPath();
    print('Database was created!');
    return await openDatabase(
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
    final Database db = await database;
    int result = 0;
    result = await db.insert('user', user.toMap());
    return result;
  }

  Future<User> getUser(int id) async {
    final Database db = await database;

    final List<Map<String, Object?>> queryResult = await db.query(
      'user',
      where: 'id = ?',
      whereArgs: [id.toString()]
    );
    
    /*
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'SELECT * FROM user WHERE id =?', [id.toString()]
    );
    */
    
    final List<User> singleUser = queryResult.map((e) => User.fromMap(e)).toList();
    return singleUser[0];
  }

  Future<List<User>> getAllUsers() async {
    final Database db = await database;
    final List<Map<String, Object?>> queryResult = await db.query('user');
    queryResult.forEach((row) => print(row));
    return queryResult.map((user) => User.fromMap(user)).toList();
  }

  Future dispose() async {
    final db = await database;
    db.close();
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
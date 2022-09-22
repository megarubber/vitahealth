import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
  Database _db;

  Future<Database> initializeDatabase({required String databaseName}) async {
    String databasePath = await getDatabasesPath();
    return openDatabase(join(databasePath, databaseName + '.db'));
  }

  Future<int> insertUser(List<User> users) async {
    int result = 0;
    final Database db = await initializeDatabase();
    for(User u in users) {
      result = await db.insert('user', user.toMap());
    }
  }

  dispose() {
    _db.close();
  }
}
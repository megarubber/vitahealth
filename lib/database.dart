import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Future<Database> initializeDatabase({required String databaseName}) async {
    String databasePath = await getDatabasesPath();
    return openDatabase(join(databasePath, databaseName + '.db'));
  }
   
}
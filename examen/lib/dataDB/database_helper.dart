import 'dart:io';
import 'package:examen/models/peoples.dart';
import 'package:examen/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper database = DatabaseHelper._();

  Database _db;
  final String tableUser = "User";
  final String columnUserName = "username";
  final String columnPassword = "password";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "data_main.db");
    var ourDb = await openDatabase(path, version: 4, onCreate: _onCreate);
    print(path);
    print(ourDb);
    return ourDb;
  }

  void _onCreate(Database database, int version) async {
    await database.execute(
        '''CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, flaglogged TEXT)''');
    print("Table is created");

    await database.execute('''CREATE TABLE Peoples(
          id INTEGER PRIMARY KEY, 
          nameuser TEXT,  
          country TEXT, 
          state TEXT, 
          gener TEXT )''');
    print("Table Peoples Create");
  }

  //////////////////////////////Funciones destinadas para CRUD de Personas////////////////////////////////

  Future<List<Peoples>> getAllPeoples() async {
    final dbClient = await db;
    var res = await dbClient.query("Peoples");
    List<Peoples> list = res.map((c) => Peoples.map(c)).toList();
    return list;
  }

  Future<Peoples> getPeopleWithName(String nameuser) async {
    final dbClient = await db;
    var res = await dbClient.query("Peoples",
        where: "nameuser = ?",
        whereArgs: [nameuser],
        orderBy: "nameuser ASC COLLATE NOCASE",
        limit: 1);
    return res.isNotEmpty ? Peoples.map(res.first) : Null;
  }

  Future<List<Peoples>> getPeopleWithCounty(String country) async {
    final dbClient = await db;
    var res = await dbClient.query("Peoples",
        where: "country = ?",
        whereArgs: [country],
        orderBy: "country ASC COLLATE NOCASE",
        limit: 1);
    return res.isNotEmpty ? Peoples.map(res.first) : Null;
  }

  Future<List<Peoples>> getPeopleWithState(String state) async {
    final dbClient = await db;
    var res = await dbClient.query("Peoples",
        where: "state = ?",
        whereArgs: [state],
        orderBy: "state ASC COLLATE NOCASE ",
        limit: 1);
    return res.isNotEmpty ? Peoples.map(res.first) : Null;
  }

  addPeopleToDatabase(Peoples peoples) async {
    final dbClient = await db;
    var table = await dbClient.rawQuery("SELECT MAX(id)+1 as id FROM Peoples");
    int id = table.first["id"];
    peoples.id = id;
    var raw = await dbClient.insert(
      "Peoples",
      peoples.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  deletePeopleWithId(int id) async {
    final dbClient = await db;
    return dbClient.delete("Peoples", where: "id = ?", whereArgs: [id]);
  }

  updatePeople(Peoples peoples) async {
    final dbClient = await db;
    var res = await dbClient.update("Peoples", peoples.toMap(),
        where: "id = ?", whereArgs: [peoples.id]);
    return res;
  }

  //////////////////////////Funciones destindas a los login de usurio////////////////////////////////

  //insertion
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    print(user.username);
    int res = await dbClient.insert("User", user.toMap());
    List<Map> list = await dbClient.rawQuery('''SELECT * FROM User''');
    print(list);
    return res;
  }

  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.delete("User");
    return res;
  }

  Future<User> selectUser(User user) async {
    print("Select User");
    print(user.username);
    print(user.password);
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableUser,
        columns: [columnUserName, columnPassword],
        where: "$columnUserName = ? and $columnPassword = ?",
        whereArgs: [user.username, user.password]);
    print(maps);
    if (maps.length > 0) {
      print("User Exist !!!");
      return user;
    } else {
      return null;
    }
  }
}

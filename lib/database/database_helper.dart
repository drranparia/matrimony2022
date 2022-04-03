import 'package:matrimony2022/model/model.dart';
import 'package:matrimony2022/model/user_model.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

abstract class DataBaseHelper {
  static Database? database;

  static int get _version => 1;

  static Future init() async {
    if (database != null) {
      return;
    }

    try {
      var databasePath = await getDatabasesPath();
      String _path = p.join(databasePath, 'Matrimony-2022.db');
      database = await openDatabase(_path,
          version: _version, onCreate: _onCreate, onUpgrade: _onUpgrade);
    } catch (ex) {
      print(ex);
    }
  }

  static Future _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final intType = 'INTEGER NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final textTypeN = 'TEXT';

    // await db.execute(
    //   "CREATE TABLE $countryTable (${UserFields.CountryId} "
    //   "$idType,"
    //   "${UserFields.CountryName} $textType);",
    // );
    //
    // await db.execute(
    //   "CREATE TABLE $stateTable (${UserFields.StateId} "
    //   "$idType,"
    //   "${UserFields.StateName} $textType,${UserFields.CountryId} "
    //   "$intType,FOREIGN KEY(${UserFields.CountryId})REFERENCES "
    //   "$countryTable(${UserFields.CountryId}));",
    // );
    //
    // await db.execute(
    //   "CREATE TABLE $cityTable (${UserFields.CityId} "
    //   "$idType,"
    //   "${UserFields.CityName} $textType,${UserFields.StateId} "
    //   "$intType,FOREIGN KEY(${UserFields.StateId})REFERENCES "
    //   "$stateTable(${UserFields.StateId}));",
    // );

    await db.execute(
      "CREATE TABLE $userTable (${UserFields.id} $idType,"
      "${UserFields.UserName} $textType,${UserFields.DOB} $textType,"
      "${UserFields.Age} $intType,${UserFields.Gender} $intType,"
      "${UserFields.MobileNumber} $textTypeN,${UserFields.Email} $textTypeN,"
      "${UserFields.IsFavorite} $intType,${UserFields.CountryName} $textType,"
      "${UserFields.StateName} $textType,${UserFields.CityName} $textType);",
    );
  }

  static Future _onUpgrade(Database db, int oldVersion, int version) async {
    if (oldVersion > version) {
      //
    }
  }

  static Future<List<Map<String, dynamic>>> details(String userTable) async {
    return database!.query(userTable);
  }

  static Future<int> insert(String userTable, Model model) async {
    return await database!.insert(userTable, model.toJson());
  }

  static Future<int> update(String userTable, Model model) async {
    return await database!.update(userTable, model.toJson(),
        where: 'id=?', whereArgs: [model.id]);
  }

  static Future<int> delete(String userTable, Model model) async {
    return await database!
        .delete(userTable, where: 'id=?', whereArgs: [model.id]);
  }

  static Future<List<Map<String, dynamic>>> query(String a) async {
    String search = '\'%' + a + '%\'';
    return database!.rawQuery(
        // 'SELECT * FROM userTable where UserName || CityName LIKE $search');
        'SELECT * FROM userTable where UserName LIKE $search');
  }

  static Future<List<Map<String, dynamic>>> getFav() async {
    return database!.rawQuery("SELECT * from userTable where IsFavorite = 1");
  }

  static Future<int> setFav(int n, int id) async {
    return await database!
        .rawUpdate("UPDATE userTable SET IsFavorite = $n WHERE id= $id");
  }
}

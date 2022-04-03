import 'package:matrimony2022/database/database_helper.dart';
import 'package:matrimony2022/model/user_model.dart';

class DBService {
  Future<List<User>> getUser() async {
    await DataBaseHelper.init();

    List<Map<String, dynamic>> user = await DataBaseHelper.details(userTable);

    return user.map((item) => User.fromMap(item)).toList();
  }

  Future<bool> addUser(User meta) async {
    await DataBaseHelper.init();
    bool isSaved = false;
    int ret = await DataBaseHelper.insert(userTable, meta);
    return ret > 0 ? true : false;
  }

  Future<bool> updateUser(User meta) async {
    await DataBaseHelper.init();
    bool isSaved = false;
    int ret = await DataBaseHelper.update(userTable, meta);
    return ret > 0 ? true : false;
  }

  Future<bool> deleteUser(User meta) async {
    await DataBaseHelper.init();
    bool isSaved = false;
    int ret = await DataBaseHelper.delete(userTable, meta);
    return ret > 0 ? true : false;
  }

  Future<List<User>> getSearch(String a) async {
    await DataBaseHelper.init();

    List<Map<String, dynamic>> user = await DataBaseHelper.query(a);

    return user.map((item) => User.fromMap(item)).toList();
  }

  Future<List<User>> getFav() async {
    await DataBaseHelper.init();

    List<Map<String, dynamic>> user = await DataBaseHelper.getFav();

    return user.map((item) => User.fromMap(item)).toList();
  }

  Future<bool> setFav(int n, int id) async {
    await DataBaseHelper.init();

    int ret = await DataBaseHelper.setFav(n, id);
    return ret > 0 ? true : false;
  }
}

import 'package:casadealerapp/modal_class/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void createUserSHP(
//     String username,
//     String password,
//     ) async {
//   SharedPreferences _sharedpreferences = await SharedPreferences.getInstance();
//   _sharedpreferences.setString('username', username);
//   _sharedpreferences.setString('password', password);
// }
//
// Future<String?> getusername() async {
//   SharedPreferences _sharedpreferences = await SharedPreferences.getInstance();
//   return _sharedpreferences.getString('username');
// }
//
// Future<String?> getuserpwd() async {
//   SharedPreferences _sharedpreferences = await SharedPreferences.getInstance();
//   return _sharedpreferences.getString('password');
// }
//
// Future<String?> setusedid(String uid) async {
//   SharedPreferences _sharedpreferences = await SharedPreferences.getInstance();
//   _sharedpreferences.setString('dId', uid);
// }
//
// Future<String?> getuid() async {
//   SharedPreferences _sharedpreferences = await SharedPreferences.getInstance();
//   return _sharedpreferences.getString('dId');
// }
//
// void islogin(bool value) async {
//   SharedPreferences _sharedpreferences = await SharedPreferences.getInstance();
//   _sharedpreferences.setBool('loginstatus', value);
// }
//
// Future<bool?> getisloginSHP() async {
//   SharedPreferences _sharedpreferences = await SharedPreferences.getInstance();
//   return _sharedpreferences.getBool('loginstatus');
// }
//
// void cleanSHP() async {
//   SharedPreferences _sharedpreferences = await SharedPreferences.getInstance();
//   _sharedpreferences.clear();
// }
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SaveDataLocal {
  static SharedPreferences? prefs;
  static String userData = 'UserData';
  static String calenderEventData = 'CalenderEvent';
  static saveLogInData(usermodal userModel) async {
    prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(userModel.toJson());
    await prefs?.setString(userData, json);
  }

  static getDataFromLocal() async {
    prefs = await SharedPreferences.getInstance();

    String? userString = prefs?.getString(userData);
    if (userString != null) {
      Map userMap = jsonDecode(userString);
      usermodal user = usermodal.fromJson(userMap);
      return user;
    } else {
      return null;
    }
  }

  static clearUserData() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.clear();
  }
}

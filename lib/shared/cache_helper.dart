import 'package:shared_preferences/shared_preferences.dart';

import 'enum.dart';
class CacheHelper{
  static SharedPreferences? sharedPreferences;
  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static putString({required SharedKey key, required String value}){
    sharedPreferences?.setString(key.name, value);
  }
  static getString({required SharedKey key}){
    return sharedPreferences?.getString(key.name) ?? ' ';
  }
  static putInt({required SharedKey key, required int value}){
    sharedPreferences?.setInt(key.name, value);
  }
  static getInt({required SharedKey key}){
    return sharedPreferences?.getInt(key.name) ?? 0;
  }
  static putBool({required SharedKey key, required bool value}){
    sharedPreferences?.setBool(key.name, value);
  }
  static getBool({required SharedKey key}){
    return sharedPreferences?.getBool(key.name) ?? false;
  }
  static putDouble({required SharedKey key, required double value}){
    sharedPreferences?.setDouble(key.name, value);
  }
  static getDouble({required SharedKey key}){
    return sharedPreferences?.getDouble(key.name) ?? 0.0;
  }
  static remove(){
    sharedPreferences?.clear();
  }
  static delete({key}){
    sharedPreferences?.remove(key);
  }

}
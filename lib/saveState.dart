import 'package:shared_preferences/shared_preferences.dart';

class SaveState {
  static SharedPreferences? _pref;

  static Future initialize() async =>
      _pref = await SharedPreferences.getInstance();

  static int? getValue({required String key}) {
    return _pref!.getInt(key);
  }

  static Future save({required String key, required int value}) async {
    int? currentValue = getValue(key: key);
    if(currentValue!=null){
      await _pref!.setInt(key, currentValue + value);
    }else{
      await _pref!.setInt(key,  value);
    }
    
  }
}

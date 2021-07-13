import 'package:shared_preferences/shared_preferences.dart';

class SaveInformation {
  static SharedPreferences _preferences =
      SharedPreferences.getInstance() as SharedPreferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static String? getInfoFromSharedPref() {
    final start = _preferences.getString("key");
    return start;
  }

  static void setInfoFromSharedPref(String info) async {
    await _preferences.setString("key", info);
  }
}

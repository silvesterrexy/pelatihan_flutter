// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class SF {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future addString(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, value);
  }

  Future addInt(String key, int value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  Future<String?> getStringValue(String key) async {
    final SharedPreferences prefs = await _prefs;
    final String? stringValue = prefs.getString(key);
    return stringValue;
  }

  Future getStringValue2(String key) async {
    final SharedPreferences prefs = await _prefs;
    final String? stringValue = prefs.getString(key);
    return stringValue;
  }

  Future addListString(String key, List<String> value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList(
      key,
      value,
      // <String>[
      //   "Pinjaman",
      //   "Simpanan",
      //   "Layanan",
      //   "Keanggotaan",
      //   "Solidaritas",
      //   "Tempat Pelayanan",
      //   "Balas Jasa",
      // ],
    );
  }

  Future<List<String>?> getListStringValue(String key) async {
    final SharedPreferences prefs = await _prefs;
    final List<String>? items = prefs.getStringList(key);
    return items;
  }

  Future<bool> getAvailableValue(String key) async {
    final SharedPreferences prefs = await _prefs;
    bool checkvalue = prefs.containsKey(key);
    return checkvalue;
  }

  Future clearAllData(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }
}

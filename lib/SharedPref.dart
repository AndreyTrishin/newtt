import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  setCurrentWindow(currentWindow) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('currentWindow', currentWindow);
  }

  Future<String> loadWindow() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentWindow');
  }
}
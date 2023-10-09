import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeMode dark = ThemeMode.dark;
ThemeMode light = ThemeMode.light;

class Cachehelper {
  static late SharedPreferences preferences;
  static init() async {
    preferences = await SharedPreferences.getInstance();
  }
}

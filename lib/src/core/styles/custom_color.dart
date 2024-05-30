import 'package:bird_guard/src/viewmodel/system_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomColor {
  static bool isLightMode = true;

  static void switchTheme(bool input) {
    isLightMode = input;
    surfaceContainerHighest = (isLightMode) ? Color(0xffe3e2e9) : Color(0xff33343a);
    surfaceContainerLow = (isLightMode) ? Color(0xfff4f3fa) : Color(0xff1a1b21);
    historyItemColor = (isLightMode) ? Colors.white : Color(0xff1a1b21);
    surfaceContainer = (isLightMode) ? Color(0xffeeedf4) : Color(0xff1e1f25);
  }
  static Color surfaceContainer = Color(0xffeeedf4);
  static Color surfaceContainerLow = Color(0xfff4f3fa);
  static Color historyItemColor = Colors.white;
  static Color neutralTextColor = Color(0xff525257);
  static Color surfaceContainerHighest = Color(0xffe3e2e9);

}
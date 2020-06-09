
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';


bool useWhiteStatusBarForeground;
bool useWhiteNavigationBarForeground;

changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color);
    if (useWhiteForeground(color)) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      useWhiteStatusBarForeground = true;
      useWhiteNavigationBarForeground = true;
    } else {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
      FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      useWhiteStatusBarForeground = false;
      useWhiteNavigationBarForeground = false;
    }
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}

changeNavigationColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setNavigationBarColor(color);
  } on PlatformException catch (e) {
    debugPrint(e.toString());
  }
}


setNavColor(Color color)async{
  await    FlutterStatusbarcolor.setStatusBarColor(color);
  if (useWhiteForeground(color)) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  } else {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }
}

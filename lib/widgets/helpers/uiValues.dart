import 'package:flutter/material.dart';

Size gScreenSize;

Color accentThemeColor=Colors.lightBlueAccent;
Color accentThemeTextColor=Colors.white;

class startTopFloatFabLocation extends FloatingActionButtonLocation {
  const startTopFloatFabLocation({this.screenSize});

  final Size screenSize;
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double fabX;

    double fabY;

    fabY = screenSize.width * 0.08;
    fabX = screenSize.width * 0.03;
    return new Offset(fabX, fabY);
  }
}

class endBottomFloatFabLocation extends FloatingActionButtonLocation {
  const endBottomFloatFabLocation({this.screenSize});

  final Size screenSize;
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    double fabX;

    double fabY;

    fabY = screenSize.height * 0.88;
    fabX = screenSize.width * 0.78;
    return new Offset(fabX, fabY);
  }
}

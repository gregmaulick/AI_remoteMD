import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../models/camera.dart';
import 'cameraPage.dart';

Future<List<CameraDescription>> getAllAvailableCameras() async {
  try {
    return await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  return List();
}

class CameraApp extends StatefulWidget {
  const CameraApp({Key key}) : super(key: key);

  @override
  _CameraAppState createState() {
    return _CameraAppState();
  }
}

class _CameraAppState extends State<CameraApp> {
  Future<List<CameraDescription>> initCameraFuture;

  @override
  void initState() {
    super.initState();
    initCameraFuture = getAllAvailableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: initCameraFuture,
        builder: (BuildContext context,
            AsyncSnapshot<List<CameraDescription>> snapshot) {
          if (snapshot.data != null && snapshot.data.isNotEmpty) {
            gCamData.availableCameras = snapshot.data;
            return CameraPage(availablecameras: snapshot.data);
          } else {
            print("snapshot data insufficient");
            return new Scaffold(
              appBar: AppBar(),
              body: Container(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator()),
            );
          }
        });
  }
}

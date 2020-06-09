import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../widgets/helpers/statusBarStyle.dart';
import '../widgets/helpers/uiValues.dart';
import '../widgets/ui_elements/sideDrawerMenu.dart';
import 'imageTaken.dart';
import '../models/camera.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key key, this.availablecameras}) : super(key: key);

  final List<CameraDescription> availablecameras;

  @override
  _CameraPageState createState() {
    return _CameraPageState();
  }
}

Future<Directory> getDirAsync() async {
  final Directory extDir = await getApplicationDocumentsDirectory();
  final String dirPath = '${extDir.path}/Pictures/';
  gCamData.localImagePath = dirPath;
  return await Directory(dirPath).create(recursive: true);
}

class _CameraPageState extends State<CameraPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  CameraController controller;
  String imagePath;
  String localDirPath;
  Future<CameraController> initCameraController;
  bool photoPress;
  Size screenSize;

  /// initialize the camera controller before the page loads
  @override
  void initState() {
    super.initState();
    photoPress = false;
    if (gCamData.localImagePath == null) {
      getDirAsync().then((res) {
        localDirPath = res.path;
        gCamData.localImagePath = res.path;
      });
    } else {
      localDirPath = gCamData.localImagePath;
    }

    initCameraController = selectCamRetController(widget.availablecameras);
  }

  Future<CameraController> selectCamRetController(availcams) async {
    return await getCamera(widget.availablecameras);
  }

  toggleDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    changeStatusColor(Colors.lightBlue[200]);

    screenSize = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return FutureBuilder(
        future: initCameraController,
        builder:
            (BuildContext context, AsyncSnapshot<CameraController> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.active:
              return Container();
            case ConnectionState.waiting:
              return Container();
            case ConnectionState.done:
              return new Scaffold(
                key: _scaffoldKey,
                drawer: stSideDrawerMenu(context, screenSize),
                floatingActionButton: FloatingActionButton(
                  onPressed: toggleDrawer,
                  child: Icon(Icons.dehaze),
                ),
                floatingActionButtonLocation:
                    startTopFloatFabLocation(screenSize: screenSize),
                body: new SafeArea(
                    top: true,
                    bottom: true,
                    child: Stack(children: [
                      Column(
                        children: <Widget>[
                          new Expanded(
                            child: new Container(
                              decoration: new BoxDecoration(
                                color: Colors.black,
                                border: new Border.all(
                                  color: Colors.grey,
                                  width: 3.0,
                                ),
                              ),
                              child: new Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: new Center(
                                  child: _cameraPreviewWidget(snapshot.data),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Opacity(
                              opacity: 0.0,
                              child: Container(
                                width: screenSize.width,
                              )),
                          _captureControlRowWidget(snapshot.data),
                          Container(
                            height: screenSize.width * .03,
                          )
                        ],
                      )
                    ])),
              );
          }
        });
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget(cameraController) {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return new Text("Camera Unavailable");
    } else {
      return Container(
          height: screenSize.height,
          child: AspectRatio(
            aspectRatio: cameraController.value.aspectRatio,
            child: new CameraPreview(cameraController),
          ));
    }
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget(cameraController) {
    return
//      photoPress==false?
        GestureDetector(
            onTap: () {
              onTakePictureButtonPressed();
            },
            child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5.0)),
                width: screenSize.width * .24,
                height: screenSize.width * .24,
              ),
              Opacity(
                opacity: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue, width: 3.0)),
                  width: screenSize.width * .22,
                  height: screenSize.width * .22,
                ),
              )
            ]));
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<CameraController> getCamera(List cameras) async {
    if (controller != null) {
      await controller.dispose();
    }

    for (CameraDescription cameraDescription in cameras) {
      print(cameraDescription.lensDirection);
      if (cameraDescription.lensDirection == CameraLensDirection.back) {
        controller =
            new CameraController(cameraDescription, ResolutionPreset.medium);

//         If the controller is updated then update the UI.
        controller.addListener(() {
          if (mounted) setState(() {});
          if (controller.value.hasError) {
            showInSnackBar('Camera error ${controller.value.errorDescription}');
          }
        });

        try {
          await controller.initialize();
        } on CameraException catch (e) {
          _logCameraException(e);
        }
        if (mounted) {
          setState(() {});
        }
        return controller;
      } else {
        return null;
      }
    }
    return null;
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ImageTaken(
                  imagePath: imagePath,
                ),
          ),
        );
      }
    });
  }

  Future<String> takePicture() async {
    //INFO ON FILENAME FOR IMAGE STARTS HERE
    ///save the image to a file in jpg format using the time as the filename
    String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

    String getImagePath(dir) {
      imagePath = '$dir/${timestamp()}.jpg';
      return imagePath;
    }

    String filePath = getImagePath(localDirPath);

    if (controller.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _logCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<List<int>> nativeCompressAndGetImageBytes(File file) async {
    var result = await FlutterImageCompress.compressWithFile(
      file.absolute.path,
//    targetPath,
      quality: 50,
    );
    return result;
  }

  saveImageRequest(postdata) async {
    //TODO add url to save to
    String posturl;

    Map headerMap = {
      "ACCEPT": "text/html,application/json",
      "ACCEPT_ENCODING": "gzip,deflate,br",
      "CONNECTION": "keep-alive",
      "ACCEPT_LANGUAGE": "en-US,en",
      "CONTENT_TYPE": "application/x-www-form-urlencoded",
    };

    Map<String, String> data = {"data": postdata};

    http.Response resp =
        await http.post(posturl, headers: headerMap, body: data);
  }

  acceptAndSaveImage(imgpath) async {
    File imgFile = File(imgpath);

    //String docname = a Date Stamp
    //so call with .document(docname)
    //to put all images taken on the day of under that file
    //And, the variable to set the image to should be Image X where X is a number, based on the number of images already in the database
    //Test to confirm connection is being established here:
//    Firestore.instance.collection('AnonymousImages').document('Images').setData({'Testing Connection': 'Connected'});
//    //And then passing in the image Files itself:
//    Firestore.instance.collection('AnonymousImages').document('Images').setData({'Image': imgFile});

    List<int> imgBytesList = await nativeCompressAndGetImageBytes(imgFile);

    Uint8List u8ImgBytes = Uint8List.fromList(imgBytesList);

    String encodedBytes = json.encode(u8ImgBytes);

    var saveResponse = saveImageRequest(u8ImgBytes);
  }
}

void _logCameraException(CameraException e) {
  logError(e.code, e.description);
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

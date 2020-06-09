import 'package:flutter/material.dart';
import 'dart:io';
import '../models/camera.dart';
import '../widgets/helpers/uiValues.dart';
import '../models/user.dart';
import '../models/userSession.dart';
import 'cameraPage.dart';
import 'initialDiagnoses.dart';
import 'patientSelect.dart';
import '../widgets/helpers/uiValues.dart';

import './signuppage1.dart';

class ImageTaken extends StatefulWidget {
  const ImageTaken({this.imagePath});
  final String imagePath;

  @override
  State<StatefulWidget> createState() {
    return _ImageTakenState();
  }
}

class _ImageTakenState extends State<ImageTaken> {
  int _currentIndex = 1;

  //Change how the image is printed out
//  DecorationImage _buildBackgroundImage() {
//    return DecorationImage(
//      fit: BoxFit.contain,
//      colorFilter:
//          ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
//      image: Image.file(File(widget.imagePath
//      )),
//    );
//  }
  _buildBackgroundImage() {
    return Image.file(File(widget.imagePath));
  }

  void onTabTapped(int index) {
    print(index);
    _currentIndex = index;

    //setState(() {
//    _currentIndex = index;
    //if(_currentIndex == 0){
//    Navigator.pushReplacementNamed(context, '/products');
    //Navigator.push(
    //     context,
    //    MaterialPageRoute(
    //       builder: (context) => SignUpPage()
    //  ),
    //);
    // }
    // if(_currentIndex == 1){
    //    Navigator.pushReplacementNamed(context, '/signuppage2');
    // }
    if (_currentIndex == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CameraPage(availablecameras: gCamData.availableCameras)),
      );
    }
    if (_currentIndex == 1) {
      if (gUser.userType == UserType.individual) {
        currentDiagnosesImagePath = widget.imagePath;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => InitialDiagnoses(
                  imagePath: widget.imagePath,
                  patientName: gUser.id,
                ),
          ),
          ModalRoute.withName('/cameraPage'),
        );
      }
      if (gUser.userType == UserType.organization) {
        currentDiagnosesImagePath = widget.imagePath;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PatientSelectPage(goToHistory: false,)),
          ModalRoute.withName('/cameraPage'),
        );
      }
    }

    //});
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Image Taken',
            style: TextStyle(color: accentThemeTextColor),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.all(0.0),
          child: Center(
            child:
                Container(width: targetWidth, child: _buildBackgroundImage()),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: 1, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.loop),
              title: new Text('Retake'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.arrow_forward_ios),
              title: new Text('Diagnose'),
            ),
          ],
        ),
      ),
    );
  }
}

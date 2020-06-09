import 'package:flutter/material.dart';
import './signuppage1.dart';
import 'cameraPage.dart';
import 'diagnosesPage.dart';
import '../models/userSession.dart';
import '../models/camera.dart';
import 'dart:io';
import '../models/user.dart';
import '../widgets/helpers/uiValues.dart';
import '../widgets/ui_elements/sideDrawerMenu.dart';

class InitialDiagnoses extends StatefulWidget {
  const InitialDiagnoses({this.imagePath, this.patientName});
  final String imagePath;
  final String patientName;
  @override
  State<StatefulWidget> createState() {
    return _InitialDiagnosesState();
  }
}

class _InitialDiagnosesState extends State<InitialDiagnoses> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Change how the image is printed out
//  DecorationImage _buildBackgroundImage() {
//    return DecorationImage(
//      fit: BoxFit.contain,
//      colorFilter:
//      ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
//      image: AssetImage('assets/background.jpg'),
//    );
//  }
  _buildBackgroundImage() {
    return Image.file(File(widget.imagePath));
  }

  saveDiagnoses() {
    if (savedPatientDiagnoses[widget.patientName] == null) {
      savedPatientDiagnoses[widget.patientName] = [];
    }
    savedPatientDiagnoses[widget.patientName].add(currentDiagnosesImagePath);
  }

  void onTabTapped(int index) {
    print(index);
    int tabIndex = index;

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
    //});
    saveDiagnoses();

    if (tabIndex == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CameraPage(availablecameras: gCamData.availableCameras)),
      );
    }
    if (tabIndex == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => DiagnosesPage(
                  patientName: widget.patientName,
                )),
      );
    }
  }

  diagStatusResults(diagStatus, Size screensize) {
    if (diagStatus == "malignant") {
      return ClipRRect(
          borderRadius: new BorderRadius.circular(
            screensize.width * .05,
          ),
          child: Container(
            color: Colors.red,
            height: screensize.height * .06,
            child: Center(
              child: Text("Malignant"),
            ),
          ));
    }
    if (diagStatus == "benign") {
      return ClipRRect(
          borderRadius: new BorderRadius.circular(
            screensize.width * .05,
          ),
          child: Container(
            color: Colors.green,
            height: screensize.height * .06,
            width: screensize.width * .5,
            child: Center(
              child: Text(
                "Benign",
                style: TextStyle(color: accentThemeTextColor),
              ),
            ),
          ));
    }
  }

  String diagStatus = "benign";

  toggleDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final double deviceWidth = screenSize.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Diagnoses',style: TextStyle(color: accentThemeTextColor),),
          leading:IconButton(
              icon: Icon(
                Icons.dehaze,
                color: accentThemeTextColor,
              ),
              onPressed: () {
                toggleDrawer();
              }) ,
        ),

        drawer: stSideDrawerMenu(context, screenSize),
        body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            padding: EdgeInsets.all(0.0),
            child: Container(
              height: screenSize.height * .95,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: screenSize.height * .4,
                      width: screenSize.width,
                      child: _buildBackgroundImage(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: screenSize.width * .05),
                      child: diagStatusResults(diagStatus, screenSize),
                    )
                  ]),
            )),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: 1, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.loop),
              title: new Text('Take Another'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.arrow_forward_ios),
              title: new Text('History'),
            ),
          ],
        ),
      ),
    );
  }
}

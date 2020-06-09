import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'largeImagePage.dart';
import '../widgets/helpers/uiValues.dart';
import '../widgets/ui_elements/sideDrawerMenu.dart';
import '../models/user.dart';
import '../models/userSession.dart';

class DiagnosesPage extends StatefulWidget {
  const DiagnosesPage({Key key, this.patientName}) : super(key: key);

  final String patientName;

  @override
  _DiagnosesPageState createState() => _DiagnosesPageState();
}

class _DiagnosesPageState extends State<DiagnosesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  toggleDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double ssWidth = screenSize.width;
    double ssHeight = screenSize.height;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("${widget.patientName}'s History", style: TextStyle(color: accentThemeTextColor),),

        leading: IconButton(
            icon: Icon(
              Icons.dehaze,
              color: accentThemeTextColor,
            ),
            onPressed: () {
              toggleDrawer();
            }),
        ),

        drawer: stSideDrawerMenu(context, screenSize),
        body: ListView(
          children: <Widget>[
            Container(
                width: screenSize.width,
                child: Column(
                  children: <Widget>[
//                    Container(
//                      padding: EdgeInsets.only(
//                          left: ssWidth * .08, right: ssWidth * .08),
//                      decoration: BoxDecoration(color: Colors.grey[200]),
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.end,
//                          children: [
//                            Container(
//                                padding: EdgeInsets.only(
//                                    top: ssWidth * .05, bottom: ssWidth * .02),
//                                width: screenSize.width * .7,
//                                child: Text(
//                                  "  ${widget.patientName}'s History",
//                                  softWrap: true,
//                                  style: TextStyle(
//                                      fontSize: screenSize.width * .05,
//                                      fontWeight: FontWeight.w600),
//                                ))
//                          ]),
//                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: ssWidth * .02, right: ssWidth * .02),
                        child: savedPatientDiagnoses[widget.patientName] == null
                            ? Container(
                                height: ssHeight * .9,
                                child: Center(
                                    child: Container(
                                        height: ssHeight * .2,
                                        child: Column(
                                          children: <Widget>[
                                            Icon(Icons.history, color: Colors.blue,),
                                            Text("No past diagnoses to show")
                                          ],
                                        ))))
                            : Column(
                                children: buildThumnailRows(
                                    savedPatientDiagnoses[widget.patientName])))
                  ],
                )),
          ],
        ));
  }
}

class DiagnosesThumbnail extends StatelessWidget {
  DiagnosesThumbnail({Key key, this.imgpath, this.diagnosesStatus})
      : super(key: key);

  final String imgpath;
  final String diagnosesStatus;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    File imgFile = File("$imgpath");

    Widget goodDiagRow = Container(
        decoration: BoxDecoration(color: Colors.lightBlue[100]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.check,
              size: screenSize.width * .08,
              color: Colors.green,
            ),
            Text("🙂", style: TextStyle(fontSize: screenSize.width * .08))
          ],
        ));

    Widget badDiagRow = Container(
        decoration: BoxDecoration(color: Colors.blueGrey[200]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.flag,
              size: screenSize.width * .08,
              color: Colors.red,
            ),
            Text(
              "😟 ",
              style: TextStyle(fontSize: screenSize.width * .08),
            )
          ],
        ));

    Widget returnDiagRow;
    if (diagnosesStatus == "good") {
      returnDiagRow = goodDiagRow;
    }
    if (diagnosesStatus == "bad") {
      returnDiagRow = badDiagRow;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LargeImagePage(imgpath: imgpath)),
        );
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(
            screenSize.width * .05,
            screenSize.width * .02,
            screenSize.width * .05,
            screenSize.width * .02),
        width: screenSize.width * .48,
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2.0)),
                child: Image.file(imgFile)),
            returnDiagRow
          ],
        ),
      ),
    );
  }
}

//TODO the status will be populated from a data structure returned from server, right now just list of images
remainderRow(imgpath) {
  return Row(
    children: <Widget>[
      DiagnosesThumbnail(
        imgpath: imgpath,
        diagnosesStatus: "good",
      )
    ],
  );
}

doubleRow(img1, img2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      DiagnosesThumbnail(
        imgpath: img1,
        diagnosesStatus: "good",
      ),
      DiagnosesThumbnail(
        imgpath: img2,
        diagnosesStatus: "bad",
      )
    ],
  );
}

buildThumnailRows(List diagMap) {
  List<Widget> returnRowList = [];

//  List<String> imagesLeft = glob.savedImages;
  List<String> imagesLeft = diagMap;

//  int diagnosesCount = glob.savedImages.length;
  int diagnosesCount = diagMap.length;
  int countRemainder = diagnosesCount % 2;

  if (countRemainder == 1) {
    if (diagnosesCount == 1) {
      returnRowList.add(remainderRow(diagMap[0]));
      return returnRowList;
    }
  }

  var rowIndex = 2;

  while (rowIndex <= diagnosesCount) {
    returnRowList
        .add(doubleRow(imagesLeft[rowIndex - 2], imagesLeft[rowIndex - 1]));
    rowIndex = rowIndex + 2;
  }

  if (countRemainder == 1) {
    returnRowList.add(remainderRow(imagesLeft.last));
  }

  return returnRowList;
}

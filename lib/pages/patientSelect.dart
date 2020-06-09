import 'package:flutter/material.dart';
import '../models/userSession.dart';
import '../widgets/helpers/uiValues.dart';
import 'initialDiagnoses.dart';
import 'patientAdd.dart';
import 'diagnosesPage.dart';
import '../widgets/ui_elements/sideDrawerMenu.dart';

class PatientSelectPage extends StatefulWidget {
  const PatientSelectPage({Key key, this.goToHistory}) : super(key: key);
  final bool goToHistory;

  @override
  _PatientSelectPageState createState() => _PatientSelectPageState();
}

class _PatientSelectPageState extends State<PatientSelectPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  toggleDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  buildPatientNamesList(Size screensize) {
    List sortedPatientList = patientList..sort();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: patientList.length,
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0))),
            child: ListTile(
                onTap: () {
                  if (widget.goToHistory == true) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiagnosesPage(
                              patientName: sortedPatientList[index])),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InitialDiagnoses(
                                imagePath: currentDiagnosesImagePath,
                                patientName: sortedPatientList[index],
                              )),
                    );
                  }
                },
                leading: Icon(
                  Icons.person_pin,
                  color: Colors.lightBlue,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${sortedPatientList[index]}'),
                    Container(width: screensize.width*.15,)
                  ],
                )));
      },
    );
  }

  addPatient() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PatientAddPage(goToHistory: widget.goToHistory,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      key:_scaffoldKey,
      drawer: stSideDrawerMenu(context, screenSize),
      appBar: AppBar(
        title: Text(
          "Select Patient",
          style: TextStyle(color: accentThemeTextColor),
        ),
        iconTheme: IconThemeData(
          color: accentThemeTextColor, //change your color here
        ),
        leading: IconButton(
            icon: Icon(
              Icons.dehaze,
              color: accentThemeTextColor,
            ),
            onPressed: () {
              toggleDrawer();
            }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addPatient();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      floatingActionButtonLocation: endBottomFloatFabLocation(screenSize: screenSize),
      body: patientList.isEmpty
          ? Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  Icon(Icons.person, color: Colors.lightBlueAccent),
                  Text("No Patients Yet")
                ]))
          : Column(mainAxisSize: MainAxisSize.max, children: [
              buildPatientNamesList(screenSize),
            ]),
    );
  }
}

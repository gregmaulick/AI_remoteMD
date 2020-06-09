import 'package:flutter/material.dart';
import '../models/userSession.dart';
import 'patientSelect.dart';
import '../widgets/helpers/uiValues.dart';
import 'initialDiagnoses.dart';
import '../models/userSession.dart';

class PatientAddPage extends StatefulWidget {
  const PatientAddPage({Key key, this.selectedPatient, this.goToHistory}) : super(key: key);

  final String selectedPatient;
  final bool goToHistory;

  @override
  _PatientAddPageState createState() => _PatientAddPageState();
}

class _PatientAddPageState extends State<PatientAddPage> {
  TextEditingController _tCtrl = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Patients",
              style: TextStyle(color: accentThemeTextColor)),
          iconTheme: IconThemeData(
            color: accentThemeTextColor, //change your color here
          ),
        ),
        body: GestureDetector(
          onTap: () {
            print("stuff");
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
              height: screenSize.height,
              child: Center(
                  child: Container(
                width: screenSize.width * .9,
                height: screenSize.height*.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[TextField(
                  focusNode: textFocusNode,
                  controller: _tCtrl,
                  decoration: InputDecoration(hintText: "New Patient Name"),
                ),
                  Padding(
                    padding: EdgeInsets.only(top:screenSize.width*.3),
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: (){
                        patientList.add(_tCtrl.text);

                        if (widget.goToHistory == false){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InitialDiagnoses(
                                  imagePath: currentDiagnosesImagePath,
                                  patientName: _tCtrl.text,
                                )),
                          );
                        }
                        else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PatientSelectPage(goToHistory: true,)),
                          );
                        }
                      },
                    child: Text("Submit",style: TextStyle(color: accentThemeTextColor),),
                    ),
                  )

    ],
              ))),
        )));
  }
}

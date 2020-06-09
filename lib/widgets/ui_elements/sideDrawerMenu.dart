 import 'package:flutter/material.dart';
 import '../../models/camera.dart';
 import '../../models/userSession.dart';
 import '../../pages/cameraPage.dart';
 import '../../pages/infoPage.dart';
 import '../../pages/diagnosesPage.dart';
 import '../../pages/patientSelect.dart';
 import '../../pages/homePage.dart';
 import '../../pages/auth.dart';

 import '../../models/user.dart';
 import '../helpers/uiValues.dart';

 List menuValues = [
   'ProfileOption',
   'DiagnoserOption',
   'HistoryOption',
   'InfoOption',
   "LogoutOption"
 ];
 List menuIcons = [
   Icons.person_outline,
   Icons.assignment_turned_in,
   Icons.history,
   Icons.info_outline,
   Icons.lock_outline
 ];
 List menuLabels = [
   "Your Profile",
   "Diagnoser",
   "History",
   "Info",
   "Log out"
 ];

 sideDrawerSelect(menuVal, context) {
   if (menuVal == "DiagnoserOption") {
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => CameraPage(availablecameras: gCamData.availableCameras,)),
     );
   }
   if (menuVal == "ProfileOption") {
     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => HomePage()),
     );
   }
   if (menuVal == "HistoryOption") {

     if (gUserType== UserType.organization){
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => PatientSelectPage(goToHistory:true)),
       );

     }else {
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => DiagnosesPage(patientName: gUser.id,)),
       );
     }
   }
   if (menuVal == "LogoutOption"){
     logout();

     Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(builder: (context) => AuthPage()),
             (Route<dynamic> route) => false);
   }
   if (menuVal == "InfoOption"){

     Navigator.pushReplacement(
       context,
       MaterialPageRoute(builder: (context) => InfoPage()),
     );
   }
 }



 SizedBox stSideDrawerMenu(BuildContext context, Size screensize){

   double sidebarItemHeight =
       ((screensize.height / 2) / menuValues.length ) * .9;

   double sideBarWidth = screensize.width*.5;

   return SizedBox(
       width: sideBarWidth,
       child:Drawer(
     child: Container(
         color: Colors.lightBlueAccent,
         child: ListView(
           children: buildDrawerMenuItems(
               context,
               sidebarItemHeight,
               screensize,
               menuValues,
               menuLabels,
               menuIcons),
         )),
   ));}

  List<Widget> buildDrawerMenuItems(BuildContext context, double childHeight, Size screensize,
      List menuValues, List menuLabels, List menuIcons) {
    List<Widget> drawerChildren = [];
    int childIndex = 0;
    menuValues.forEach((val) {
      String menVal = menuValues[childIndex];
      drawerChildren.add(GestureDetector(
          onTap: () {
            print("drawer item pressed");
            sideDrawerSelect(menVal, context);
          },
          child: Container(
              color: Colors.lightBlueAccent,
              height: childHeight,
              width: screensize.width,
//              width: dScreenSize.width * .5,
              child: Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        menuIcons[childIndex],
                        color: Colors.white,
                      ),
                      Text(
                        "${menuLabels[childIndex]}",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )))));
      childIndex += 1;
    });
    return drawerChildren;
  }
import 'package:flutter/material.dart';
import '../widgets/helpers/uiValues.dart';
import '../widgets/ui_elements/sideDrawerMenu.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  toggleDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      drawer: stSideDrawerMenu(context, screenSize),
      appBar: AppBar(
        title: Text(
          "Remote Medical Diagnosis Info",
          style: TextStyle(color: accentThemeTextColor),
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
      body: Center(
        child: Text("Info here ^-^"),
      ),
    );
  }
}

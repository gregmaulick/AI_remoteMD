import 'package:flutter/material.dart';
import '../widgets/ui_elements/sideDrawerMenu.dart';
import '../widgets/helpers/uiValues.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text("Profile", style: TextStyle(color: accentThemeTextColor)),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.dehaze,
              color: accentThemeTextColor,
            ),
            onPressed: () {
              toggleDrawer();
            }),
      ),
      body: Center(child: Icon(Icons.image)),
    );
  }
}

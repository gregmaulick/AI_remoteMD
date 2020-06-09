import 'package:flutter/material.dart';
import '../widgets/helpers/uiValues.dart';

class AccountType extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AccountTypeState();
  }
}

class _AccountTypeState extends State<AccountType> {
  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  void _submitGroupLoginForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    //login(_formData['email'], _formData['password']);
    //print(haveAnAccount);
    //print(_formData);
    //if(haveAnAccount == 1){
    Navigator.pushReplacementNamed(context, '/organizationsignuppage1');
    //}
    //if(haveAnAccount == 0){
    //  Navigator.pushReplacementNamed(context, '/results');
    //}
  }

  void _submitIndividualLoginForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacementNamed(context, '/signuppage1');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          iconTheme: IconThemeData(
            color: accentThemeTextColor, //change your color here
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: targetWidth,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        textColor: Colors.white,
                        child: Text('Group'),
                        //elevation: 4.0,
                        //splashColor: Colors.blueGrey,
                        //highlightElevation: 4.0,
                        onPressed: () => _submitGroupLoginForm(),
                      ),
                      RaisedButton(
                        textColor: Colors.white,
                        child: Text('Individual'),
                        //elevation: 4.0,
                        //splashColor: Colors.blueGrey,
                        //highlightElevation: 4.0,
                        onPressed: () => _submitIndividualLoginForm(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

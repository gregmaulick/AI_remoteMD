import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'cameraMain.dart';
import '../models/user.dart';
import '../models/userSession.dart';
import '../widgets/helpers/uiValues.dart';

class SignUpPage3 extends StatefulWidget {
  final String user;
  const SignUpPage3({Key key, @required this.user}) : super(key: key);

  @override
  _SignUpPage3State createState() => _SignUpPage3State();

  //State<StatefulWidget> createState() {
  //  return _SignUpPage3State();
  //}
}

class _SignUpPage3State extends State<SignUpPage3> {
  final Map<String, dynamic> _formData = {
    'password': null,
    'confirmpassword': null,
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

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty
//            || value.length < 6
            ) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Confirmed Password',
          filled: true,
          fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty
//            || value.length < 6
            ) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['confirmpassword'] = value;
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      print('In fail statement');
      return;
    }
    _formKey.currentState.save();
    //login(_formData['email'], _formData['password']);
    print(_formData);
    //Need a way to specify the user to update the data for
//    Firestore.instance.collection('Users').document(widget.user).updateData(
//      {
//          'Generic_Password': _formData['password'],
//
//      }
//    );

    User setUser = User(
        id: gUser.id,
        email: gUser.email,
        password: _formData["password"],
        userType: UserType.individual);
    gUser = setUser;
    gUserType = UserType.individual;

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => CameraApp(),
        ),
        ModalRoute.withName('/cameraPage'));
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
          title: Text(
            'Sign Up Page 3 of 3',
            style: TextStyle(color: accentThemeTextColor),
          ),
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
                      _buildPasswordTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildConfirmPasswordTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        textColor: Colors.white,
                        child: Text('Create Account'),
                        onPressed: () => _submitForm(),
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

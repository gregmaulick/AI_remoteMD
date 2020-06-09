import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import './signuppage2.dart';
import '../widgets/helpers/uiValues.dart';

//DocumentReference favoritesReference =
//      Firestore.instance.collection('users').document('User 1');

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final Map<String, dynamic> _formData = {
    'f_name': null,
    'l_name': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/food.jpg'),
    );
  }

  Widget _buildFirstNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'First Name', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your name';
        }
      },
      onSaved: (String value) {
        _formData['f_name'] = value;
      },
    );
  }

  Widget _buildLastNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Last Name', filled: true, fillColor: Colors.white),
      //obscureText: true,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your last name';
        }
      },
      onSaved: (String value) {
        _formData['l_name'] = value;
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    //login(_formData['email'], _formData['password']);
    print('Adding First Name and Last Name');
    print(_formData);
    print(_formData['f_name']);
    print(_formData['l_name']);
    //Start a new document in here, and in SignUp2 and SignUp3 perform update on the document
    //So, need to figure out a way to pick what name to pass as a document and how to create that name
    //the name becomes a representation of the user
    //As an idea for, combine the first name and last name
    //final String databaseuserName = _formData['f_name'] + _formData['l_name'];
    final String userName = _formData['f_name'] + ' ' + _formData['l_name'];
    print(userName);
    //Firestore.instance.collection('Users').document(databaseuserName).setData({'First Name': _formData['f_name'], 'Last Name':_formData['l_name']});
    //Firestore.instance.collection('AnonymousImages').document('Images').setData({'Images': Image.file('/Users/julianashihadeh/Desktop/SeniorDesign/New_App/app_sample_with_database_intro/assets/food.jpg')});
    //Navigator.pushReplacementNamed(context, '/signuppage2');

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpPage2(
                user: userName,
              ),
        ));
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
            'Sign Up Page 1 of 3',
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
                      _buildFirstNameTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildLastNameTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        textColor: Colors.white,
                        child: Text('Next'),
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

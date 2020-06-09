import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import './organizationsignuppage2.dart';
import '../widgets/helpers/uiValues.dart';

//DocumentReference favoritesReference =
//      Firestore.instance.collection('users').document('User 1');

class Data {
  String text;
  Data({this.text});
}

class OrganizationSignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrganizationSignUpPageState();
  }
}

class _OrganizationSignUpPageState extends State<OrganizationSignUpPage> {
  final Map<String, dynamic> _formData = {
    'name': null,
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
          labelText: 'Organization Name',
          filled: true,
          fillColor: Colors.white),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your name';
        }
      },
      onSaved: (String value) {
        _formData['name'] = value;
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
    print(_formData['name']);
    //Start a new document in here, and in SignUp2 and SignUp3 perform update on the document
    //So, need to figure out a way to pick what name to pass as a document and how to create that name
    //the name becomes a representation of the user
    //As an idea for, combine the first name and last name
    final String documentName = _formData['name'];
    //Firestore.instance.collection('Organizations').document(documentName).setData({'Organization name': _formData['name']});
    //Firestore.instance.collection('AnonymousImages').document('Images').setData({'Images': Image.file('/Users/julianashihadeh/Desktop/SeniorDesign/New_App/app_sample_with_database_intro/assets/food.jpg')});
    //Navigator.pushReplacementNamed(context, '/organizationsignuppage2');

    final data = Data(
      text: _formData['name'],
    );

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrganizationSignUpPage2(
                user: _formData['name'],
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

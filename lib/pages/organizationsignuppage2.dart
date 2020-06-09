import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import './organizationsignuppage3.dart';
import '../models/user.dart';
import '../widgets/helpers/uiValues.dart';

class OrganizationSignUpPage2 extends StatefulWidget {
  final String user;
  const OrganizationSignUpPage2({Key key, @required this.user})
      : super(key: key);

  @override
  _OrganizationSignUpPage2State createState() =>
      _OrganizationSignUpPage2State();
  // State<StatefulWidget> createState() {
  //   return _OrganizationSignUpPage2State();
  // }
}

class _OrganizationSignUpPage2State extends State<OrganizationSignUpPage2> {
  final Map<String, dynamic> _formData = {
    'city': null,
    'state': null,
    'email': null,
    'phone': null,
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

//Age
  Widget _buildAgeTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'City', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your city';
        }
      },
      onSaved: (String value) {
        _formData['city'] = value;
      },
    );
  }

//Gender -- change this to be a drop down
  Widget _buildSexTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'State', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your state';
        }
      },
      onSaved: (String value) {
        _formData['state'] = value;
      },
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty
//            ||
//            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//                .hasMatch(value)
            ) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

//Phone Number
  Widget _buildPhoneNumberTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Phone Number', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your phone number';
        }
      },
      onSaved: (String value) {
        _formData['phonenumber'] = value;
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    print('The value passed into this file:');
    print(widget.user);

    //login(_formData['email'], _formData['password']);
    print(_formData);
    //Need a way to specify the user to update the data for
    //pass name of user to be doc name
    /*Firestore.instance.collection('Organizations').document(widget.user).updateData(
        {
          'City': _formData['city'], 
          'State': _formData['state'],
          'E-Mail': _formData['email'],
          'Phone Number': _formData['phonenumber']
        }
    ); */

    //Navigator.pushReplacementNamed(context, '/organizationsignuppage3');

    gUser = User(
        id: widget.user,
        email: _formData["email"],
        password: "",
        userType: UserType.organization);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrganizationSignUpPage3(
                user: widget.user,
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
            'Sign Up Page 2 of 3',
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
                      _buildAgeTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildSexTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildEmailTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildPhoneNumberTextField(),
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

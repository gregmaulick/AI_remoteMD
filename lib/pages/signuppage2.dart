import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import './signuppage3.dart';
import '../models/user.dart';
import '../widgets/helpers/uiValues.dart';

class SignUpPage2 extends StatefulWidget {
  final String user;
  const SignUpPage2({Key key, @required this.user}) : super(key: key);

  @override
  _SignUpPage2State createState() => _SignUpPage2State();

  //State<StatefulWidget> createState() {
  //  return _SignUpPage2State();
  //}
}

class _SignUpPage2State extends State<SignUpPage2> {
  final Map<String, dynamic> _formData = {
    'age': null,
    'sex': null,
    'email': null,
    'phonenumber': null,
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
          labelText: 'Age', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty
//            || !RegExp(r"[0-9]").hasMatch(value)
            ) {
          return 'Please enter your age';
        }
      },
      onSaved: (String value) {
        _formData['age'] = value;
      },
    );
  }

//Gender -- change this to be a drop down
  Widget _buildSexTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Sex', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please enter your gender';
        }
      },
      onSaved: (String value) {
        _formData['sex'] = value;
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
    //login(_formData['email'], _formData['password']);
    print(_formData);
    //Need a way to specify the user to update the data for
    //pass name of user to be doc name
    /*Firestore.instance.collection('Users').document(widget.user).updateData({
      'Age': _formData['age'],
      'Sex': _formData['sex'],
      'E-Mail': _formData['email'],
      'Phone Number': _formData['phonenumber']
    });

    Navigator.pushReplacementNamed(context, '/signuppage3');


        ));*/

    gUser = User(
        id: widget.user,
        email: _formData["email"],
        password: "",
        userType: UserType.individual);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUpPage3(
                  user: widget.user,
                )));
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

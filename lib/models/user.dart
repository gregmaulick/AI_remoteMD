import 'package:flutter/material.dart';


enum UserType{
  individual,
  organization
}
class User {
  final String id;
  final String email;
  final String password;
  final UserType userType;

  User({@required this.id, @required this.email, @required this.password, this.userType});
}

UserType gUserType = UserType.organization;

User gUser = User(id:"notLoggedIn",email:"notLoggedIn",password: "notLoggedIn", userType:gUserType);

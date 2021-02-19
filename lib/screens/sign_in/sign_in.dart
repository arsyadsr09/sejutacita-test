import 'package:flutter/material.dart';
import './sign_in_view.dart';

class SignIn extends StatefulWidget {
  final String mode;

  SignIn({this.mode});

  @override
  SignInView createState() => new SignInView();
}

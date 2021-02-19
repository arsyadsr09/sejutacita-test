import 'dart:async';

import 'package:flutter/material.dart';
import 'package:github/github.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './sign_in.dart';


abstract class SignInViewModel extends State<SignIn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorLogin = "";
  String errorUsername = "";
  String errorPassword = "";

  bool isLoading = false;

  void toggleLoading(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  void setError({String type, String value}) {
    setState(() {
      if (type == 'login') {
        errorLogin = value;
      } else if (type == 'email') {
        errorUsername = value;
      } else if (type == 'password') {
        errorPassword = value;
      }
      isLoading = false;
    });
  }

  void clearError() {
    setState(() {
      errorLogin = "";
      errorUsername = "";
      errorPassword = "";
    });
  }

  Future<void> onLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (widget.mode == "basic") {
      if (usernameController.text.length <= 0) {
        setError(type: "username", value: "Username can't be null");
      } else if (passwordController.text.length <= 0) {
        setError(type: "password", value: "Password can't be null");
      } else {
        toggleLoading(true);
        try {
          dynamic result = GitHub(
              auth: Authentication.basic(
                  usernameController.text, passwordController.text));
          dynamic auth = await result.users.getUser(usernameController.text);

          if (auth.login != null) {
            print(auth.login);
            prefs.setString("userId", usernameController.text);
            prefs.setString("passwordId", passwordController.text);
            prefs.setBool('isLogin', true);
            Navigator.pushNamedAndRemoveUntil(
                context, '/Home', (Route<dynamic> route) => false);
          } else {
            setError(type: 'login', value: "Username not found.");
          }
        } catch (e) {
          print(e.toString());
          setError(type: 'login', value: "Internal Server Error");
        } finally {
          toggleLoading(false);
        }
      }
    } else {
      if (passwordController.text.length <= 0) {
        setError(type: "password", value: "Access Token can't be null");
      } else {
        toggleLoading(true);
        try {
          dynamic result =
              GitHub(auth: Authentication.withToken(passwordController.text));

          dynamic auth = await result.users.getCurrentUser();

          if (auth.login != null) {
            print(auth.login);
            print("access");
            prefs.setString("accessToken", passwordController.text);
            prefs.setBool('isLogin', true);
            Navigator.pushNamedAndRemoveUntil(
                context, '/Home', (Route<dynamic> route) => false);
          } else {
            setError(type: 'login', value: "Username not found.");
          }
        } catch (e) {
          print(e.toString());
          setError(type: 'login', value: "${e.toString()}");
        } finally {
          toggleLoading(false);
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}

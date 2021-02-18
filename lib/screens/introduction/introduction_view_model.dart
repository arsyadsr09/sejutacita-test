import 'package:github_test/helpers/navigation_animation.dart';
import 'package:github_test/screens/landing/landing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './introduction.dart';

abstract class IntroductionViewModel extends State<Introduction> {
  onClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("introduction", true);

    Navigator.push(context, NavigationRoute(enterPage: Landing()));
  }
}

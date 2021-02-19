import 'package:flutter/material.dart';

import 'screens/home/home.dart';
import 'screens/introduction/introduction.dart';
import 'screens/landing/landing.dart';
import 'screens/profile/profile.dart';
import 'screens/repositories/repositories.dart';
import 'screens/search/search.dart';
import 'screens/organizations/organizations.dart';

final Map<String, WidgetBuilder> routes = {
  '/Home': (BuildContext context) => Home(),
  '/Landing': (BuildContext context) => Landing(),
  '/Introduction': (BuildContext context) => Introduction(),
  '/Search': (BuildContext context) => Search(),
  '/Profile': (BuildContext context) => Profile(),
  '/Organizations': (BuildContext context) => Organizations(),
  '/Repositories': (BuildContext context) => Repositories(),
};

import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/screens/feeds/feeds.dart';
import 'package:github_test/screens/issues/issues.dart';
import 'package:github_test/screens/pull_request/pull_request.dart';
import './home.dart';

abstract class HomeViewModel extends State<Home> {
  final GlobalKey<InnerDrawerState> innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  TextEditingController searchController = TextEditingController();

  int currentIndex = 0;
  List<Map> children = [
    {
      "name": "Feeds",
      "page": Feeds(),
      "icon": Icons.dynamic_feed,
      "unSelectedColor": ColorsCustom.darkSecondary,
      "selectedColor": ColorsCustom.primary,
      "background": ColorsCustom.bgSecondary
    },
    {
      "name": "Issues",
      "page": Issues(),
      "icon": Icons.dynamic_feed,
      "unSelectedColor": ColorsCustom.darkSecondary,
      "selectedColor": ColorsCustom.primary,
      "background": ColorsCustom.bgSecondary
    },
    {
      "name": "Pull Request",
      "page": PullRequest(),
      "icon": Icons.dynamic_feed,
      "unSelectedColor": ColorsCustom.darkSecondary,
      "selectedColor": ColorsCustom.primary,
      "background": ColorsCustom.bgSecondary
    },
  ];

  void toggleDrawer() {
    innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  void onSearchChange(String value) {
    setState(() {
      searchController = TextEditingController(text: value);
    });
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

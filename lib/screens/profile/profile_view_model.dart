import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github/github.dart';
import 'package:github_test/providers/providers.dart';
import 'package:github_test/redux/actions/user_action.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './profile.dart';

abstract class ProfileViewModel extends State<Profile> {
  Store<AppState> store;
  List menu = [
    {"name": "Organizations", "icon": Icons.people, "route": "/Organizations"},
    {"name": "Repositories", "icon": Icons.book, "route": "/Repositories"},
  ];

  User user = User();
  bool isLoading = false;

  void toggleIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void redirect(String value) {
    Navigator.pushNamed(context, value);
  }

  Future<void> getUser() async {
    toggleIsLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString('accessToken') == null) {
        String username = prefs.getString('userId');
        String password = prefs.getString('passwordId');

        dynamic result = GitHub(auth: Authentication.basic(username, password));
        User auth = await result.users.getUser(username);
        setState(() {
          user = auth;
        });
      } else {
        String accessToken = prefs.getString('accessToken');

        dynamic result = GitHub(auth: Authentication.withToken(accessToken));
        User auth = await result.users.getCurrentUser();
        setState(() {
          user = auth;
        });
      }
    } catch (e) {
      print(e);
    } finally {
      await getPinnedRepo();
      toggleIsLoading(false);
    }
  }

  Future<void> getPinnedRepo() async {
    try {
      dynamic result = await Providers.getPinnedRepo(user.login);
      dynamic resultDecode = json.decode(result.data);
      print(resultDecode.length);
      // print(resultDecode);

      await store.dispatch(SetUserPinnedRepositories(pinned: resultDecode));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      getUser();
    });
  }
}

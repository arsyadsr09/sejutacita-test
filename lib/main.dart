import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/store.dart';
import 'package:github_test/routes.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/colors_custom.dart';
import 'screens/home/home.dart';
import 'screens/introduction/introduction.dart';
import 'screens/landing/landing.dart';

Future<void> main() async {
  Store<AppState> _store = await createStore();

  runApp(MainApp(_store));
}

class MainApp extends StatefulWidget {
  final Store<AppState> store;

  MainApp(this.store);
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLogin = false;
  bool introduction = false;

  Future initMain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      introduction = prefs.getBool('introduction') ?? false;
      isLogin = prefs.getBool('isLogin') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    initMain();
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: widget.store,
        child: MaterialApp(
          title: 'Github Test',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            platform: TargetPlatform.iOS,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: ColorsCustom.primary,
            scaffoldBackgroundColor: ColorsCustom.bgPrimary,
          ),
          home: !introduction
              ? Introduction()
              : isLogin
                  ? Home()
                  : Landing(),
          routes: routes,
        ));
  }
}

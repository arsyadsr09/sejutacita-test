import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/menu_list.dart';
import 'profile.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  List menu = [
    {"name": "Profile", "icon": Icons.person, "route": "/Profile"},
    {"name": "Organizations", "icon": Icons.people, "route": "/Organizations"},
    {"name": "Repositories", "icon": Icons.book, "route": "/Repositories"},
    {"name": "Logout", "icon": Icons.logout, "route": "logout"},
  ];

  Future<void> onLogout() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await _auth.signOut().then((_) {
    //   //try the following
    //   _googleSignIn.signOut();
    //   prefs.clear();

    Navigator.pushNamedAndRemoveUntil(
        context, '/Landing', (Route<dynamic> route) => false);
    // });
  }

  void redirect(String value) {
    if (value == 'logout') {
      onLogout();
    } else {
      Navigator.pushNamed(context, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey[100]),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Profile(),
              SizedBox(height: 35),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: menu.length,
                  itemBuilder: (context, i) {
                    return MenuList(
                        name: menu[i]['name'],
                        icon: menu[i]['icon'],
                        data: menu[i],
                        direct: redirect);
                  })
            ]),
      ),
    );
  }
}

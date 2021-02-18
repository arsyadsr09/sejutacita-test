import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/helpers/navigation_animation.dart';
import 'package:github_test/screens/sign_in/sign_in.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'landing_view_model.dart';

class LandingView extends LandingViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorsCustom.bgPrimary,
        systemNavigationBarIconBrightness: Brightness.light));
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                width: screenSize.width - 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText('Welcome to',
                        fontWeight: FontWeight.w500,
                        fontSize: screenSize.width / 14),
                    Hero(
                      tag: 'github_test',
                      child: Material(
                        color: Colors.transparent,
                        child: CustomText("GITHUB",
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: screenSize.width / 8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: screenSize.width - 100,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Navigator.push(context,
                        NavigationRoute(enterPage: SignIn(mode: "basic")));
                  },
                  color: ColorsCustom.primary,
                  textColor: Colors.white,
                  child: CustomText(
                    'Basic Authentication',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: screenSize.width - 100,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    Navigator.push(context,
                        NavigationRoute(enterPage: SignIn(mode: "token")));
                  },
                  color: ColorsCustom.secondary,
                  textColor: Colors.white,
                  child: CustomText(
                    'Access Token',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Container(
                width: screenSize.width / 1.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 1.2,
                      color: Colors.white.withOpacity(0.5),
                    )),
                    SizedBox(width: 10),
                    CustomText(
                      'or',
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: Divider(
                      thickness: 1.2,
                      color: Colors.white.withOpacity(0.5),
                    )),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Container(
                width: screenSize.width - 100,
                child: OutlineButton(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async {
                    const url = 'https://github.com/join';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  highlightedBorderColor: ColorsCustom.secondary,
                  textColor: ColorsCustom.secondary,
                  child: CustomText(
                    'Register',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

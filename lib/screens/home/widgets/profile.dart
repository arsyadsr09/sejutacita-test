import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:github/github.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String loginName, avatar, name;
  bool isLoading = false;

  void toggleIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> getLocalStorage() async {
    toggleIsLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString('accessToken') == null) {
        String username = prefs.getString('userId');
        String password = prefs.getString('passwordId');

        dynamic result = GitHub(auth: Authentication.basic(username, password));
        dynamic auth = await result.users.getUser(username);
        setState(() {
          loginName = auth.login ?? "";
          name = auth.name ?? "";
          avatar = auth.avatarUrl ?? "";
        });
      } else {
        String accessToken = prefs.getString('accessToken');

        dynamic result = GitHub(auth: Authentication.withToken(accessToken));
        dynamic auth = await result.users.getCurrentUser();
        setState(() {
          loginName = auth.login ?? "";
          name = auth.name ?? "";
          avatar = auth.avatarUrl ?? "";
        });
      }
    } catch (e) {
      print(e);
    } finally {
      toggleIsLoading(false);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                    imageUrl: avatar,
                    imageBuilder: (context, imageProvider) => Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                    placeholder: (context, url) => Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(bottom: 20),
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color(0xFFff4757)),
                          ),
                        ),
                    errorWidget: (context, url, error) => Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(bottom: 20),
                          alignment: Alignment.center,
                          child: Icon(Icons.error),
                        )),
                CustomText("$name",
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
                CustomText("$loginName",
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ],
            ),
    );
  }
}

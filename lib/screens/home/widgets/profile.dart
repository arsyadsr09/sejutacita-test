import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map profile;
  String phoneNumber, avatar, name;

  Future<void> getLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      phoneNumber = prefs.getString("phoneNumber") ?? "";
      name = prefs.getString("name") ?? "";
      avatar = prefs.getString("avatar") ?? "";
    });
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CachedNetworkImage(
          //     imageUrl: avatar,
          //     imageBuilder: (context, imageProvider) => Container(
          //           height: 100,
          //           width: 100,
          //           margin: EdgeInsets.only(bottom: 20),
          //           decoration: BoxDecoration(
          //               color: Colors.red,
          //               borderRadius: BorderRadius.circular(100),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.black54.withOpacity(0.1),
          //                   spreadRadius: 5,
          //                   blurRadius: 7,
          //                   offset: Offset(0, 3), // changes position of shadow
          //                 ),
          //               ],
          //               image: DecorationImage(
          //                   image: imageProvider, fit: BoxFit.cover)),
          //         ),
          //     placeholder: (context, url) => Container(
          //           height: 100,
          //           width: 100,
          //           margin: EdgeInsets.only(bottom: 20),
          //           alignment: Alignment.center,
          //           child: CircularProgressIndicator(
          //             strokeWidth: 2.5,
          //             valueColor:
          //                 new AlwaysStoppedAnimation<Color>(Color(0xFFff4757)),
          //           ),
          //         ),
          //     errorWidget: (context, url, error) => Container(
          //           height: 100,
          //           width: 100,
          //           margin: EdgeInsets.only(bottom: 20),
          //           alignment: Alignment.center,
          //           child: Icon(Icons.error),
          //         )),
          Container(
            height: 100,
            width: 100,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: ColorsCustom.primary,
            ),
          ),
          CustomText("Fullname",
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
          CustomText("some detail",
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 16),
        ],
      ),
    );
  }
}

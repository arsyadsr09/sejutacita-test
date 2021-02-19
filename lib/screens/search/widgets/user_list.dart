import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';

class UserList extends StatelessWidget {
  final String imageUrl, name;

  UserList({this.imageUrl, this.name});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      onPressed: () {},
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundColor: ColorsCustom.bgSecondary,
              backgroundImage: NetworkImage('$imageUrl'),
            ),
          ),
          SizedBox(width: 15),
          CustomText(
            "$name",
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}

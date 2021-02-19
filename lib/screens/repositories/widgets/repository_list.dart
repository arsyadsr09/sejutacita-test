import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';

class RepositoryList extends StatelessWidget {
  final String imageUrl, id, name, starred, language;

  RepositoryList(
      {this.imageUrl, this.id, this.name, this.starred, this.language});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      onPressed: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: CircleAvatar(
              backgroundColor: ColorsCustom.bgSecondary,
              backgroundImage: NetworkImage('$imageUrl'),
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "$id",
                  color: Colors.grey,
                ),
                CustomText(
                  "$name",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: ColorsCustom.yellow,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    CustomText(
                      "$starred",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Icon(
                      FontAwesomeIcons.circle,
                      color: ColorsCustom.yellow,
                      size: 12,
                    ),
                    SizedBox(width: 5),
                    CustomText(
                      "$language",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';

class OrganizationCard extends StatelessWidget {
  final String title, imageUrl, detail;

  OrganizationCard({this.title, this.imageUrl, this.detail});

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
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "$title",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 5),
                CustomText(
                  "${detail != null ? detail : '-'}",
                  fontSize: 14,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

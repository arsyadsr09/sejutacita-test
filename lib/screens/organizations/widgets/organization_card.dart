import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';

class OrganizationCard extends StatelessWidget {
  final String title, id, detail;

  OrganizationCard({this.title, this.id, this.detail});

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
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/71265848?s=200&v=4'),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "$title",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomText(
                "$id",
                fontSize: 14,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              CustomText(
                "$detail",
                fontSize: 14,
              ),
            ],
          )
        ],
      ),
    );
  }
}

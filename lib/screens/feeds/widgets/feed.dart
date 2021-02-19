import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:timeago/timeago.dart' as timeago;

class Feed extends StatelessWidget {
  final String imageUrl, actor, action, timestamp, repo;

  Feed({this.imageUrl, this.actor, this.timestamp, this.repo, this.action});

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
                RichText(
                  text: new TextSpan(
                    text: '$actor ',
                    style: TextStyle(color: Colors.white),
                    children: <TextSpan>[
                      new TextSpan(
                          text: '$action ',
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "$repo")
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      action == 'added'
                          ? Icons.add
                          : action == 'created'
                              ? Icons.book
                              : action == 'forked'
                                  ? FontAwesomeIcons.codeBranch
                                  : Icons.star,
                      color: ColorsCustom.darkSecondary,
                      size: 20,
                    ),
                    SizedBox(width: 5),
                    CustomText(
                      "${timeago.format(DateTime.parse(timestamp))}",
                      fontSize: 12,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

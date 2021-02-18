import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
                  'https://i.pinimg.com/originals/e3/c0/b5/e3c0b57e39b9038b5a33a28d7953f24d.jpg'),
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: new TextSpan(
                  text: 'mhaidarhanif ',
                  style: TextStyle(color: Colors.white),
                  children: <TextSpan>[
                    new TextSpan(
                        text: 'starred ',
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "magiclabs/magic.js")
                  ],
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: ColorsCustom.darkSecondary,
                    size: 20,
                  ),
                  SizedBox(width: 5),
                  CustomText(
                    "Yesterday",
                    fontSize: 12,
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

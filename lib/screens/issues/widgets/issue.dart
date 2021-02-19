import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:timeago/timeago.dart' as timeago;

class Issue extends StatelessWidget {
  final String user, repo, id, content, timestamp, comments, state;

  Issue(
      {this.id,
      this.repo,
      this.user,
      this.content,
      this.timestamp,
      this.comments,
      this.state});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      onPressed: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            state == 'open' ? Icons.info_outline : Icons.close,
            color: state == 'open' ? ColorsCustom.green : ColorsCustom.red,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "$repo #$id",
                  color: Colors.grey,
                ),
                SizedBox(height: 5),
                CustomText(
                  "$content",
                  fontWeight: FontWeight.bold,
                )
              ],
            ),
          ),
          Column(
            children: [
              CustomText(
                "${timeago.format(DateTime.parse(timestamp), locale: 'en_short')}",
                color: ColorsCustom.secondary,
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: ColorsCustom.darkSecondary,
                    borderRadius: BorderRadius.circular(4)),
                child: CustomText(
                  "$comments",
                  color: ColorsCustom.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

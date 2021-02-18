import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';

class PinCard extends StatelessWidget {
  final String title, subtitle, detail, starred, language;

  PinCard(
      {this.title, this.detail, this.starred, this.language, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minWidth: screenSize.width / 1.3),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: ColorsCustom.primary.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8)),
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        onPressed: () {},
        child: Container(
          constraints: BoxConstraints(minWidth: screenSize.width / 1.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircleAvatar(
                            backgroundColor: ColorsCustom.bgSecondary,
                            backgroundImage: NetworkImage(
                                'https://i.pinimg.com/originals/e3/c0/b5/e3c0b57e39b9038b5a33a28d7953f24d.jpg'),
                          ),
                        ),
                        SizedBox(width: 8),
                        CustomText(
                          "$title",
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: ColorsCustom.primary,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    CustomText(
                      "$subtitle",
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      "$detail",
                      fontWeight: FontWeight.w500,
                    ),
                  ]),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/screens/profile/widgets/pin_card.dart';
import 'package:github_test/widgets/header_page.dart';
import 'package:github_test/widgets/menu_list.dart';
import 'package:github_test/widgets/custom_text.dart';
import './profile_view_model.dart';

class ProfileView extends ProfileViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.height,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  width: screenSize.width,
                  padding: EdgeInsets.only(
                      top: 130, left: 20, right: 20, bottom: 30),
                  color: ColorsCustom.bgSecondary,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: CircleAvatar(
                              backgroundColor: ColorsCustom.bgSecondary,
                              backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/originals/e3/c0/b5/e3c0b57e39b9038b5a33a28d7953f24d.jpg'),
                            ),
                          ),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                "Arsyad Ramadhan",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomText(
                                "arsyadsr09",
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ]),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.mapPin,
                              color: ColorsCustom.secondary,
                              size: 15,
                            ),
                            SizedBox(width: 10),
                            Flexible(
                                child: CustomText(
                              "Indonesia",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            )),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.userAlt,
                              color: ColorsCustom.secondary,
                              size: 15,
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: RichText(
                                text: new TextSpan(
                                  text: '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '11 ',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: "Followers • "),
                                    TextSpan(
                                        text: '11 ',
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: "Following")
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
                SizedBox(height: 15),
                Container(
                  width: screenSize.width,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  color: ColorsCustom.bgSecondary,
                  child: Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.thumbtack,
                        color: ColorsCustom.secondary,
                        size: 15,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                          child: CustomText(
                        "Pinned",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )),
                    ],
                  ),
                ),
                Container(
                  height: 180,
                  padding: EdgeInsets.only(bottom: 10),
                  color: ColorsCustom.bgSecondary,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      PinCard(
                        title: 'rentnesia',
                        subtitle: 'rentnesia-frontend',
                        detail: 'rentnesia-frontend with React.js',
                        language: 'JavaScript',
                        starred: '23',
                      ),
                      PinCard(
                        title: 'rentnesia',
                        subtitle: 'rentnesia-frontend',
                        detail: 'rentnesia-frontend with React.js',
                        language: 'JavaScript',
                        starred: '23',
                      ),
                      PinCard(
                        title: 'rentnesia',
                        subtitle: 'rentnesia-frontend',
                        detail: 'rentnesia-frontend with React.js',
                        language: 'JavaScript',
                        starred: '23',
                      ),
                    ],
                  ),
                ),
                Container(
                    width: screenSize.width,
                    color: ColorsCustom.bgSecondary,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: menu.length,
                        itemBuilder: (context, i) {
                          return MenuList(
                              name: menu[i]['name'],
                              icon: menu[i]['icon'],
                              data: menu[i],
                              direct: redirect);
                        }))
              ],
            ),
          ),
          HeaderPage(
            // title: "Profile",
            itemColor: ColorsCustom.secondary,
            bgColor: ColorsCustom.secondary,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/modules/user_state.dart';
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
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ))
                : ListView(
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
                                    backgroundImage:
                                        NetworkImage('${user.avatarUrl}'),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      "${user.name}",
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      "${user.login}",
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
                                    "${user.location}",
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
                                              text: '${user.followersCount} ',
                                              style: new TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(text: "Followers • "),
                                          TextSpan(
                                              text: '${user.followingCount} ',
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
                      StoreConnector<AppState, UserState>(
                          converter: (store) => store.state.userState,
                          builder: (ctx, state) {
                            return state.pinnedRepo.length > 0
                                ? Container(
                                    height: 180,
                                    padding: EdgeInsets.only(bottom: 10),
                                    color: ColorsCustom.bgSecondary,
                                    child: ListView.builder(
                                        itemCount: state.pinnedRepo.length,
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemBuilder: (BuildContext ctx, i) {
                                          return PinCard(
                                            title:
                                                '${state.pinnedRepo[i]['owner']}',
                                            subtitle:
                                                '${state.pinnedRepo[i]['repo']}',
                                            detail:
                                                '${state.pinnedRepo[i]['description']}',
                                            language:
                                                '${state.pinnedRepo[i]['language']}',
                                            starred:
                                                '${state.pinnedRepo[i]['stars']}',
                                          );
                                        }))
                                : Container(
                                    width: screenSize.width,
                                    height: 180,
                                    color: ColorsCustom.bgSecondary,
                                    alignment: Alignment.center,
                                    child: CustomText("No Pinned Repositories.",
                                        color: Colors.white));
                          }),
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

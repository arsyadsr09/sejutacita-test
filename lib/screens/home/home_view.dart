import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';
import './home_view_model.dart';
import '../search/widgets/SearchBar.dart';
import 'widgets/home_drawer.dart';

class HomeView extends HomeViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorsCustom.bgPrimary,
        systemNavigationBarIconBrightness: Brightness.light));
    return InnerDrawer(
        key: innerDrawerKey,
        onTapClose: true,
        swipe: true,
        colorTransitionChild: ColorsCustom.black,
        colorTransitionScaffold: ColorsCustom.bgPrimary.withOpacity(0.3),
        offset: IDOffset.only(bottom: 0.05, right: 0.0, left: 0.40),
        scale: IDOffset.horizontal(0.8),
        proportionalChildArea: true,
        borderRadius: 30,
        leftAnimationType: InnerDrawerAnimation.static,
        rightAnimationType: InnerDrawerAnimation.quadratic,
        backgroundDecoration: BoxDecoration(color: ColorsCustom.bgSecondary),
        leftChild: HomeDrawer(),
        scaffold: getScaffold(context));
  }

  Widget getScaffold(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: ColorsCustom.bgSecondary,
                floating: true,
                snap: true,
                centerTitle: false,
                title: Row(children: [
                  Container(
                    width: 43,
                    height: 43,
                    child: FlatButton(
                      padding: EdgeInsets.all(8),
                      color: ColorsCustom.primary.withOpacity(0.07),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () => toggleDrawer(),
                      child: Icon(
                        Icons.menu,
                        color: ColorsCustom.primary,
                        // size: 28,
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: CustomText(
                      "GITHUB",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ]),
                actions: [
                  Center(
                    child: Container(
                      width: 43,
                      height: 43,
                      child: FlatButton(
                        padding: EdgeInsets.all(8),
                        color: ColorsCustom.primary.withOpacity(0.07),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () => {
                          Navigator.pushNamed(context, '/Search')
                        },
                        child: Icon(
                          Icons.search,
                          color: ColorsCustom.primary,
                          // size: 28,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15)
                ],
              ),
            ];
          },
          body: children[currentIndex]['page'],
        ),
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: new BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: currentIndex,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          backgroundColor: children[currentIndex]['background'],
          selectedItemColor: children[currentIndex]['selectedColor'],
          unselectedItemColor: children[currentIndex]['unSelectedColor'],
          items: [
            BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.github),
              label: '${children[0]['name']}',
            ),
            BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.infoCircle),
              label: '${children[1]['name']}',
            ),
            BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.codeBranch),
              label: '${children[2]['name']}',
            ),
          ],
        ));
  }
}

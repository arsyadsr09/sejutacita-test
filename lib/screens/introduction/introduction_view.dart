import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:gooey_carousel/gooey_carrousel.dart';
import './introduction_view_model.dart';
import 'widgets/content_card.dart';

class IntroductionView extends IntroductionViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorsCustom.bgPrimary,
        systemNavigationBarIconBrightness: Brightness.light));
    return Scaffold(
      body: Stack(children: [
        GooeyCarousel(children: <Widget>[
          ContentCard(
            color: 'Red',
            altColor: ColorsCustom.secondary,
            altTextColor: Colors.white,
            bgColor: ColorsCustom.bgPrimary,
            fontColor: Colors.white,
            title: "Anywhere, Anytime",
            subtitle:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            onClick: onClick,
          ),
          ContentCard(
            color: 'Yellow',
            altColor: ColorsCustom.primary,
            altTextColor: Colors.white,
            bgColor: ColorsCustom.black,
            fontColor: Colors.white,
            title: "Check Progress",
            subtitle:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            onClick: onClick,
          ),
          ContentCard(
            color: 'Blue',
            altColor: ColorsCustom.secondary,
            altTextColor: Colors.white,
            bgColor: ColorsCustom.bgSecondary,
            fontColor: Colors.white,
            title: "Experience Design",
            subtitle:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            onClick: onClick,
          ),
        ]),
      ]),
    );
  }
}

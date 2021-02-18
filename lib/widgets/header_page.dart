import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';

class HeaderPage extends StatelessWidget {
  final Color bgColor, itemColor;
  final String title;
  final List<Widget> actions;

  HeaderPage({
    this.bgColor,
    this.title,
    this.itemColor,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 50,
        left: -10,
        right: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 60,
                    height: 50,
                    child: RaisedButton(
                      color: bgColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    )),
                SizedBox(width: 20),
                title != null
                    ? CustomText("$title",
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20)
                    : SizedBox(),
              ],
            ),
            actions != null
                ? Row(mainAxisSize: MainAxisSize.min, children: actions)
                : SizedBox()
          ],
        ));
  }
}

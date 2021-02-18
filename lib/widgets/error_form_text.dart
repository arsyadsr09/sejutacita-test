import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';

class ErrorForm extends StatelessWidget {
  final String error;

  ErrorForm({this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        alignment: Alignment.centerLeft,
        child: Text(
          "$error",
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontSize: 13,
              color: ColorsCustom.darkSecondary,
              fontFamily: 'Quicksand'),
        ));
  }
}

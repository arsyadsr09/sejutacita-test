import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final onChange;

  SearchBar({this.controller, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorsCustom.darkSecondary),
            child: TextField(
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Quicksand"),
              controller: controller,
              onChanged: (value) => onChange(value),
              cursorHeight: 14,
              cursorColor: ColorsCustom.primary,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: ColorsCustom.primary,
                ),
                focusColor: ColorsCustom.primary,
                hoverColor: ColorsCustom.primary,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                fillColor: Color(0xFFced6e0),
                hintText: "Search",
                hintStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.white30,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Quicksand"),
                border: InputBorder.none,
              ),
            )),
      ],
    );
  }
}

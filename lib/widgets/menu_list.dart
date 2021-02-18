import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';

class MenuList extends StatelessWidget {
  final String name, number;
  final IconData icon;
  final Map data;
  final direct;

  MenuList({this.name, this.icon, this.direct, this.data, this.number});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 10),
      onPressed: () => direct(data['route']),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: ColorsCustom.secondary.withOpacity(0.07),
              borderRadius: BorderRadius.circular(15)),
          child: Icon(
            icon,
            color: ColorsCustom.secondary,
          ),
        ),
        title: CustomText(
          name,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        trailing: number != null
            ? CustomText(
                number,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              )
            : SizedBox(),
      ),
    );
  }
}

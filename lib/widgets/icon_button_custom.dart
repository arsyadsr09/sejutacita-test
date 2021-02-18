import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  final IconData icon;
  final double size;
  final onClick;
  final Color splashColor, iconColor;

  IconButtonCustom(
      {this.icon, this.onClick, this.splashColor, this.iconColor, this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 2),
      child: InkWell(
        customBorder: new CircleBorder(),
        onTap: onClick,
        splashColor: splashColor,
        child: Padding(
          padding: EdgeInsets.all(7),
          child: new Icon(
            icon,
            size: size,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

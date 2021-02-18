import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormText extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType keyboard;
  final bool obscureText;
  final Color fontColor, iconColor, bgColor, colorHint;
  final onChange;

  FormText(
      {this.controller,
      this.onChange,
      this.hint,
      this.keyboard,
      this.icon,
      this.fontColor,
      this.iconColor,
      this.bgColor,
      this.obscureText: false,
      this.colorHint});
  @override
  _FormTextState createState() => _FormTextState();
}

class _FormTextState extends State<FormText> {
  bool obscureMode = true;

  void toggleObsecure() {
    setState(() {
      obscureMode = !obscureMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        padding: EdgeInsets.only(left: 5, right: widget.obscureText ? 5 : 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: widget.bgColor),
        child: TextField(
          style: TextStyle(
              fontSize: 13,
              color: widget.fontColor,
              fontWeight: FontWeight.w600,
              fontFamily: "Quicksand"),
          controller: widget.controller,
          keyboardType: widget.keyboard,
          onChanged: (_) => widget.onChange(),
          cursorHeight: 18,
          cursorColor: widget.iconColor,
          obscureText: widget.obscureText && obscureMode,
          decoration: InputDecoration(
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    size: 20,
                    color: widget.iconColor,
                  )
                : null,
            suffixIcon: widget.obscureText
                ? obscureMode
                    ? GestureDetector(
                        onTap: () => toggleObsecure(),
                        child: Icon(CupertinoIcons.eye_slash_fill))
                    : GestureDetector(
                        onTap: () => toggleObsecure(),
                        child: Icon(CupertinoIcons.eye_fill))
                : null,
            focusColor: widget.iconColor,
            hoverColor: widget.iconColor,
            hintText: "${widget.hint}",
            hintStyle: TextStyle(
                fontSize: 13,
                color: widget.colorHint,
                fontWeight: FontWeight.w600,
                fontFamily: "Quicksand"),
            border: InputBorder.none,
          ),
        ));
  }
}

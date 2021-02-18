import 'package:flutter/material.dart';
import './profile.dart';

abstract class ProfileViewModel extends State<Profile> {
  List menu = [
    {"name": "Organizations", "icon": Icons.people, "route": "/Organizations"},
    {"name": "Repositories", "icon": Icons.book, "route": "/Repositories"},
    {"name": "Starred", "icon": Icons.star, "route": "/Starred"},
  ];

  void redirect(String value) {
    Navigator.pushNamed(context, value);
  }
}

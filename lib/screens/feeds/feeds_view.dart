import 'package:flutter/material.dart';
import 'package:github_test/screens/feeds/widgets/feed.dart';
import './feeds_view_model.dart';

class FeedsView extends FeedsViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Feed(),
          Feed(),
          Feed(),
          Feed(),
          Feed(),
        ],
      ),
    );
  }
}

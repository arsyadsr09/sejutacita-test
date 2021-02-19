import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/modules/user_state.dart';
import 'package:github_test/screens/feeds/widgets/feed.dart';
import 'package:github_test/widgets/custom_text.dart';
import './feeds_view_model.dart';

class FeedsView extends FeedsViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      child: StoreConnector<AppState, UserState>(
          converter: (store) => store.state.userState,
          builder: (ctx, state) {
            return state.feeds.containsKey('data') &&
                    state.feeds['data'].length > 0
                ? ListView(
                    padding: EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    controller: scrollController,
                    children: [
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.feeds['data'].length,
                            controller: scrollController,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, i) {
                              return Feed(
                                action:
                                    "${state.feeds['data'][i]['payload'].containsKey('action') ? state.feeds['data'][i]['payload']['action'] : state.feeds['data'][i]['payload'].containsKey('ref_type') ? 'created' : state.feeds['data'][i]['payload'].containsKey('forkee') ? "forked" : ""}",
                                imageUrl:
                                    '${state.feeds['data'][i]['actor']['avatar_url']}',
                                actor:
                                    '${state.feeds['data'][i]['actor']['display_login']}',
                                repo:
                                    '${state.feeds['data'][i]['repo']['name']}',
                                timestamp:
                                    '${state.feeds['data'][i]['created_at']}',
                              );
                            }),
                        Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            width: screenSize.width,
                            alignment: Alignment.center,
                            child: !loadEnd
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                  )
                                : CustomText("All data has been obtained."))
                      ])
                : Container(
                    width: screenSize.width,
                    height: screenSize.height,
                    alignment: Alignment.center,
                    child: CustomText("No data feeds.", color: Colors.white));
          }),
    );
  }
}

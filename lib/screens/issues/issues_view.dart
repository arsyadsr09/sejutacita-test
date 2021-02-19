import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/modules/user_state.dart';
import 'package:github_test/screens/issues/widgets/issue.dart';
import 'package:github_test/widgets/custom_text.dart';
import './issues_view_model.dart';

class IssuesView extends IssuesViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
        width: screenSize.width,
        height: screenSize.height,
        child: StoreConnector<AppState, UserState>(
            converter: (store) => store.state.userState,
            builder: (ctx, state) {
              return state.issues.containsKey('data') &&
                      state.issues['data'].length > 0
                  ? ListView(
                      padding: EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      controller: scrollController,
                      children: [
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.issues['data'].length,
                              controller: scrollController,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext ctx, i) {
                                return Issue(
                                    id: state.issues['data'][i]['number']
                                        .toString(),
                                    repo: state.issues['data'][i]
                                            ['repository_url']
                                        .substring(29),
                                    content: state.issues['data'][i]['title'],
                                    timestamp: state.issues['data'][i]
                                        ['created_at'],
                                    state: state.issues['data'][i]['state'],
                                    comments: state.issues['data'][i]
                                            ['comments']
                                        .toString());
                              }),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            width: screenSize.width,
                            alignment: Alignment.center,
                            child: limitPage < state.issues['total']
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
                                : limitPage >= state.issues['total'] &&
                                        limitPage > 50
                                    ? CustomText("All data has been obtained.")
                                    : SizedBox(),
                          )
                        ])
                  : Container(
                      width: screenSize.width,
                      height: screenSize.height,
                      alignment: Alignment.center,
                      child:
                          CustomText("No data issues.", color: Colors.white));
            }));
  }
}

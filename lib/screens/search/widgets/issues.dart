import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/providers/providers.dart';
import 'package:github_test/redux/actions/search_action.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/modules/search_state.dart';
import 'package:github_test/screens/issues/widgets/issue.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:redux/redux.dart';

class IssuesSearch extends StatefulWidget {
  @override
  _IssuesSearchState createState() => _IssuesSearchState();
}

class _IssuesSearchState extends State<IssuesSearch> {
  Store<AppState> store;
  ScrollController scrollController;

  int limitPage = 50;

  Future<void> getPage(String type, [int value]) async {
    store.dispatch(SetIsLoading(isLoading: true));
    try {
      if (limitPage < store.state.searchState.issues['total']) {
        dynamic issuesResult = await Providers.searchIssues(
            store.state.searchState.query,
            type == 'lazy' ? store.state.searchState.issues['page']++ : value);

        print(value);
        Map<String, dynamic> dataIssues = type == 'lazy'
            ? {
                'data': [
                  ...store.state.searchState.issues['data'],
                  ...issuesResult.data['items']
                ],
                'total': issuesResult.data['total_count'],
                'page': store.state.searchState.issues['page']++,
              }
            : {
                'data': issuesResult.data['items'],
                'total': issuesResult.data['total_count'],
                'page': value,
              };

        await store.dispatch(SetIssues(issues: dataIssues));
      }
    } catch (e) {
      print(e.toString());
    } finally {
      store.dispatch(SetIsLoading(isLoading: false));
    }
  }

  Future<void> onChangePage(String type, [int numberPage]) async {
    if (type == 'minus') {
      print(store.state.searchState.issues['page']--);
      await getPage('index', store.state.searchState.issues['page']--);
    } else if (type == 'plus') {
      print(store.state.searchState.issues['page']++);
      await getPage('index', store.state.searchState.issues['page']++);
    } else {
      print("lala");
      await getPage('index', numberPage);
    }
  }

  Future<void> getNextPage() async {
    try {
      if (limitPage < store.state.searchState.issues['total']) {
        dynamic issuesResult = await Providers.searchIssues(
            store.state.searchState.query,
            store.state.searchState.issues['page']++);

        Map<String, dynamic> dataIssues = {
          'data': [
            ...store.state.searchState.issues['data'],
            ...issuesResult.data['items']
          ],
          'total': issuesResult.data['total_count'],
          'page': store.state.searchState.issues['page']++,
        };

        await store.dispatch(SetIssues(issues: dataIssues));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> onIncreased() async {
    if (limitPage < store.state.searchState.issues['total']) {
      try {
        int _mod = store.state.searchState.issues['total'] % 50;
        int _actualLimit = store.state.searchState.issues['total'] - limitPage;

        print("_mod $_mod");
        print("_actualLimit $_actualLimit");
        setState(() {
          if (_mod == _actualLimit) {
            limitPage += _mod;
          } else {
            limitPage += 50;
          }
        });
      } catch (e) {
        print(e);
      } finally {
        await getNextPage();
      }
    }
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (store.state.searchState.modePage == 1) {
        print("reach the bottom");
        onIncreased();
      }
    }
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return StoreConnector<AppState, SearchState>(
        converter: (store) => store.state.searchState,
        builder: (ctx, state) {
          if (state.isLoading) {
            return Container(
              width: screenSize.width,
              height: screenSize.height,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          } else {
            return state.issues.containsKey('data') &&
                    state.issues['data'].length > 0
                ? Container(
                    height: screenSize.height,
                    child: ListView(
                      padding: EdgeInsets.only(top: 10),
                      shrinkWrap: true,
                      controller: scrollController,
                      children: [
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.issues['data'].length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, i) {
                              return Issue(
                                  id: state.issues['data'][i]['number']
                                      .toString(),
                                  repo: state.issues['data'][i]
                                          ['repository_url']
                                      .substring(29),
                                  content: state.issues['data'][i]['title'],
                                  state: state.issues['data'][i]['state'],
                                  timestamp: state.issues['data'][i]
                                      ['created_at'],
                                  comments: state.issues['data'][i]['comments']
                                      .toString());
                            }),
                        state.modePage == 1
                            ? Container(
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
                                        ? CustomText(
                                            "All data has been obtained.")
                                        : SizedBox(),
                              )
                            : state.issues['total'] > 50
                                ? Container(
                                    height: 25,
                                    margin: EdgeInsets.only(
                                        top: 15, left: 20, right: 20),
                                    alignment: Alignment.center,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () => state.issues['page'] <= 1
                                              ? {}
                                              : onChangePage('minus'),
                                          child: Icon(
                                            Icons.arrow_left,
                                            size: 30,
                                            color: state.issues['page'] <= 1
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount: int.tryParse(
                                                  "${state.issues['total'] / 50}"),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder:
                                                  (BuildContext ctx, i) {
                                                if (state.issues['page'] ==
                                                    i + 1) {
                                                  return Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: CustomText(
                                                      "${i + 1}",
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          ColorsCustom.primary,
                                                    ),
                                                  );
                                                } else {
                                                  return GestureDetector(
                                                    onTap: () => onChangePage(
                                                        'normal', i + 1),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: CustomText(
                                                        "${i + 1}",
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }),
                                        ),
                                        GestureDetector(
                                          onTap: () => state.issues['page'] >=
                                                  state.issues['total']
                                              ? {}
                                              : onChangePage('plus'),
                                          child: Icon(
                                            Icons.arrow_right,
                                            size: 30,
                                            color: state.issues['page'] >=
                                                    state.issues['total']
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : CustomText("${state.issues['total']}"),
                        SizedBox(height: 40)
                      ],
                    ),
                  )
                : Container(
                    width: screenSize.width,
                    height: screenSize.height,
                    alignment: Alignment.center,
                    child: CustomText("No data issues.", color: Colors.white));
          }
        });
  }
}

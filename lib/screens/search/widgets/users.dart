import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/providers/providers.dart';
import 'package:github_test/redux/actions/search_action.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/modules/search_state.dart';
import 'package:github_test/screens/search/widgets/user_list.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:redux/redux.dart';

class UsersSearch extends StatefulWidget {
  @override
  _UsersSearchState createState() => _UsersSearchState();
}

class _UsersSearchState extends State<UsersSearch> {
  Store<AppState> store;
  ScrollController scrollController;

  int limitPage = 50;

  Future<void> getPage(String type, [int value]) async {
    store.dispatch(SetIsLoading(isLoading: true));
    try {
      if (limitPage < store.state.searchState.users['total']) {
        dynamic usersResult = await Providers.searchUsers(
            store.state.searchState.query,
            type == 'lazy' ? store.state.searchState.users['page']++ : value);

        print(value);
        Map<String, dynamic> dataUsers = type == 'lazy'
            ? {
                'data': [
                  ...store.state.searchState.users['data'],
                  ...usersResult.data['items']
                ],
                'total': usersResult.data['total_count'],
                'page': store.state.searchState.users['page']++,
              }
            : {
                'data': usersResult.data['items'],
                'total': usersResult.data['total_count'],
                'page': value,
              };

        await store.dispatch(SetUsers(users: dataUsers));
      }
    } catch (e) {
      print(e.toString());
    } finally {
      store.dispatch(SetIsLoading(isLoading: false));
    }
  }

  Future<void> onChangePage(String type, [int numberPage]) async {
    if (type == 'minus') {
      print(store.state.searchState.users['page']--);
      await getPage('index', store.state.searchState.users['page']--);
    } else if (type == 'plus') {
      print(store.state.searchState.users['page']++);
      await getPage('index', store.state.searchState.users['page']++);
    } else {
      print("lala");
      await getPage('index', numberPage);
    }
  }

  Future<void> onIncreased() async {
    if (limitPage < store.state.searchState.users['total']) {
      try {
        int _mod = store.state.searchState.users['total'] % 50;
        int _actualLimit = store.state.searchState.users['total'] - limitPage;

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
        await getPage('lazy');
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
            return state.users.containsKey('data') &&
                    state.users['data'].length > 0
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
                            itemCount: state.users['data'].length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, i) {
                              return UserList(
                                imageUrl: state.users['data'][i]['avatar_url'],
                                name: state.users['data'][i]['login'],
                              );
                            }),
                        state.modePage == 1
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                width: screenSize.width,
                                alignment: Alignment.center,
                                child: limitPage < state.users['total']
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
                                    : limitPage >= state.users['total'] &&
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
                                          onTap: () => state.users['page'] <= 1
                                              ? {}
                                              : onChangePage('minus'),
                                          child: Icon(
                                            Icons.arrow_left,
                                            size: 30,
                                            color: state.users['page'] <= 1
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
                                                if (state.users['page'] ==
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
                                          onTap: () => state.users['page'] >=
                                                  state.issues['total']
                                              ? {}
                                              : onChangePage('plus'),
                                          child: Icon(
                                            Icons.arrow_right,
                                            size: 30,
                                            color: state.users['page'] >=
                                                    state.issues['total']
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : CustomText("${state.issues['total']}"),
                        SizedBox(height: 50)
                      ],
                    ),
                  )
                : Container(
                    width: screenSize.width,
                    height: screenSize.height,
                    alignment: Alignment.center,
                    child: CustomText("No data users."));
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/providers/providers.dart';
import 'package:github_test/redux/actions/search_action.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/modules/search_state.dart';
import 'package:github_test/screens/repositories/widgets/repository_list.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:redux/redux.dart';

class RepositoriesSearch extends StatefulWidget {
  @override
  _RepositoriesSearchState createState() => _RepositoriesSearchState();
}

class _RepositoriesSearchState extends State<RepositoriesSearch> {
  Store<AppState> store;
  ScrollController scrollController;

  int limitPage = 50;

  Future<void> getNextPage() async {
    try {
      if (limitPage < store.state.searchState.repositories['total']) {
        dynamic repositoriesResult = await Providers.searchRepo(
            store.state.searchState.query,
            store.state.searchState.repositories['page']++);

        Map<String, dynamic> dataRepositories = {
          'data': [
            ...store.state.searchState.repositories['data'],
            ...repositoriesResult.data['items']
          ],
          'total': repositoriesResult.data['total_count'],
          'page': store.state.searchState.repositories['page']++,
        };

        await store.dispatch(SetRepositories(repositories: dataRepositories));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getPage(String type, [int value]) async {
    store.dispatch(SetIsLoading(isLoading: true));
    try {
      if (limitPage < store.state.searchState.repositories['total']) {
        dynamic repositoriesResult = await Providers.searchRepo(
            store.state.searchState.query,
            type == 'lazy'
                ? store.state.searchState.repositories['page']++
                : value);

        print(value);
        Map<String, dynamic> dataRepositories = type == 'lazy'
            ? {
                'data': [
                  ...store.state.searchState.repositories['data'],
                  ...repositoriesResult.data['items']
                ],
                'total': repositoriesResult.data['total_count'],
                'page': store.state.searchState.repositories['page']++,
              }
            : {
                'data': repositoriesResult.data['items'],
                'total': repositoriesResult.data['total_count'],
                'page': value,
              };

        await store.dispatch(SetRepositories(repositories: dataRepositories));
      }
    } catch (e) {
      print(e.toString());
    } finally {
      store.dispatch(SetIsLoading(isLoading: false));
    }
  }

  Future<void> onChangePage(String type, [int numberPage]) async {
    if (type == 'minus') {
      print(store.state.searchState.repositories['page']--);
      await getPage('index', store.state.searchState.repositories['page']--);
    } else if (type == 'plus') {
      print(store.state.searchState.repositories['page']++);
      await getPage('index', store.state.searchState.repositories['page']++);
    } else {
      print("lala");
      await getPage('index', numberPage);
    }
  }

  Future<void> onIncreased() async {
    if (limitPage < store.state.searchState.repositories['total']) {
      try {
        int _mod = store.state.searchState.repositories['total'] % 50;
        int _actualLimit =
            store.state.searchState.repositories['total'] - limitPage;

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
            return state.repositories.containsKey('data') &&
                    state.repositories['data'].length > 0
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
                            itemCount: state.repositories['data'].length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, i) {
                              return RepositoryList(
                                imageUrl: state.repositories['data'][i]['owner']
                                    ['avatar_url'],
                                name: state.repositories['data'][i]['name'],
                                id: state.repositories['data'][i]['owner']
                                    ['login'],
                                starred: state.repositories['data'][i]
                                        ['stargazers_count']
                                    .toString(),
                                language: state.repositories['data'][i]
                                    ['language'],
                              );
                            }),
                        state.modePage == 1
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                width: screenSize.width,
                                alignment: Alignment.center,
                                child: limitPage < state.repositories['total']
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
                                    : limitPage >=
                                                state.repositories['total'] &&
                                            limitPage > 50
                                        ? CustomText(
                                            "All data has been obtained.")
                                        : SizedBox(),
                              )
                            : state.modePage == 1
                                ? Container(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    width: screenSize.width,
                                    alignment: Alignment.center,
                                    child: limitPage <
                                            state.repositories['total']
                                        ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(Colors.white),
                                            ),
                                          )
                                        : limitPage >=
                                                    state.repositories[
                                                        'total'] &&
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
                                              onTap: () =>
                                                  state.repositories['page'] <=
                                                          1
                                                      ? {}
                                                      : onChangePage('minus'),
                                              child: Icon(
                                                Icons.arrow_left,
                                                size: 30,
                                                color: state.repositories[
                                                            'page'] <=
                                                        1
                                                    ? Colors.grey
                                                    : Colors.white,
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount: int.tryParse(
                                                      "${state.issues['total'] / 50}"),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (BuildContext ctx, i) {
                                                    if (state.repositories[
                                                            'page'] ==
                                                        i + 1) {
                                                      return Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: CustomText(
                                                          "${i + 1}",
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorsCustom
                                                              .primary,
                                                        ),
                                                      );
                                                    } else {
                                                      return GestureDetector(
                                                        onTap: () =>
                                                            onChangePage(
                                                                'normal',
                                                                i + 1),
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
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
                                              onTap: () =>
                                                  state.repositories['page'] >=
                                                          state.issues['total']
                                                      ? {}
                                                      : onChangePage('plus'),
                                              child: Icon(
                                                Icons.arrow_right,
                                                size: 30,
                                                color: state.repositories[
                                                            'page'] >=
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
                    child: CustomText("No data repositories.",
                        color: Colors.white));
          }
        });
  }
}

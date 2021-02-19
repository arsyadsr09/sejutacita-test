import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/modules/search_state.dart';
import 'package:github_test/screens/search/widgets/repositories.dart';
import 'package:github_test/screens/search/widgets/search_bar.dart';
import 'package:github_test/screens/search/widgets/issues.dart';
import 'package:github_test/screens/search/widgets/users.dart';
import './search_view_model.dart';

class SearchView extends SearchViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorsCustom.bgPrimary,
        systemNavigationBarIconBrightness: Brightness.light));
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: ColorsCustom.bgSecondary,
            title: SearchBar(
              controller: searchController,
              onChange: onChangeSearch,
            ),
            pinned: true,
            snap: true,
            floating: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(98.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StoreConnector<AppState, SearchState>(
                      converter: (store) => store.state.searchState,
                      builder: (ctx, state) {
                        return Row(
                          children: [
                            Expanded(
                                child: FlatButton(
                              onPressed: () => toggleMode(1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              height: 40,
                              color: state.modePage == 1
                                  ? ColorsCustom.secondary
                                  : ColorsCustom.bgSecondary,
                              textColor: Colors.white,
                              child: Text("LAZY LOADING"),
                            )),
                            Expanded(
                                child: FlatButton(
                              onPressed: () => toggleMode(2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              height: 40,
                              color: state.modePage == 2
                                  ? ColorsCustom.secondary
                                  : ColorsCustom.bgSecondary,
                              textColor: Colors.white,
                              child: Text("WITH INDEX"),
                            )),
                          ],
                        );
                      }),
                  TabBar(
                    indicatorColor: ColorsCustom.primary,
                    indicatorWeight: 4,
                    tabs: [
                      Tab(text: 'USERS'),
                      Tab(text: 'ISSUES'),
                      Tab(text: 'REPOSITORIES'),
                    ],
                    controller: controller,
                  ),
                ],
              ),
            ),
          ),
          // SliverList(
          SliverFillRemaining(
            child: TabBarView(
              controller: controller,
              children: <Widget>[
                Center(child: UsersSearch()),
                Center(child: IssuesSearch()),
                Center(child: RepositoriesSearch()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/providers/providers.dart';
import 'package:github_test/redux/actions/search_action.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:redux/redux.dart';
import './search.dart';

abstract class SearchViewModel extends State<Search>
    with SingleTickerProviderStateMixin {
  Store<AppState> store;
  TabController controller;
  Timer _debounce;
  TextEditingController searchController = TextEditingController();

  void toggleIsLoading(bool value) {
    store.dispatch(SetIsLoading(isLoading: value));
  }

  void toggleMode(int value) {
    store.dispatch(SetModePage(modePage: value));
  }

  void onChangeSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500),
        () => value.length > 0 ? onSearch(value) : {});
  }

  Future<void> onSearch(String value) async {
    toggleIsLoading(true);
    try {
      dynamic repositoriesResult = await Providers.searchRepo(value, 1);
      dynamic issuesResult = await Providers.searchIssues(value, 1);
      dynamic usersResult = await Providers.searchUsers(value, 1);

      Map<String, dynamic> dataRepositories = {
        'data': repositoriesResult.data['items'],
        'total': repositoriesResult.data['total_count'],
        'page': 1,
      };

      Map<String, dynamic> dataIssues = {
        'data': issuesResult.data['items'],
        'total': issuesResult.data['total_count'],
        'page': 1,
      };

      Map<String, dynamic> datasUsers = {
        'data': usersResult.data['items'],
        'total': usersResult.data['total_count'],
        'page': 1,
      };

      await store.dispatch(SetSearchResult(
          query: searchController.text,
          repositories: dataRepositories,
          issues: dataIssues,
          users: datasUsers));
    } catch (e) {
      print(e.toString());
    } finally {
      toggleIsLoading(false);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      toggleMode(1);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();
    super.dispose();
  }
}

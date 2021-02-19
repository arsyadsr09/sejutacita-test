import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github/github.dart';
import 'package:github_test/providers/providers.dart';
import 'package:github_test/redux/actions/user_action.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './issues.dart';

abstract class IssuesViewModel extends State<Issues> {
  Store<AppState> store;
  ScrollController scrollController;

  User user = User();

  int limitPage = 50;

  bool isLoading = false;

  void toggelIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> getIssues(bool init) async {
    toggelIsLoading(true);
    try {
      if (init) {
        dynamic issuesResult = await Providers.searchIssues(user.login, 1);

        Map<String, dynamic> dataIssues = {
          'data': issuesResult.data['items'],
          'total': issuesResult.data['total_count'],
          'page': 1,
        };

        await store.dispatch(SetUserIssues(issues: dataIssues));
      } else {
        if (limitPage < store.state.userState.issues['total']) {
          dynamic issuesResult = await Providers.searchIssues(
              user.login, store.state.userState.issues['page']++);

          Map<String, dynamic> dataIssues = {
            'data': [
              ...store.state.userState.issues['data'],
              ...issuesResult.data['items']
            ],
            'total': issuesResult.data['total_count'],
            'page': store.state.userState.issues['page']++,
          };

          await store.dispatch(SetUserIssues(issues: dataIssues));
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      toggelIsLoading(true);
    }
  }

  Future<void> onIncreased() async {
    if (limitPage < store.state.userState.issues['total']) {
      try {
        int _mod = store.state.userState.issues['total'] % 50;
        int _actualLimit = store.state.userState.issues['total'] - limitPage;

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
        await getIssues(false);
      }
    }
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print("reach the bottom");
      onIncreased();
    }
  }

  Future<void> getUser() async {
    toggelIsLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (prefs.getString('accessToken') == null) {
        String username = prefs.getString('userId');
        String password = prefs.getString('passwordId');

        dynamic result = GitHub(auth: Authentication.basic(username, password));
        User auth = await result.users.getUser(username);

        setState(() {
          user = auth;
        });
      } else {
        String accessToken = prefs.getString('accessToken');

        dynamic result = GitHub(auth: Authentication.withToken(accessToken));
        User auth = await result.users.getCurrentUser();
        setState(() {
          user = auth;
        });
      }
    } catch (e) {
      print(e);
    } finally {
      await getIssues(true);

      toggelIsLoading(false);
    }
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      getUser();
    });
  }
}

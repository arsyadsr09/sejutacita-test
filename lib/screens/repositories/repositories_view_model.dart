import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github/github.dart';
import 'package:github_test/providers/providers.dart';
import 'package:github_test/redux/actions/user_action.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './repositories.dart';

abstract class RepositoriesViewModel extends State<Repositories> {
  Store<AppState> store;

  User user = User();

  bool isLoading = false;

  void toggelIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> getRepositories(bool init) async {
    toggelIsLoading(true);
    try {
      dynamic repositoriesResult = await Providers.getUserRepo(user.login);
      print(repositoriesResult);

      await store
          .dispatch(SetUserRepositories(repositories: repositoriesResult.data));
    } catch (e) {
      print(e.toString());
    } finally {
      toggelIsLoading(true);
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
      await getRepositories(true);

      toggelIsLoading(false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store = StoreProvider.of<AppState>(context);
      getUser();
    });
  }
}

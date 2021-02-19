import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github/github.dart';
import 'package:github_test/providers/providers.dart';
import 'package:github_test/redux/actions/user_action.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './feeds.dart';

abstract class FeedsViewModel extends State<Feeds> {
  Store<AppState> store;
  ScrollController scrollController;

  User user = User();

  bool isLoading = false;
  bool loadEnd = false;

  void toggelIsLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  Future<void> getFeeds(bool init) async {
    toggelIsLoading(true);
    try {
      if (init) {
        dynamic feedsResult =
            await Providers.getUserReceivedEvent(user.login, 1);

        Map<String, dynamic> dataFeeds = {
          'data': feedsResult.data,
          'page': 1,
        };

        await store.dispatch(SetUserFeeds(feeds: dataFeeds));
      } else {
        dynamic feedsResult = await Providers.getUserReceivedEvent(
            user.login, store.state.userState.feeds['page']++);

        if (feedsResult.data != null) {
          Map<String, dynamic> dataFeeds = {
            'data': [
              ...store.state.userState.feeds['data'],
              ...feedsResult.data
            ],
            'page': store.state.userState.feeds['page']++,
          };

          await store.dispatch(SetUserFeeds(feeds: dataFeeds));
        } else {
          setState(() {
            loadEnd = true;
          });
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      toggelIsLoading(true);
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print("reach the bottom");
      if (!loadEnd) {
        await getFeeds(false);
      }
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
      await getFeeds(true);

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

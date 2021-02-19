import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/reducers/search_reducer.dart';
import 'package:github_test/redux/reducers/user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      searchState: searchReducer(state.searchState, action),
      userState: userReducer(state.userState, action));
}

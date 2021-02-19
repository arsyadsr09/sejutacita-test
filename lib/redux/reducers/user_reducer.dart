import 'package:github_test/redux/actions/user_action.dart';
import 'package:github_test/redux/modules/user_state.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<UserState>([
  TypedReducer<UserState, SetUserFeeds>(_setFeedsState),
  TypedReducer<UserState, SetUserIssues>(_setIssuesState),
  TypedReducer<UserState, SetUserOrganizations>(_setOrganizationsState),
  TypedReducer<UserState, SetUserRepositories>(_setRepositoriesState),
  TypedReducer<UserState, SetUserPinnedRepositories>(
      _setPinnedRepositoriesState),
]);

UserState _setFeedsState(UserState state, SetUserFeeds payload) {
  return state.copyWith(feeds: payload.feeds);
}

UserState _setIssuesState(UserState state, SetUserIssues payload) {
  return state.copyWith(issues: payload.issues);
}

UserState _setOrganizationsState(
    UserState state, SetUserOrganizations payload) {
  return state.copyWith(organizations: payload.organizations);
}

UserState _setRepositoriesState(UserState state, SetUserRepositories payload) {
  return state.copyWith(repositories: payload.repositories);
}

UserState _setPinnedRepositoriesState(
    UserState state, SetUserPinnedRepositories payload) {
  return state.copyWith(pinnedRepo: payload.pinned);
}

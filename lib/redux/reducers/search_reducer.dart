import 'package:github_test/redux/actions/search_action.dart';
import 'package:github_test/redux/modules/search_state.dart';
import 'package:redux/redux.dart';

final searchReducer = combineReducers<SearchState>([
  TypedReducer<SearchState, SetSearchResult>(_setResultSearchState),
  TypedReducer<SearchState, SetRepositories>(_setRepositoriesState),
  TypedReducer<SearchState, SetUsers>(_setUsersState),
  TypedReducer<SearchState, SetIssues>(_setIssuesState),
  TypedReducer<SearchState, SetQuery>(_setQueryState),
  TypedReducer<SearchState, SetIsLoading>(_setIsLoadingState),
  TypedReducer<SearchState, SetModePage>(_setModePageState),
]);

SearchState _setResultSearchState(SearchState state, SetSearchResult payload) {
  return state.copyWith(
      query: payload.query,
      repositories: payload.repositories,
      users: payload.users,
      issues: payload.issues);
}

SearchState _setRepositoriesState(SearchState state, SetRepositories payload) {
  return state.copyWith(repositories: payload.repositories);
}

SearchState _setUsersState(SearchState state, SetUsers payload) {
  return state.copyWith(users: payload.users);
}

SearchState _setIssuesState(SearchState state, SetIssues payload) {
  return state.copyWith(issues: payload.issues);
}

SearchState _setQueryState(SearchState state, SetQuery payload) {
  return state.copyWith(query: payload.query);
}

SearchState _setIsLoadingState(SearchState state, SetIsLoading payload) {
  return state.copyWith(isLoading: payload.isLoading);
}

SearchState _setModePageState(SearchState state, SetModePage payload) {
  return state.copyWith(modePage: payload.modePage);
}

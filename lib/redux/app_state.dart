import 'package:github_test/redux/modules/search_state.dart';
import 'package:github_test/redux/modules/user_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final SearchState searchState;
  final UserState userState;

  AppState({this.searchState, this.userState});

  factory AppState.initial() {
    return AppState(
      searchState: SearchState.initial(),
      userState: UserState.initial(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          searchState == other.searchState &&
          userState == other.userState;

  @override
  int get hashCode => searchState.hashCode ^ userState.hashCode;
}

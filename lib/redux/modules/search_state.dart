import 'package:meta/meta.dart';

@immutable
class SearchState {
  SearchState(
      {this.repositories,
      this.users,
      this.issues,
      this.query,
      this.isLoading,
      this.modePage});

  final Map repositories, users, issues;
  final String query;
  final bool isLoading;
  final int modePage;

  factory SearchState.initial() {
    return SearchState(query: "", isLoading: false, modePage: 1, repositories: {
      'data': [],
      'total': 0,
      'page': 1,
    }, users: {
      'data': [],
      'total': 0,
      'page': 1,
    }, issues: {
      'data': [],
      'total': 0,
      'page': 1,
    });
  }

  SearchState copyWith(
      {int modePage,
      String query,
      bool isLoading,
      Map repositories,
      Map users,
      Map issues}) {
    return SearchState(
      modePage: modePage ?? this.modePage,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      repositories: repositories ?? this.repositories,
      users: users ?? this.users,
      issues: issues ?? this.issues,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchState &&
          runtimeType == other.runtimeType &&
          modePage == other.modePage &&
          query == other.query &&
          isLoading == other.isLoading &&
          repositories == other.repositories &&
          users == other.users &&
          issues == other.issues;

  @override
  int get hashCode =>
      modePage.hashCode ^
      isLoading.hashCode ^
      query.hashCode ^
      repositories.hashCode ^
      users.hashCode ^
      issues.hashCode;
}

import 'package:meta/meta.dart';

@immutable
class UserState {
  UserState(
      {this.pinnedRepo,
      this.repositories,
      this.feeds,
      this.issues,
      this.organizations});

  final Map feeds, issues;
  final List pinnedRepo, repositories, organizations;

  factory UserState.initial() {
    return UserState(
      repositories: [],
      organizations: [],
      pinnedRepo: [],
      feeds: {
        'data': [],
        'page': 1,
      },
      issues: {'data': [], 'total': 0, 'page': 1},
    );
  }

  UserState copyWith(
      {List repositories,
      List organizations,
      List pinnedRepo,
      Map feeds,
      Map issues}) {
    return UserState(
      feeds: feeds ?? this.feeds,
      organizations: organizations ?? this.organizations,
      repositories: repositories ?? this.repositories,
      issues: issues ?? this.issues,
      pinnedRepo: pinnedRepo ?? this.pinnedRepo,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          feeds == other.feeds &&
          organizations == other.organizations &&
          repositories == other.repositories &&
          issues == other.issues &&
          pinnedRepo == other.pinnedRepo;

  @override
  int get hashCode =>
      feeds.hashCode ^
      organizations.hashCode ^
      repositories.hashCode ^
      issues.hashCode ^
      pinnedRepo.hashCode;
}

class SetSearchResult {
  final Map repositories, users, issues;
  final String query;

  SetSearchResult({this.query, this.repositories, this.issues, this.users});
}

class SetRepositories {
  final Map repositories;

  SetRepositories({this.repositories});
}

class SetUsers {
  final Map users;

  SetUsers({this.users});
}

class SetIssues {
  final Map issues;

  SetIssues({this.issues});
}

class SetQuery {
  final String query;

  SetQuery({this.query});
}

class SetIsLoading {
  final bool isLoading;

  SetIsLoading({this.isLoading});
}

class SetModePage {
  final int modePage;

  SetModePage({this.modePage});
}

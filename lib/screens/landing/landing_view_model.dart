import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:github_test/config/config.dart';
import 'landing.dart';

abstract class LandingViewModel extends State<Landing> {
  String error = "";

  Future<void> onLogin() async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: AUTHORIZATION_DATA['client_id'],
        clientSecret: AUTHORIZATION_DATA['client_secret'],
        redirectUrl: AUTHORIZATION_DATA['callback'],);
    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        print(result.token);
        print(result);
        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        break;
    }
  }
}

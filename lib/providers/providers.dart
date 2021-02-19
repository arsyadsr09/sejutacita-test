import 'package:dio/dio.dart';
import 'package:github_test/config/config.dart';

class Providers {
  // static Future loginBasic(String username, String password) async {
  //   final bytes = latin1.encode("$username:$password");
  //   final encoded = base64Encode(bytes);

  //   return Dio().post('$BASE_API/login/oauth/authorize',
  //       data: AUTHORIZATION_DATA,
  //       options: Options(
  //           headers: {"Authorization": "Basic " + encoded},
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status < 1000;
  //           }));
  // }

  static Future searchRepo(String value, int page) async {
    return Dio()
        .get('$BASE_API/search/repositories?q=$value&page=$page&per_page=50',
            options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status < 1000;
                }));
  }

  static Future searchIssues(String value, int page) async {
    return Dio().get('$BASE_API/search/issues?q=$value&page=$page&per_page=50',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 1000;
            }));
  }

  static Future searchUsers(String value, int page) async {
    return Dio().get('$BASE_API/search/users?q=$value&page=$page&per_page=50',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 1000;
            }));
  }

  static Future getPinnedRepo(String username) async {
    return Dio()
        .get('https://gh-pinned-repos-5l2i19um3.vercel.app/?username=$username',
            options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  return status < 1000;
                }));
  }

  static Future getUserRepo(String username) async {
    return Dio().get('https://api.github.com/users/$username/repos',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 1000;
            }));
  }

  static Future getUserOrganization(String username) async {
    return Dio().get('https://api.github.com/users/$username/orgs',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 1000;
            }));
  }

  static Future getUserReceivedEvent(String username, int page) async {
    return Dio().get(
        'https://api.github.com/users/$username/received_events/public?page=$page&per_page=50',
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 1000;
            }));
  }
}

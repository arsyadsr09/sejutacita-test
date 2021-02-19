import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/modules/user_state.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:github_test/widgets/header_page.dart';
import './repositories_view_model.dart';
import 'widgets/repository_list.dart';

class RepositoriesView extends RepositoriesViewModel {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: 110,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              child: StoreConnector<AppState, UserState>(
                  converter: (store) => store.state.userState,
                  builder: (ctx, state) {
                    return state.repositories.length > 0
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.repositories.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, i) {
                              return RepositoryList(
                                imageUrl: state.repositories[i]['owner']
                                    ['avatar_url'],
                                name: state.repositories[i]['name'],
                                id: state.repositories[i]['owner']['login'],
                                starred: state.repositories[i]
                                        ['stargazers_count']
                                    .toString(),
                                language: state.repositories[i]['language'],
                              );
                            })
                        : Container(
                            width: screenSize.width,
                            height: screenSize.height,
                            alignment: Alignment.center,
                            child: CustomText("No data repositories.",
                                color: Colors.white));
                  }),
            )),
        HeaderPage(
          title: "Repositories",
          itemColor: ColorsCustom.secondary,
          bgColor: ColorsCustom.secondary,
        )
      ]),
    );
  }
}

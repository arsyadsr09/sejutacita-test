import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/redux/app_state.dart';
import 'package:github_test/redux/modules/user_state.dart';
import 'package:github_test/screens/organizations/widgets/organization_card.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:github_test/widgets/header_page.dart';
import './organizations_view_model.dart';

class OrganizationsView extends OrganizationsViewModel {
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
                    return state.organizations.length > 0
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.organizations.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, i) {
                              return OrganizationCard(
                                title: "${state.organizations[i]['login']}",
                                imageUrl:
                                    '${state.organizations[i]['avatar_url']}',
                                detail:
                                    '${state.organizations[i]['description']}',
                              );
                            })
                        : Container(
                            width: screenSize.width,
                            height: screenSize.height,
                            alignment: Alignment.center,
                            child: CustomText("No data organizations.",
                                color: Colors.white));
                  }),
            )),
        HeaderPage(
          title: "Organizations",
          itemColor: ColorsCustom.secondary,
          bgColor: ColorsCustom.secondary,
        )
      ]),
    );
  }
}

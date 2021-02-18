import 'package:flutter/material.dart';
import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/screens/organizations/widgets/organization_card.dart';
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
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                OrganizationCard(
                  title: "Griffin Exchange",
                  id: 'griffin-exchange',
                  detail: 'Specta Super Mega Star Marvelous',
                ),
                SizedBox(height: 40)
              ],
            ),
          ),
        ),
        HeaderPage(
          title: "Organization",
          itemColor: ColorsCustom.secondary,
          bgColor: ColorsCustom.secondary,
        )
      ]),
    );
  }
}

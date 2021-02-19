import 'package:github_test/helpers/colors_custom.dart';
import 'package:github_test/widgets/custom_text.dart';
import 'package:github_test/widgets/error_form_text.dart';
import 'package:github_test/widgets/form_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './sign_in_view_model.dart';

class SignInView extends SignInViewModel {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorsCustom.bgPrimary,
        systemNavigationBarIconBrightness: Brightness.light));
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 30),
          children: <Widget>[
            Container(
              width: screenSize.width - 80,
              padding: EdgeInsets.only(left: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                      tag: "github_test",
                      child: Material(
                        color: Colors.transparent,
                        child: CustomText('GITHUB',
                            fontWeight: FontWeight.bold,
                            // color: ColorsCustom.black,
                            fontSize: 50),
                      )),
                  CustomText(
                      widget.mode == 'basic'
                          ? "Basic Authorization"
                          : "Access Token",
                      fontWeight: FontWeight.w500,
                      color: widget.mode == 'basic'
                          ? ColorsCustom.primary
                          : ColorsCustom.secondary,
                      fontSize: screenSize.width / 14),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.mode == 'basic'
                      ? FormText(
                          controller: usernameController,
                          hint: "Username",
                          icon: Icons.person,
                          keyboard: TextInputType.emailAddress,
                          bgColor: ColorsCustom.primary.withOpacity(0.3),
                          fontColor: Colors.white,
                          iconColor: Colors.white,
                          colorHint: Colors.white.withOpacity(0.5),
                          onChange: clearError,
                        )
                      : SizedBox(),
                  widget.mode == 'basic'
                      ? errorUsername != null && errorUsername != ""
                          ? ErrorForm(error: errorUsername)
                          : SizedBox(height: 20)
                      : SizedBox(),
                  FormText(
                    controller: passwordController,
                    hint: widget.mode == 'basic' ? "Password" : "Access Token",
                    icon: Icons.lock,
                    bgColor: widget.mode == 'basic'
                        ? ColorsCustom.primary.withOpacity(0.3)
                        : ColorsCustom.secondary.withOpacity(0.3),
                    fontColor: Colors.white,
                    iconColor: Colors.white,
                    colorHint: Colors.white.withOpacity(0.5),
                    obscureText: true,
                    onChange: clearError,
                  ),
                  errorPassword != null && errorPassword != ""
                      ? ErrorForm(error: errorPassword)
                      : SizedBox(),
                  errorLogin != null && errorLogin != ""
                      ? Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          // decoration: BoxDecoration(
                          //     color: Color(0xFF1e90ff).withOpacity(0.3),
                          //     borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline,
                                  color: Color(0xFFff4757).withOpacity(0.7)),
                              SizedBox(width: 10),
                              Text(
                                "$errorLogin",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Color(0xFFff4757).withOpacity(0.7),
                                    fontFamily: 'Quicksand'),
                              )
                            ],
                          ),
                        )
                      : SizedBox(height: 40),
                  Container(
                    width: screenSize.width - 100,
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () => isLoading ? {} : onLogin(),
                      color: widget.mode == 'basic'
                          ? ColorsCustom.primary
                          : ColorsCustom.secondary,
                      textColor: Colors.white,
                      child: isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: Center(
                                child: SizedBox(
                                  width: 17,
                                  height: 17,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                ),
                              ),
                            )
                          : CustomText(
                              'Continue',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: screenSize.width - 100,
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      textColor: widget.mode == 'basic'
                          ? ColorsCustom.primary
                          : ColorsCustom.secondary,
                      child: CustomText(
                        'Back',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ]),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:socialv/components/loading_widget.dart';
import 'package:socialv/main.dart';
import 'package:socialv/screens/auth/components/login_in_component.dart';
import 'package:socialv/screens/auth/components/sign_up_component.dart';

import '../../../utils/app_constants.dart';

class SignInScreen extends StatefulWidget {
  final int? activityId;

  const SignInScreen({this.activityId});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool doRemember = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    appStore.setLoading(false);
    setStatusBarColorBasedOnTheme();
  }

  Widget getFragment() {
    if (selectedIndex == 0) {
      return LoginInComponent(
        activityId: widget.activityId,
        callback: () {
          selectedIndex = 1;
          setState(() {});
        },
      );
    } else {
      return SignUpComponent(
        activityId: widget.activityId,
        callback: () {
          selectedIndex = 0;
          setState(() {});
        },
      );
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dx > sensitivity) {
                selectedIndex = 0;
                setState(() {});
              } else if (details.delta.dx < -sensitivity) {
                selectedIndex = 1;
                setState(() {});
              }
            },
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(height: context.statusBarHeight + 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(APP_LOGO, height: 60, fit: BoxFit.cover),
                          8.width,
                        ],
                      ),
                      20.height,
                      headerContainer(
                        context: context,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              child: Text('LOGIN',
                                  style: boldTextStyle(
                                      fontFamily: 'Poppins',
                                      weight: FontWeight.w600,
                                      color: selectedIndex == 0
                                          ? Colors.white
                                          : Color(0xff8BAFE7))),
                              onPressed: () {
                                selectedIndex = 0;
                                setState(() {});
                              },
                            ),
                            TextButton(
                              child: Text(language.signUp.toUpperCase(),
                                  style: boldTextStyle(
                                      fontFamily: 'Poppins',
                                      weight: FontWeight.w600,
                                      color: selectedIndex == 1
                                          ? Colors.white
                                          : Color(0xff8BAFE7))),
                              onPressed: () {
                                selectedIndex = 1;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      getFragment().expand(),
                    ],
                  ),
                )
              ],
            ),
          ),
          Observer(
              builder: (_) =>
                  LoadingWidget().visible(appStore.isLoading).center())
        ],
      ),
    );
  }
}

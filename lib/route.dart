import 'package:flutter/material.dart';
import 'package:suzuki/view/splash_screen_view.dart';
import 'package:suzuki/view/login_view.dart';
import 'package:suzuki/view/home_view.dart';

String initialRouteName = RouteName.splashScreen;

class RouteName {
  static const String splashScreen = "splashScreen";
  static const String login = "login";
  static const String home = "home";
}

enum ParamName {
  newsModel,
  customerModel,
  applicationModel,
  collectionModel,
  activeTabIndex,
}

Map<String, WidgetBuilder> route = {
  RouteName.splashScreen: (BuildContext context) {
    return SplashScreenView(
      onFinish: (withLogin) {
        if (withLogin) {
          Navigator.of(context).pushReplacementNamed(RouteName.home);
        } else {
          Navigator.of(context).pushReplacementNamed(RouteName.login);
        }
      },
    );
  },
  RouteName.login: (BuildContext context) {
    return LoginView(
      onLoginSuccess: () {
        Navigator.of(context).pushReplacementNamed(RouteName.home);
      },
    );
  },
  RouteName.home: (BuildContext context) {
    return HomeView(
      key: GlobalKey(),
    );
  },
};

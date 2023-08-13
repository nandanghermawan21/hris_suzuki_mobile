import 'package:flutter/material.dart';
import 'package:suzuki/util/enum.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view/splash_screen_view.dart';
import 'package:suzuki/view/login_view.dart';
import 'package:suzuki/view/home_view.dart';
import 'package:suzuki/view/setting_view.dart';
import 'package:suzuki/view/profile_view.dart';

String initialRouteName = RouteName.splashScreen;

class RouteName {
  static const String splashScreen = "splashScreen";
  static const String login = "login";
  static const String home = "home";
  static const String setting = "setting";
  static const String profile = "profile";
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
      onTapSetting: () {
        Navigator.of(context).pushNamed(RouteName.setting);
      },
      onTapProfile: () {
        Navigator.of(context).pushNamed(RouteName.profile);
      },
    );
  },
  RouteName.setting: (BuildContext context) {
    return SettingView(
      onTapLogout: () {
        System.data.global.user = null;
        System.data.global.token = null;
        System.data.session!.setString(SessionKey.user, "");
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteName.login, (route) => route.settings.name == "");
      },
    );
  },
  RouteName.profile: (BuildContext context) {
    return ProfileView(
      key: GlobalKey(),
    );
  },
};

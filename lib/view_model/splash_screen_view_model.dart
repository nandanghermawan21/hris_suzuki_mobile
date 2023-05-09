import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/model/user_model.dart';
import 'package:suzuki/util/enum.dart';
import 'package:suzuki/util/system.dart';

class SplashScrenViewModel extends ChangeNotifier {
  CircularLoaderController loadingController = CircularLoaderController();

  void syncronizeMasterData({
    ValueChanged<bool>? onSyncFinish,
  }) {
    loadingController.startLoading(message: "Syncronize master data");
    Future.delayed(const Duration(seconds: 2), () {
      chekLogedIn(onLOginSuccess: onSyncFinish);
    });
  }

  void chekLogedIn({
    ValueChanged<bool>? onLOginSuccess,
  }) {
    String userJson = System.data.session!.getString(SessionKey.user) ?? "";
    if (userJson != "") {
      System.data.global.user = UserModel.fromJson(json.decode(userJson));
      System.data.global.token = System.data.global.user?.token;
      if (onLOginSuccess != null) {
        onLOginSuccess(true);
      }
    } else {
      if (onLOginSuccess != null) {
        onLOginSuccess(false);
      }
    }
  }

  void commit() {
    notifyListeners();
  }
}

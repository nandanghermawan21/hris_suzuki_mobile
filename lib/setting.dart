import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:suzuki/recource/color_default.dart';
import 'package:suzuki/recource/font_default.dart';
import 'package:suzuki/recource/string_id_id.dart';
import 'package:suzuki/route.dart';
import 'package:suzuki/util/api_end_point.dart';
import 'package:suzuki/util/data.dart';
import 'package:suzuki/util/enum.dart';
import 'package:suzuki/util/mode_util.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/route.dart' as route;

void setting() {
  System.data.versionName = "1.0.3";
  System.data.route = route.route;
  System.data.apiEndPoint = ApiEndPoint();
  System.data.strings = StringsIdId();
  System.data.color = ColorDefault();
  System.data.font = FontDefault();
  //change end point on dev mode
  if (System.data.versionName.split(".")[1] == "1") {
    System.data.apiEndPoint.baseUrl = "http://172.16.1.18/hris-api/api/";
    System.data.apiEndPoint.baseUrlDebug = "http://172.16.1.18/hris-api/api/";
  } else {
    if (System.data.versionName.split(" ").last == "Train") {
      System.data.apiEndPoint.baseUrl = "http://172.16.1.167/survey/api/";
      System.data.apiEndPoint.baseUrlDebug = "http://172.16.1.167/survey/api/";
    }
  }
  //setting permisson [haru didefinisikan juga pada manifest dan info.pls]
  System.data.permission = [
    Permission.accessNotificationPolicy,
    Permission.location,
    Permission.camera,
  ];
  //subscribe chanel
  System.data.deepLinkingHandler = (uri) {
    ModeUtil.debugPrint(uri?.path ?? "");
    if (ModalRoute.of(System.data.context)?.settings.name == initialRouteName) {
      return;
    }
    switch (uri?.path) {
      default:
        return;
    }
  };
  System.data.onCreateDb = (db, version) {
    int _last = 0;
    for (int i = version; i < _last; i++) {
      rootBundle.loadString("dbmigration/dbv${i + 1}.sql").then((sql) {
        db?.execute(sql).then((v) {
          db.setVersion(i + 1).then((v) {
            ModeUtil.debugPrint("update to version ${i + 1}");
          });
        });
      });
      ModeUtil.debugPrint("update is uptodate");
    }
  };
  System.data.directories = {
    DirKey.collection: "collection",
    DirKey.inbox: "inbox",
    DirKey.process: "process",
    DirKey.upload: "upload",
    DirKey.images: "images",
  };
  System.data.files = {
    FileKey.collection: FileInit(
      dirKey: DirKey.collection,
      name: "collection.json",
      value: "[]",
    ),
  };
}

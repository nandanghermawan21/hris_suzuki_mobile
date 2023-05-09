import 'package:suzuki/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "http://172.20.10.13/hris_suzuki_api/api/";
  String baseUrlDebug = "http://172.20.10.13/hris_suzuki_api/api/";
  String webSocketUrl = "";
  String webSocketUrlDebug = "";
  String loginUrl = "auth/login";


  String get url {
    if (ModeUtil.debugMode == true) {
      return baseUrlDebug;
    } else {
      return baseUrl;
    }
  }

  String get wwebSocketUrl {
    if (ModeUtil.debugMode == true) {
      return webSocketUrlDebug;
    } else {
      return webSocketUrl;
    }
  }
}

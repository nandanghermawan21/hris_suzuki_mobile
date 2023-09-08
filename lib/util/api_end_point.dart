import 'package:suzuki/util/mode_util.dart';

class ApiEndPoint {
  String baseUrl = "http://192.168.1.3/hris_suzuki_api/api/";
  String baseUrlDebug = "http://192.168.1.3/hris_suzuki_api/api/";
  String webSocketUrl = "";
  String webSocketUrlDebug = "";
  String loginUrl = "auth/login";
  String checkInUrl = "attendance/checkin";
  String checkOutUrl = "attendance/checkout";
  String pegawaiProfile = "pegawai/myprofile";
  String kehadiranSaya = "attendance/kehadiransaya";
  String kehadiranpegawai = "attendance/kehadiranpegawai";
  String approvalKehadiran = "attendance/approvalKehadiran";
  String rejectKehadiran = "attendance/rejectKehadiran";


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

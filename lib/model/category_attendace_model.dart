import 'dart:io';

import 'package:suzuki/util/network.dart';
import 'package:suzuki/util/system.dart';

class CategoryAttendanceModel {
  int? idAttendance;
  String? kodeAttendance;
  String? attendance;
  String? type;
  int? count;
  int? batasPengajuan;
  int? batasPengajuanBulan;
  String? sex;
  String? pickerDateMode;

  //create constructor
  CategoryAttendanceModel({
    this.idAttendance,
    this.kodeAttendance,
    this.attendance,
    this.type,
    this.sex,
    this.count,
    this.batasPengajuan,
    this.batasPengajuanBulan,
    this.pickerDateMode,
  });

  //create function to get data from json
  factory CategoryAttendanceModel.fromJson(Map<String, dynamic> json) {
    return CategoryAttendanceModel(
      idAttendance: json['id_attendance'] as int?,
      kodeAttendance: json['kode_attendance'] as String?,
      attendance: json['attendance'] as String?,
      type: json['type'] as String?,
      count: json['count'] as int?,
      sex: json['sex'] as String?,
      batasPengajuan: json['batas_pengajuan'] as int?,
      batasPengajuanBulan: json['batas_pengajuan_bulan'] as int?,
      pickerDateMode: json['picker_date_mode'] as String?,
    );
  }

  //create function to json
  Map<String, dynamic> toJson() {
    return {
      'id_attendance': idAttendance,
      'kode_attendance': kodeAttendance,
      'attendance': attendance,
      'type': type,
      'count': count,
      'sex': sex,
      'batas_pengajuan': batasPengajuan,
      'batas_pengajuan_bulan': batasPengajuanBulan,
      'picker_date_mode': pickerDateMode,
    };
  }

  //create function to get data from api
  static Future<List<CategoryAttendanceModel>> getIzinTersedia({
    required String token,
  }) {
    return Network.get(
        url: Uri.parse(
          System.data.apiEndPoint.url + System.data.apiEndPoint.izinTersedia,
        ),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentMD5Header: "application/json",
          HttpHeaders.authorizationHeader: "bearer $token",
        }).then((value) {
      return (value as List)
          .map((e) => CategoryAttendanceModel.fromJson(e))
          .toList();
    }).catchError((onError) {
      throw onError;
    });
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:suzuki/util/network.dart';
import 'package:suzuki/util/system.dart';

class CategoryAttendanceModel {
  int? allowanceId;
  String? namaPegawai;
  int? idAttendance;
  String? kodeAttendance;
  String? attendance;
  int? allowance;
  int? allowanceLeft;
  int? allowanceYear;
  String? type;
  int? count;
  int? batasPengajuan;
  int? batasPengajuanBulan;
  String? sex;
  String? pickerDateMode;
  bool? canNextDate;
  DateTime? expiredDate;
  Color? color;

  //create constructor
  CategoryAttendanceModel({
    this.allowanceId,
    this.namaPegawai,
    this.idAttendance,
    this.kodeAttendance,
    this.attendance,
    this.allowance,
    this.allowanceLeft,
    this.allowanceYear,
    this.type,
    this.sex,
    this.count,
    this.batasPengajuan,
    this.batasPengajuanBulan,
    this.pickerDateMode,
    this.canNextDate,
    this.expiredDate,
    this.color,
  });

  //create function to get data from json
  factory CategoryAttendanceModel.fromJson(Map<String, dynamic> json) {
    return CategoryAttendanceModel(
      allowanceId: json['allowance_id'] as int?,
      namaPegawai: json['nama_pegawai'] as String?,
      idAttendance: json['id_attendance'] as int?,
      kodeAttendance: json['kode_attendance'] as String?,
      attendance: json['attendance'] as String?,
      allowance: json['allowance'] as int?,
      allowanceLeft: json['allowance_left'] as int?,
      allowanceYear: json['allowance_year'] as int?,
      type: json['type'] as String?,
      count: json['count'] as int?,
      sex: json['sex'] as String?,
      batasPengajuan: json['batas_pengajuan'] as int?,
      batasPengajuanBulan: json['batas_pengajuan_bulan'] as int?,
      pickerDateMode: json['picker_date_mode'] as String?,
      canNextDate: (json['can_next_date'] as int?) == 1 ? true : false,
      expiredDate: json['expired_date'] == null
          ? null
          : DateTime.parse(json['expired_date']),
      color: Color(
          int.parse((json['color'] ?? '#6ec4b7').substring(1, 7), radix: 16) +
              0xFF000000),
    );
  }

  //create function to json
  Map<String, dynamic> toJson() {
    return {
      'allowance_id': allowanceId,
      'nama_pegawai': namaPegawai,
      'id_attendance': idAttendance,
      'kode_attendance': kodeAttendance,
      'attendance': attendance,
      'allowance': allowance,
      'allowance_left': allowanceLeft,
      'allowance_year': allowanceYear,
      'type': type,
      'count': count,
      'sex': sex,
      'batas_pengajuan': batasPengajuan,
      'batas_pengajuan_bulan': batasPengajuanBulan,
      'picker_date_mode': pickerDateMode,
      'can_next_date': canNextDate,
      'expired_date': expiredDate?.toIso8601String(),
      'color': color?.value,
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

  //create function to get data from api
  static Future<List<CategoryAttendanceModel>> getCutiTersedia({
    required String token,
  }) {
    return Network.get(
        url: Uri.parse(
          System.data.apiEndPoint.url + System.data.apiEndPoint.cutiTersedia,
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

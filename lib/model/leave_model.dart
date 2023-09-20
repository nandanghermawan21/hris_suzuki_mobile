import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suzuki/util/network.dart';
import 'package:suzuki/util/system.dart';

class LeaveModel {
  int? id; //": 14,
  int? idPegawai; //": 517,
  DateTime? tglPengajuan; //": "2023-09-19 20:06:58.000",
  int? tglPengajuanTimezone; //": 7,
  String? tglPengajuanTimezoneName; //": "WIB",
  String? namaPegawai; //": "ANDRY KURNIAMIREJA",
  String? attendance; //": "Medical",
  String? reason; //": "izin sakit",
  int? idAtasan; //": 724,
  String? namaAtasan; //": "AGNES TRI HASTUTI",
  String? levelAtasan; //": "MANAGER",
  int? jumlahLeave; //": 2,
  List<DateTime?>? tanggalLeave; //": "[\"2023-09-20\",\"2023-09-21\"]",
  Color? color; //": "#6ec4b7",
  String? status; //": "Menunggu Persetujuan",
  int? approvedBy; //": null,
  DateTime? aprrovedDate; //": null
  String? attachment;

  //create contructor
  LeaveModel({
    this.id,
    this.idPegawai,
    this.tglPengajuan,
    this.tglPengajuanTimezone,
    this.tglPengajuanTimezoneName,
    this.namaPegawai,
    this.attendance,
    this.reason,
    this.idAtasan,
    this.namaAtasan,
    this.levelAtasan,
    this.jumlahLeave,
    this.tanggalLeave,
    this.color,
    this.status,
    this.approvedBy,
    this.aprrovedDate,
    this.attachment,
  });

  //create factory
  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'],
      idPegawai: json['id_pegawai'],
      tglPengajuan: json['tgl_pengajuan'] == null
          ? null
          : DateTime.parse(json['tgl_pengajuan']),
      tglPengajuanTimezone: json['tgl_pengajuan_timezone'],
      tglPengajuanTimezoneName: json['tgl_pengajuan_timezone_name'],
      namaPegawai: json['nama_pegawai'],
      attendance: json['attendance'],
      reason: json['reason'],
      idAtasan: json['id_atasan'],
      namaAtasan: json['nama_atasan'],
      levelAtasan: json['level_atasan'],
      jumlahLeave: json['jumlah_leave'],
      tanggalLeave: json['tanggal_leave'] == null
          ? []
          : (jsonDecode(json['tanggal_leave']) as List)
              .map((e) => e == null ? null : DateTime.parse(e))
              .toList(growable: false),
      color: Color(
          int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000),
      status: json['status'],
      approvedBy: json['approved_by'],
      aprrovedDate: json['aprroved_date'] == null
          ? null
          : DateTime.parse(json['aprroved_date']),
      attachment: json['attachment'],
    );
  }

  //create method to json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "id_pegawai": idPegawai,
      "tgl_pengajuan": tglPengajuan?.toIso8601String(),
      "tgl_pengajuan_timezone": tglPengajuanTimezone,
      "tgl_pengajuan_timezone_name": tglPengajuanTimezoneName,
      "nama_pegawai": namaPegawai,
      "attendance": attendance,
      "reason": reason,
      "id_atasan": idAtasan,
      "nama_atasan": namaAtasan,
      "level_atasan": levelAtasan,
      "jumlah_leave": jumlahLeave,
      // ignore: prefer_null_aware_operators
      "tanggal_leave": tanggalLeave == null
          ? null
          : tanggalLeave
              ?.map((e) => e?.toIso8601String())
              .toList(growable: false),
      "color": color?.value.toRadixString(16),
      "status": status,
      "approved_by": approvedBy,
      "aprroved_date": aprrovedDate?.toIso8601String(),
      "attachment": attachment,
    };
  }

  //create mthode get myleave
  static Future<List<LeaveModel>> getMyLeave({
    required String token,
    int? skip = 0,
    int? take = 10,
  }) {
    return Network.get(
      url: Uri.parse(
          "${System.data.apiEndPoint.baseUrl}${System.data.apiEndPoint.myLeave}"),
      querys: {
        "skip": skip.toString(),
        "take": take.toString(),
      },
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    ).then((value) {
      return (value as List)
          .map((e) => LeaveModel.fromJson(e))
          .toList(growable: false);
    }).catchError((onError) {
      throw onError;
    });
  }

  //crete methode get bawahan leave
  static Future<List<LeaveModel>> getBawahanLeave({
    required String token,
    int? skip = 0,
    int? take = 10,
  }) {
    return Network.get(
      url: Uri.parse(
          "${System.data.apiEndPoint.baseUrl}${System.data.apiEndPoint.bawahanLeave}"),
      querys: {
        "skip": skip.toString(),
        "take": take.toString(),
      },
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    ).then((value) {
      return (value as List)
          .map((e) => LeaveModel.fromJson(e))
          .toList(growable: false);
    }).catchError((onError) {
      throw onError;
    });
  }

  //create function to get data from api
  static Future<void> submitIzin({
    required String token,
    required int idAttendance,
    required String reason,
    required List<DateTime> dates,
    String attachment = "",
  }) {
    return Network.post(
        url: Uri.parse(
          System.data.apiEndPoint.url + System.data.apiEndPoint.submitIzin,
        ),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentMD5Header: "application/json",
          HttpHeaders.authorizationHeader: "bearer $token",
        },
        body: {
          "idAttendance": idAttendance,
          "reason": reason,
          "dates":
              dates.map((e) => DateFormat('yyyy-MM-dd').format(e)).toList(),
          "attachment": attachment,
        }).then((value) {
      return;
    }).catchError((onError) {
      throw onError;
    });
  }
}

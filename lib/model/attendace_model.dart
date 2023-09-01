import 'dart:io';

import 'package:suzuki/util/geolocator_util.dart';
import 'package:suzuki/util/network.dart';
import 'package:suzuki/util/system.dart';

class AttendaceModel {
  int? idPegawai; //	integer
  int? idAttendance; //	integer
  int? idLokasiFisik; //	integer
  String? codeAttendance;
  double? lat; //	number($double)
  double? lon; //	number($double)
  String? address; //	string
  DateTime? createdDate; //	string
  int? createdBy;
  bool? approvalStatus;
  String? approvalReason;
  String? approvedBy;
  String? approvedByName;
  String? approvedByJabatan;
  DateTime? approvedDate;



  AttendaceModel({
    this.idPegawai,
    this.idAttendance,
    this.codeAttendance,
    this.idLokasiFisik,
    this.lat,
    this.lon,
    this.address,
    this.createdDate,
    this.createdBy,
    this.approvalStatus,
    this.approvalReason,
    this.approvedBy,
    this.approvedDate,
    this.approvedByName,
    this.approvedByJabatan,
  }); //	string

  //crete from json app
  factory AttendaceModel.fromJson(Map<String, dynamic> json) {
    return AttendaceModel(
      idPegawai: json['id_pegawai'],
      idAttendance: json['id_attendance'],
      codeAttendance: json['code_attendance'],
      idLokasiFisik: json['id_lokasi_fisik'],
      lat: json['lat'],
      lon: json['lon'],
      address: json['address'],
      createdDate: DateTime.parse(json['created_date']),
      createdBy: json['created_by'],
      approvalStatus: json['approval_status'],
      approvalReason: json['approval_reason'],
      approvedBy: json['approved_by'],
      approvedByName: json['approved_by_name'],
      approvedByJabatan: json['approved_by_jabatan'],
      approvedDate: json['approved_date'] == null ? null : DateTime.parse(json['approved_date']),
    );
  }

  //create to json app
  Map<String, dynamic> toJson() => {
        'id_pegawai': idPegawai,
        'id_attendance': idAttendance,
        'id_lokasi_fisik': idLokasiFisik,
        'lat': lat,
        'lon': lon,
        'address': address,
        'created_date': createdDate,
        'created_by': createdBy,
        'approval_status': approvalStatus,
        'approval_reason': approvalReason,
        'approved_by': approvedBy,
        'approved_by_name': approvedByName,
        'approved_by_jabatan': approvedByJabatan,
        'approved_date': approvedDate?.toIso8601String(),
      };

  //crete function chekin
  static Future<AttendaceModel> checkIn({
    String? token,
  }) {
    return GeolocatorUtil.myLocation().then((value) {
      return GeolocatorUtil.getAddress(value.latitude, value.longitude)
          .then((address) {
        return Network.post(
            url: Uri.parse(
              System.data.apiEndPoint.url + System.data.apiEndPoint.checkInUrl,
            ),
            body: {
              "lat": value.latitude,
              "lon": value.longitude,
              "address": address,
            },
            headers: {
              HttpHeaders.acceptHeader: "application/json",
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer $token",
              "Device-Id": System.data.deviceInfo?.deviceId ?? "",
            }).then((attemdamce) {
          return AttendaceModel.fromJson(attemdamce);
        }).catchError((onError) {
          throw onError;
        });
      }).catchError((onError) {
        throw onError;
      });
    }).catchError((onError) {
      throw onError;
    });
  }

  static Future<AttendaceModel> checkOut({
    String? token,
  }) {
    return GeolocatorUtil.myLocation().then((value) {
      return GeolocatorUtil.getAddress(value.latitude, value.longitude)
          .then((address) {
        return Network.post(
            url: Uri.parse(
              System.data.apiEndPoint.url + System.data.apiEndPoint.checkOutUrl,
            ),
            body: {
              "lat": value.latitude,
              "lon": value.longitude,
              "address": address,
            },
            headers: {
              HttpHeaders.acceptHeader: "application/json",
              HttpHeaders.contentTypeHeader: "application/json",
              HttpHeaders.authorizationHeader: "Bearer $token",
              "Device-Id": System.data.deviceInfo?.deviceId ?? "",
            }).then((attemdamce) {
          return AttendaceModel.fromJson(attemdamce);
        }).catchError((onError) {
          throw onError;
        });
      }).catchError((onError) {
        throw onError;
      });
    }).catchError((onError) {
      throw onError;
    });
  }
}

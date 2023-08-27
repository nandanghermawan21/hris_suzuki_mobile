import 'dart:io';

import 'package:suzuki/util/geolocator_util.dart';
import 'package:suzuki/util/network.dart';
import 'package:suzuki/util/system.dart';

class AttendaceModel {
  int? idPegawai; //	integer
  int? idAttendance; //	integer
  int? idLokasiFisik; //	integer
  double? lat; //	number($double)
  double? lon; //	number($double)
  DateTime? createdDate; //	string
  int? createdBy;

  AttendaceModel({
    this.idPegawai,
    this.idAttendance,
    this.idLokasiFisik,
    this.lat,
    this.lon,
    this.createdDate,
    this.createdBy,
  }); //	string

  //crete from json app
  factory AttendaceModel.fromJson(Map<String, dynamic> json) {
    return AttendaceModel(
      idPegawai: json['id_pegawai'],
      idAttendance: json['id_attendance'],
      idLokasiFisik: json['id_lokasi_fisik'],
      lat: json['lat'],
      lon: json['lon'],
      createdDate: DateTime.parse(json['created_date']),
      createdBy: json['created_by'],
    );
  }

  //create to json app
  Map<String, dynamic> toJson() => {
        'id_pegawai': idPegawai,
        'id_attendance': idAttendance,
        'id_lokasi_fisik': idLokasiFisik,
        'lat': lat,
        'lon': lon,
        'created_date': createdDate,
        'created_by': createdBy,
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

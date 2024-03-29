import 'dart:io';

import 'package:intl/intl.dart';
import 'package:suzuki/util/network.dart';
import 'package:suzuki/util/system.dart';

class UserModel {
  int? idUser;
  int? idUserLevel;
  int? idPegawai;
  String? nama;
  String? email;
  String? username;
  String? password;
  String? token;
  String? isAktif;

  UserModel({
    this.idUser,
    this.idUserLevel,
    this.idPegawai,
    this.nama,
    this.email,
    this.username,
    this.password,
    this.token,
    this.isAktif,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json["id_user"] as int?,
      idUserLevel: json["id_user_level"] as int?,
      idPegawai: json["id_pegawai"] as int?,
      nama: json["nama"] as String?,
      email: json["email"] as String?,
      username: json["username"] as String?,
      password: json["password"] as String?,
      token: json["token"] as String?,
      isAktif: json["is_aktif"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_user": idUser,
      "id_user_level": idUserLevel,
      "id_pegawai": idPegawai,
      "nama": nama,
      "email": email,
      "username": username,
      "password": password,
      "token": token,
      "is_aktif": isAktif,
    };
  }

  static Future<UserModel?> login({
    required String? username,
    required String? password,
  }) {
    return Network.post(
      url: Uri.parse(
        System.data.apiEndPoint.url + System.data.apiEndPoint.loginUrl,
      ),
      otpRequired: null,
      body: {
        "username": username ?? "",
        "password": password ?? "",
      },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    ).then((value) {
      return value == null ? null : UserModel.fromJson((value));
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }

  static Future<UserModel?> activasi({
    required String? nip,
    required String? nama,
    required DateTime? tglLahir,
    required DateTime? tglMulaiKerja,
    required String? password,
  }) {
    return Network.post(
      url: Uri.parse(
        System.data.apiEndPoint.url + System.data.apiEndPoint.activasiUrl,
      ),
      otpRequired: null,
      body: {
        "nip": nip ?? "",
        "nama": nama ?? "",
        "tglLahir": tglLahir == null
            ? ""
            : DateFormat("yyyy-MM-dd", System.data.strings!.locale)
                .format(tglLahir),
        "tglMulaiKerja": tglMulaiKerja == null
            ? ""
            : DateFormat("yyyy-MM-dd", System.data.strings!.locale)
                .format(tglMulaiKerja),
        "password": password ?? "",
      },
      headers: {
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentMD5Header: "application/json",
      },
    ).then((value) {
      return value == null ? null : UserModel.fromJson((value));
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}

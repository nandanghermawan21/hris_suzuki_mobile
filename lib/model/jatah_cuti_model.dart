import 'package:flutter/material.dart';

class JatahCutiModel {
  int? idJatahCuti;
  int? tipeCuti;
  int? idPegawai;
  String? namaPegawai;
  String? namaTipeCuti;
  int? jumlahCuti;
  int? sisaCuti;
  DateTime? tangalKadalaursa;
  Color? warnaCuti;

  JatahCutiModel({
    this.idJatahCuti,
    this.tipeCuti,
    this.idPegawai,
    this.namaPegawai,
    this.namaTipeCuti,
    this.jumlahCuti,
    this.sisaCuti,
    this.tangalKadalaursa,
    this.warnaCuti,
  });

  JatahCutiModel.fromJson(Map<String, dynamic> json) {
    idJatahCuti = json['id_jatah_cuti'];
    tipeCuti = json['tipe_cuti'];
    idPegawai = json['id_pegawai'];
    namaPegawai = json['nama_pegawai'];
    namaTipeCuti = json['nama_tipe_cuti'];
    jumlahCuti = json['jumlah_cuti'];
    sisaCuti = json['sisa_cuti'];
    tangalKadalaursa = DateTime.parse(
      json['tanggal_kadaluarsa'],
    );
    warnaCuti = json['warna_cuti'] != null ? Color(json['warna_cuti']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_jatah_cuti'] = idJatahCuti;
    data['tipe_cuti'] = tipeCuti;
    data['id_pegawai'] = idPegawai;
    data['nama_pegawai'] = namaPegawai;
    data['nama_tipe_cuti'] = namaTipeCuti;
    data['jumlah_cuti'] = jumlahCuti;
    data['sisa_cuti'] = sisaCuti;
    data['tanggal_kadaluarsa'] = tangalKadalaursa!.toIso8601String();
    data['icon_cuti'] = warnaCuti;
    data['warna_cuti'] = warnaCuti!.value;
    return data;
  }

  //dummy
  static List<JatahCutiModel> dummy() {
    return [
      JatahCutiModel(
        idJatahCuti: 1,
        tipeCuti: 1,
        idPegawai: 1,
        namaPegawai: "Andry",
        namaTipeCuti: "Tahun Lalu",
        jumlahCuti: 12,
        sisaCuti: 8,
        tangalKadalaursa: DateTime(2023, 6, 30),
        warnaCuti: Colors.tealAccent.shade700
      ),
      JatahCutiModel(
        idJatahCuti: 2,
        tipeCuti: 2,
        idPegawai: 1,
        namaPegawai: "Andry",
        namaTipeCuti: "Tahun Ini",
        jumlahCuti: 12,
        sisaCuti: 12,
        tangalKadalaursa: DateTime(2024, 6, 30),
        warnaCuti: Colors.green.shade900
      ),
      JatahCutiModel(
        idJatahCuti: 2,
        tipeCuti: 2,
        idPegawai: 1,
        namaPegawai: "Andry",
        namaTipeCuti: "Cuti Training & Pelatihan",
        jumlahCuti: 10,
        sisaCuti: 8,
        tangalKadalaursa: DateTime(2024, 6, 30),
        warnaCuti: const Color.fromARGB(224, 6, 47, 107)
      ),
    ];
  }
}

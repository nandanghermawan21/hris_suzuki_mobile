import 'dart:ui';

import 'package:flutter/material.dart';

class PersetujuanAtasanModel {
  int? idPegawai;
  String? namaPegawai;
  int? idJabatan;
  String? namaJabatan;
  int? idPersetujuanStatus;
  String? namaPersetujuanStatus;
  Color? warnaPersetujuanStatus;
  DateTime? tanggalPersetujuan;

  PersetujuanAtasanModel({
    this.idPegawai,
    this.namaPegawai,
    this.idJabatan,
    this.namaJabatan,
    this.idPersetujuanStatus,
    this.namaPersetujuanStatus,
    this.warnaPersetujuanStatus,
    this.tanggalPersetujuan,
  });

  PersetujuanAtasanModel.fromJson(Map<String, dynamic> json) {
    idPegawai = json['id_pegawai'];
    namaPegawai = json['nama_pegawai'];
    idJabatan = json['id_jabatan'];
    namaJabatan = json['nama_jabatan'];
    idPersetujuanStatus = json['id_persetujuan_status'];
    namaPersetujuanStatus = json['nama_persetujuan_status'];
    warnaPersetujuanStatus = json['warna_persetujuan_status'] != null
        ? Color(json['warna_persetujuan_status'])
        : null;
    tanggalPersetujuan = DateTime.parse(json['tanggal_persetujuan']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_pegawai'] = idPegawai;
    data['nama_pegawai'] = namaPegawai;
    data['id_jabatan'] = idJabatan;
    data['nama_jabatan'] = namaJabatan;
    data['id_persetujuan_status'] = idPersetujuanStatus;
    data['nama_persetujuan_status'] = namaPersetujuanStatus;
    data['warna_persetujuan_status'] = warnaPersetujuanStatus!.value;
    data['tanggal_persetujuan'] = tanggalPersetujuan!.toIso8601String();
    return data;
  }

  //dummy
  static List<PersetujuanAtasanModel> getAtasan({
    bool? disetujuiSuperVisor,
    bool? disetujuiManager,
  }) {
    return <PersetujuanAtasanModel>[
      PersetujuanAtasanModel(
        idPegawai: 2,
        namaPegawai: "Susi",
        idJabatan: 2,
        namaJabatan: "Supervisor",
        tanggalPersetujuan: DateTime.now(),
        idPersetujuanStatus: disetujuiSuperVisor == true ? 1 : 0,
        namaPersetujuanStatus:
            disetujuiSuperVisor == true ? "Disetuji" : "Belum Disetujui",
        warnaPersetujuanStatus: disetujuiSuperVisor == true
            ? Colors.green.shade900
            : const Color.fromARGB(255, 211, 89, 22),
      ),
      PersetujuanAtasanModel(
        idPegawai: 1,
        namaPegawai: "Budi",
        idJabatan: 1,
        namaJabatan: "Manager",
        tanggalPersetujuan: DateTime.now(),
        idPersetujuanStatus: disetujuiManager == true ? 1 : 0,
        namaPersetujuanStatus:
            disetujuiManager == true ? "Disetuji" : "Belum Disetujui",
        warnaPersetujuanStatus: disetujuiManager == true
            ? Colors.green.shade900
            : const Color.fromARGB(255, 211, 89, 22),
      ),
    ];
  }
}

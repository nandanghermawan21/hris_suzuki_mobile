import 'package:flutter/material.dart';
import 'package:suzuki/model/psrsetujuan_atasan_model.dart';

class CutiModel {
  int? idCuti;
  DateTime? tanggalPengajuan;
  int? tipeCuti;
  Color? warnaCuti;
  int? idPegawaiPemohon;
  String? namaPegawaiPemohon;
  List<PersetujuanAtasanModel> persetujuanAtasan = [];
  String? namaTipeCuti;
  String? alasanCuti;
  List<DateTime> tanggalCuti = [];
  int? jumlahCuti;
  String? statusCuti;
  Color? warnaStatusCuti;

  CutiModel(
      {this.idCuti,
      this.tanggalPengajuan,
      this.tipeCuti,
      this.warnaCuti,
      this.idPegawaiPemohon,
      this.namaPegawaiPemohon,
      this.persetujuanAtasan = const [],
      this.namaTipeCuti,
      this.alasanCuti,
      this.tanggalCuti = const [],
      this.jumlahCuti,
      this.statusCuti,
      this.warnaStatusCuti});

  CutiModel.fromJson(Map<String, dynamic> json) {
    idCuti = json['id_cuti'];
    tanggalPengajuan = DateTime.parse(json['tanggal_pengajuan']);
    tipeCuti = json['tipe_cuti'];
    warnaCuti = json['warna_cuti'] != null ? Color(json['warna_cuti']) : null;
    idPegawaiPemohon = json['id_pegawai_pemohon'];
    namaPegawaiPemohon = json['nama_pegawai_pemohon'];
    if (json['persetujuan_atasan'] != null) {
      persetujuanAtasan = <PersetujuanAtasanModel>[];
      json['persetujuan_atasan'].forEach((v) {
        persetujuanAtasan.add(PersetujuanAtasanModel.fromJson(v));
      });
    }
    namaTipeCuti = json['nama_tipe_cuti'];
    alasanCuti = json['alasan_cuti'];
    if (json['tanggal_cuti'] != null) {
      tanggalCuti = <DateTime>[];
      json['tanggal_cuti'].forEach((v) {
        tanggalCuti.add(DateTime.parse(v));
      });
    }
    jumlahCuti = json['jumlah_cuti'];
    statusCuti = json['status_cuti'];
    warnaStatusCuti = json['warna_status_cuti'] != null
        ? Color(json['warna_status_cuti'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_cuti'] = idCuti;
    data['tanggal_pengajuan'] = tanggalPengajuan?.toIso8601String();
    data['tipe_cuti'] = tipeCuti;
    data['warna_cuti'] = warnaCuti?.value;
    data['id_pegawai_pemohon'] = idPegawaiPemohon;
    data['nama_pegawai_pemohon'] = namaPegawaiPemohon;
    if (persetujuanAtasan.isNotEmpty) {
      data['persetujuan_atasan'] =
          persetujuanAtasan.map((v) => v.toJson()).toList();
    }
    data['nama_tipe_cuti'] = namaTipeCuti;
    data['alasan_cuti'] = alasanCuti;
    if (tanggalCuti.isNotEmpty) {
      data['tanggal_cuti'] =
          tanggalCuti.map((v) => v.toIso8601String()).toList();
    }
    data['jumlah_cuti'] = jumlahCuti;
    data['status_cuti'] = statusCuti;
    data['warna_status_cuti'] = warnaStatusCuti?.value;
    return data;
  }

  //dummy
  static List<CutiModel> cutiSaya() {
    return [
      CutiModel(
        idCuti: 1,
        tanggalPengajuan: DateTime(2023, 7, 20, 10, 5),
        tipeCuti: 1,
        warnaCuti: Colors.tealAccent.shade700,
        idPegawaiPemohon: 1,
        namaPegawaiPemohon: "Andri",
        persetujuanAtasan: PersetujuanAtasanModel.getAtasan(
          disetujuiSuperVisor: true,
        ),
        namaTipeCuti: "Cuti Tahunan",
        alasanCuti: "Pulang Kampung",
        tanggalCuti: [
          DateTime(2023, 5, 25),
          DateTime(2023, 5, 26),
        ],
        jumlahCuti: 2,
        statusCuti: "Belum Disetujui",
        warnaStatusCuti: const Color.fromARGB(255, 211, 89, 22),
      ),
      CutiModel(
        idCuti: 1,
        tipeCuti: 2,
        tanggalPengajuan: DateTime(2023, 6, 20, 20, 35),
        warnaCuti: const Color.fromARGB(224, 6, 47, 107),
        idPegawaiPemohon: 1,
        namaPegawaiPemohon: "Andri",
        persetujuanAtasan: PersetujuanAtasanModel.getAtasan(
          disetujuiSuperVisor: true,
          disetujuiManager: true,
        ),
        namaTipeCuti: "Cuti Training & Pelatihan",
        alasanCuti: "Pelatihan HSE",
        tanggalCuti: [
          DateTime(2023, 7, 25),
          DateTime(2023, 7, 26),
          DateTime(2023, 7, 27),
        ],
        jumlahCuti: 3,
        statusCuti: "Disetujui",
        warnaStatusCuti: Colors.green.shade900,
      ),
    ];
  }

  static List<CutiModel> butuhPersetujuan() {
    return [
      CutiModel(
        idCuti: 1,
        tanggalPengajuan: DateTime(2023, 5, 20, 20, 25),
        tipeCuti: 1,
        idPegawaiPemohon: 1,
        namaPegawaiPemohon: "Budi",
        persetujuanAtasan: PersetujuanAtasanModel.getAtasan(
          disetujuiSuperVisor: true,
        ),
        namaTipeCuti: "Cuti Tahunan",
        warnaCuti: Colors.tealAccent.shade700,
        alasanCuti: "Pulang Kampung",
        tanggalCuti: [
          DateTime(2023, 5, 25),
          DateTime(2023, 5, 26),
        ],
        jumlahCuti: 2,
        statusCuti: "Belum Disetujui",
        warnaStatusCuti: const Color.fromARGB(255, 211, 89, 22),
      ),
      CutiModel(
        idCuti: 1,
        tipeCuti: 2,
        tanggalPengajuan: DateTime(2023, 6, 20, 18, 45),
        idPegawaiPemohon: 1,
        namaPegawaiPemohon: "Dahlan",
        persetujuanAtasan: PersetujuanAtasanModel.getAtasan(
          disetujuiSuperVisor: true,
          disetujuiManager: true,
        ),
        namaTipeCuti: "Cuti Menikah",
        warnaCuti: const Color.fromARGB(224, 6, 47, 107),
        alasanCuti: "Cuti Training & Pelatihan",
        tanggalCuti: [
          DateTime(2023, 7, 25),
          DateTime(2023, 7, 26),
          DateTime(2023, 7, 27),
        ],
        jumlahCuti: 3,
        statusCuti: "Disetujui",
        warnaStatusCuti: Colors.green.shade900,
      ),
    ];
  }
}

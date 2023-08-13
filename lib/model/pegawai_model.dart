import 'dart:io';

import 'package:suzuki/util/network.dart';
import 'package:suzuki/util/system.dart';

class PegawaiModel {
  int? id;
  String? nip;
  String? namaPegawai;
  String? filePhoto;
  int? idJabatan;
  String? namaJabatan;
  String? groupingJabatan;
  String? kodeCostCenter;
  String? costCenter;
  String? namaPilar;
  String? namaDirektorat;
  String? divisi;
  String? departemen;
  int? idArea;
  String? area;
  int? idCabang;
  String? cabang;
  String? levelGol;
  String? level;
  String? homebase;
  String? statusKerja;
  String? lokasiFisik;
  String? lokasiKerja;
  DateTime? startDate;
  String? tglMulaiKontrak;
  String? tglAkhirKontrak;
  String? grading;
  String? masaKerja;
  String? masaKerjaKontrak;
  String? umur;
  DateTime? retirementDate;
  String? jenisKelamin;
  String? agama;
  String? fungsiOJK;
  String? groupLocation;
  String? lingkupBisnis;
  String? namaBank;
  String? noRekBank;
  String? namaPemilikBank;
  DateTime? terminateDate;
  int? masaPensiun;
  String? emailPribadi;
  String? emailKantor;
  String? emergencyCall;
  String? telephoneHp;
  String? alamatDomisili;
  String? alamatKtp;
  String? ptkp;
  String? npwp;
  String? nikKtp;
  DateTime? tanggalLahir;

  PegawaiModel({
    this.id,
    this.nip,
    this.namaPegawai,
    this.filePhoto,
    this.idJabatan,
    this.namaJabatan,
    this.groupingJabatan,
    this.kodeCostCenter,
    this.costCenter,
    this.namaPilar,
    this.namaDirektorat,
    this.divisi,
    this.departemen,
    this.idArea,
    this.area,
    this.idCabang,
    this.cabang,
    this.levelGol,
    this.level,
    this.homebase,
    this.statusKerja,
    this.lokasiFisik,
    this.lokasiKerja,
    this.startDate,
    this.tglMulaiKontrak,
    this.tglAkhirKontrak,
    this.grading,
    this.masaKerja,
    this.masaKerjaKontrak,
    this.umur,
    this.retirementDate,
    this.jenisKelamin,
    this.agama,
    this.fungsiOJK,
    this.groupLocation,
    this.lingkupBisnis,
    this.namaBank,
    this.noRekBank,
    this.namaPemilikBank,
    this.terminateDate,
    this.masaPensiun,
    this.emailPribadi,
    this.emailKantor,
    this.emergencyCall,
    this.telephoneHp,
    this.alamatDomisili,
    this.alamatKtp,
    this.ptkp,
    this.npwp,
    this.nikKtp,
    this.tanggalLahir,
  });

  factory PegawaiModel.fromJson(Map<String, dynamic> json) {
    return PegawaiModel(
      id: json["id_pegawai"] as int?,
      nip: json["nip"] as String?,
      namaPegawai: json["nama_pegawai"] as String?,
      // filePhoto: json["file_photo"] as String?,
      filePhoto:
          "https://media.istockphoto.com/id/1338134319/photo/portrait-of-young-indian-businesswoman-or-school-teacher-pose-indoors.jpg?s=612x612&w=0&k=20&c=Dw1nKFtnU_Bfm2I3OPQxBmSKe9NtSzux6bHqa9lVZ7A=",
      idJabatan: json["id_jabatan"] as int?,
      namaJabatan: json["nama_jabatan"] as String?,
      groupingJabatan: json["Grouping_Jabatan"] as String?,
      kodeCostCenter: json["kode_cost_center"] as String?,
      costCenter: json["cost_center"] as String?,
      namaPilar: json["nama_pilar"] as String?,
      namaDirektorat: json["nama_direktorat"] as String?,
      divisi: json["divisi"] as String?,
      departemen: json["departemen"] as String?,
      idArea: json["id_area"] as int?,
      area: json["area"] as String?,
      idCabang: json["id_cabang"] as int?,
      cabang: json["cabang"] as String?,
      levelGol: json["level_gol"] as String?,
      level: json["level"] as String?,
      homebase: json["homebase"] as String?,
      statusKerja: json["status_kerja"] as String?,
      lokasiFisik: json["lokasi_fisik"] as String?,
      lokasiKerja: json["lokasi_kerja"] as String?,
      startDate: json["start_date"] == null
          ? null
          : DateTime.parse(json["start_date"] as String),
      tglMulaiKontrak: json["tgl_mulai_kontrak"] as String?,
      tglAkhirKontrak: json["tgl_akhir_kontrak"] as String?,
      grading: json["grading"] as String?,
      masaKerja: json["masa_kerja"] as String?,
      masaKerjaKontrak: json["masa_kerja_kontrak"] as String?,
      umur: json["umur"] as String?,
      retirementDate: json["retirement_date"] == null
          ? null
          : DateTime.parse(json["retirement_date"] as String),
      jenisKelamin: json["jenis_kelamin"] as String?,
      agama: json["agama"] as String?,
      fungsiOJK: json["fungsi_ojk"] as String?,
      groupLocation: json["group_location"] as String?,
      lingkupBisnis: json["lingkup_bisnis"] as String?,
      namaBank: json["nama_bank"] as String?,
      noRekBank: json["no_rek_bank"] as String?,
      namaPemilikBank: json["nama_pemilik_bank"] as String?,
      terminateDate: json["terminate_date"] == null
          ? null
          : DateTime.parse(json["terminate_date"] as String),
      emailKantor: json["email_kantor"] as String?,
      emailPribadi: json["email_pribadi"] as String?,
      masaPensiun: json["masa_pensiun"] as int?,
      emergencyCall: json["emergency_call"] as String?,
      telephoneHp: json["telephone_hp"] as String?,
      alamatDomisili: json["alamat_domisili"] as String?,
      alamatKtp: json["alamat_ktp"] as String?,
      ptkp: json["ptkp"] as String?,
      npwp: json["npwp"] as String?,
      nikKtp: json["nik_ktp"] as String?,
      tanggalLahir: json["tanggal_lahir"] == null
          ? null
          : DateTime.parse(json["tanggal_lahir"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_pegawai": id,
      "nip": nip,
      "nama_pegawai": namaPegawai,
      "file_photo": filePhoto,
      "id_jabatan": idJabatan,
      "nama_jabatan": namaJabatan,
      "Grouping_Jabatan": groupingJabatan,
      "kode_cost_center": kodeCostCenter,
      "cost_center": costCenter,
      "nama_pilar": namaPilar,
      "nama_direktorat": namaDirektorat,
      "divisi": divisi,
      "departemen": departemen,
      "id_area": idArea,
      "area": area,
      "id_cabang": idCabang,
      "cabang": cabang,
      "level_gol": levelGol,
      "level": level,
      "homebase": homebase,
      "status_kerja": statusKerja,
      "lokasi_fisik": lokasiFisik,
      "lokasi_kerja": lokasiKerja,
      "start_date": startDate,
      "tgl_mulai_kontrak": tglMulaiKontrak,
      "tgl_akhir_kontrak": tglAkhirKontrak,
      "grading": grading,
      "masa_kerja": masaKerja,
      "masa_kerja_kontrak": masaKerjaKontrak,
      "umur": umur,
      "retirement_date": retirementDate,
      "jenis_kelamin": jenisKelamin,
      "agama": agama,
      "fungsi_ojk": fungsiOJK,
      "group_location": groupLocation,
      "lingkup_bisnis": lingkupBisnis,
      "nama_bank": namaBank,
      "no_rek_bank": noRekBank,
      "nama_pemilik_bank": namaPemilikBank,
      "terminate_date": terminateDate,
      "email_kantor": emailKantor,
      "email_pribadi": emailPribadi,
      "masa_pensiun": masaPensiun,
      "emergency_call": emergencyCall,
      "telephone_hp": telephoneHp,
      "alamat_domisili": alamatDomisili,
      "alamat_ktp": alamatKtp,
      "ptkp": ptkp,
      "npwp": npwp,
      "nik_ktp": nikKtp,
    };
  }

  //create funtion get profile
  static Future<PegawaiModel> myProfile({
    String? token,
  }) {
    return Network.get(
        url: Uri.parse(
          System.data.apiEndPoint.url + System.data.apiEndPoint.pegawaiProfile,
        ),
        headers: {
          HttpHeaders.acceptHeader: "application/json",
          HttpHeaders.contentMD5Header: "application/json",
          HttpHeaders.authorizationHeader: "bearer $token",
        }).then((value) {
      return PegawaiModel.fromJson(value);
    }).catchError((onError) {
      throw onError;
    });
  }
}

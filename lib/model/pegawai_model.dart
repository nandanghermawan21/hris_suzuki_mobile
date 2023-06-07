import 'dart:io';

import 'package:suzuki/util/network.dart';
import 'package:suzuki/util/system.dart';

class PegawaiModel {
  final int? idPegawai; //": 626,
  final int? idJabatan; //": 155,
  final int? idDivisi; //": 14,
  final int? idDep; //": 39,
  final int? idCabang; //": 54,
  final int? idLokasiFisik; //": 48,
  final int? idLokasiKerja; //": 4,
  final int? idLevelGol; //": 28,
  final int? idHomebase; //": 66,
  final int? idLingkupisnis; //": 3,
  final int? idStatusKerja; //": 1,
  final int? idAgama; //": 4,
  final String? nip; //": "2014.05.16125",
  final String? namaPegawai; //": "ALEX SULISTIYADI",
  final String? inisial; //": null,
  final String? wargaNeg; //": null,
  final String? tempatLahir; //": null,
  final String? tglLahir; //": null,
  final DateTime? tglMulaiKerja; //": "2014-05-02",
  final String? tglMulaiKontrak; //": null,
  final String? tglAkhirKontrak; //": null,
  final DateTime? tglPengangkatan; //": "2015-05-01",
  final String? tglBerhentiKerja; //": null,
  final String? masaKerja; //": "08 year(s) 11 month(s)",
  final String? groupMasaKerja; //": "7 - 9 Tahun",
  final String? umur; //": "33 year(s) 09 month(s)",
  final String? groupUmur; //": "31 - 35",
  final String? jenisKelamin; //": "MALE",
  final String? pendidikan; //": "S1",
  final String? pendidikanJurusan; //": "ILMU KEOLAHRAGAAN",
  final String? pendidikanInstitusi; //": "UNIVERSITAS NEGERI YOGYAKARTA",
  final String? jenjangOjk; //": "SARJANA",
  final String? statusPerkawinan; //": null,
  final String? golDarah; //": null,
  final String? noTelp; //": null,
  final String? noNp; //": null,
  final String? email; //": null,
  final String? alamat; //": null,
  final String? rt; //": null,
  final String? rw; //": null,
  final String? kel; //": null,
  final String? kec; //": null,
  final int? idCountry; //": null,
  final int? idProvinsi; //": null,
  final int? idKota; //": null,
  final String? kodepos; //": null,
  final String? noRekBank; //": null,
  final String? namaRekBank; //": null,
  final String? namaBank; //": null,
  final String? noPaspor; //": null,
  final String? filePaspor; //": null,
  final String? noKtp; //": null,
  final String? fileKtp; //": null,
  final String? noBpjs; //": null,
  final String? fileBpjs; //": null,
  final String? npwp; //": null,
  final String? fileNpwp; //": null,
  final String? idStatusPajak; //": null,
  final String? jmlAnak; //": null,
  final String? jmlTanggungan; //": null,
  final String? filePhoto; //": null,
  final String? namaIbuKandung; //": null,
  final String? namaDarurat; //": null,
  final String? notelpDarurat; //": null,
  final String? ptkp; //": null,
  final String? statusVaksin; //": null,
  final String? fileKartuKeluarga; //": null,
  final String? fileCv; //": null,
  final String? fileSuratLamaran; //": null,
  final String? fileSkck; //": null,
  final String? fileSuratKetSehat; //": null,
  final String? fileSuratRekomKel; //": null,
  final String? fileSuratRekomKerja; //": null,
  final String? berkasLainnya; //": null,
  final DateTime? createDate; //": null,
  final DateTime? updateDate; //": null,
  final int? updateIdUser; //": null,
  final String? idGroupLocation;

  PegawaiModel({
    this.idPegawai,
    this.idJabatan,
    this.idDivisi,
    this.idDep,
    this.idCabang,
    this.idLokasiFisik,
    this.idLokasiKerja,
    this.idLevelGol,
    this.idHomebase,
    this.idLingkupisnis,
    this.idStatusKerja,
    this.idAgama,
    this.nip,
    this.namaPegawai,
    this.inisial,
    this.wargaNeg,
    this.tempatLahir,
    this.tglLahir,
    this.tglMulaiKerja,
    this.tglMulaiKontrak,
    this.tglAkhirKontrak,
    this.tglPengangkatan,
    this.tglBerhentiKerja,
    this.masaKerja,
    this.groupMasaKerja,
    this.umur,
    this.groupUmur,
    this.jenisKelamin,
    this.pendidikan,
    this.pendidikanJurusan,
    this.pendidikanInstitusi,
    this.jenjangOjk,
    this.statusPerkawinan,
    this.golDarah,
    this.noTelp,
    this.noNp,
    this.email,
    this.alamat,
    this.rt,
    this.rw,
    this.kel,
    this.kec,
    this.idCountry,
    this.idProvinsi,
    this.idKota,
    this.kodepos,
    this.noRekBank,
    this.namaRekBank,
    this.namaBank,
    this.noPaspor,
    this.filePaspor,
    this.noKtp,
    this.fileKtp,
    this.noBpjs,
    this.fileBpjs,
    this.npwp,
    this.fileNpwp,
    this.idStatusPajak,
    this.jmlAnak,
    this.jmlTanggungan,
    this.filePhoto,
    this.namaIbuKandung,
    this.namaDarurat,
    this.notelpDarurat,
    this.ptkp,
    this.statusVaksin,
    this.fileKartuKeluarga,
    this.fileCv,
    this.fileSuratLamaran,
    this.fileSkck,
    this.fileSuratKetSehat,
    this.fileSuratRekomKel,
    this.fileSuratRekomKerja,
    this.berkasLainnya,
    this.createDate,
    this.updateDate,
    this.updateIdUser,
    this.idGroupLocation,
  });

  //create function from json
  factory PegawaiModel.fromJson(Map<String, dynamic> json) {
    return PegawaiModel(
      idPegawai: json["id_pegawai"] as int?,
      idJabatan: json["id_jabatan"] as int?,
      idDivisi: json["id_divisi"] as int?,
      idDep: json["id_dep"] as int?,
      idCabang: json["id_cabang"] as int?,
      idLokasiFisik: json["id_lokasi_fisik"] as int?,
      idLokasiKerja: json["id_lokasi_kerja"] as int?,
      idLevelGol: json["id_level_gol"] as int?,
      idHomebase: json["id_homebase"] as int?,
      idLingkupisnis: json["id_lingkup_bisnis"] as int?,
      idStatusKerja: json["id_status_kerja"] as int?,
      idAgama: json["id_agama"] as int?,
      nip: json["nip"] as String?,
      namaPegawai: json["nama_pegawai"] as String?,
      inisial: json["inisial"] as String?,
      wargaNeg: json["warga_neg"] as String?,
      tempatLahir: json["tempat_lahir"] as String?,
      tglLahir: json["tgl_lahir"] as String?,
      tglMulaiKerja: DateTime.parse(json["tgl_mulai_kerja"]),
      tglMulaiKontrak: json["tgl_mulai_kontrak"] as String?,
      tglAkhirKontrak: json["tgl_akhir_kontrak"] as String?,
      tglPengangkatan: DateTime.parse(json["tgl_pengangkatan"]),
      tglBerhentiKerja: json["tgl_berhenti_kerja"] as String?,
      masaKerja: json["masa_kerja"] as String?,
      groupMasaKerja: json["group_masa_kerja"] as String?,
      umur: json["umur"] as String?,
      groupUmur: json["group_umur"] as String?,
      jenisKelamin: json["jenis_kelamin"] as String?,
      pendidikan: json["pendidikan"] as String?,
      pendidikanJurusan: json["pendidikan_jurusan"] as String?,
      pendidikanInstitusi: json["pendidikan_institusi"] as String?,
      jenjangOjk: json["jenjang_ojk"] as String?,
      statusPerkawinan: json["status_perkawinan"] as String?,
      golDarah: json["gol_darah"] as String?,
      noTelp: json["no_telp"] as String?,
      noNp: json["no_hp"] as String?,
      email: json["email"] as String?,
      alamat: json["alamat"] as String?,
      rt: json["rt"] as String?,
      rw: json["rw"] as String?,
      kel: json["kel"] as String?,
      kec: json["kec"] as String?,
      idCountry: json["id_country"] as int?,
      idProvinsi: json["id_provinsi"] as int?,
      idKota: json["id_kota"] as int?,
      kodepos: json["kodepos"] as String?,
      noRekBank: json["no_rek_bank"] as String?,
      namaRekBank: json["nama_rek_bank"] as String?,
      namaBank: json["nama_bank"] as String?,
      noPaspor: json["no_paspor"] as String?,
      filePaspor: json["file_paspor"] as String?,
      noKtp: json["no_ktp"] as String?,
      fileKtp: json["file_ktp"] as String?,
      noBpjs: json["no_bpjs"] as String?,
      fileBpjs: json["file_bpjs"] as String?,
      npwp: json["npwp"] as String?,
      fileNpwp: json["file_npwp"] as String?,
      idStatusPajak: json["id_status_pajak"] as String?,
      jmlAnak: json["jml_anak"] as String?,
      jmlTanggungan: json["jml_tanggungan"] as String?,
      filePhoto: json["file_photo"] as String?,
      namaIbuKandung: json["nama_ibu_kandung"] as String?,
      namaDarurat: json["nama_darurat"] as String?,
      notelpDarurat: json["no_telp_darurat"] as String?,
      ptkp: json["ptkp"] as String?,
      statusVaksin: json["status_vaksin"] as String?,
      fileKartuKeluarga: json["file_kartu_keluarga"] as String?,
      fileCv: json["file_cv"] as String?,
      fileSuratLamaran: json["file_surat_lamaran"] as String?,
      fileSkck: json["file_skck"] as String?,
      fileSuratKetSehat: json["file_surat_ket_sehat"] as String?,
      fileSuratRekomKel: json["file_surat_rekom_kel"] as String?,
      fileSuratRekomKerja: json["file_surat_rekom_kerja"] as String?,
      berkasLainnya: json["berkas_lainnya"] as String?,
      createDate: DateTime.parse(json["create_date"]),
      updateDate: DateTime.parse(json["update_date"]),
      updateIdUser: (json["update_id_user"]) as int?,
      idGroupLocation: json["id_group_location"] as String?,
    );
  }

  //create to json
  Map<String, dynamic> toJson() {
    return {
      "id_pegawai": idPegawai,
      "id_jabatan": idJabatan,
      "id_divisi": idDivisi,
      "id_dep": idDep,
      "id_cabang": idCabang,
      "id_lokasi_fisik": idLokasiFisik,
      "id_lokasi_kerja": idLokasiKerja,
      "id_level_gol": idLevelGol,
      "id_homebase": idHomebase,
      "id_lingkup_bisnis": idLingkupisnis,
      "id_status_kerja": idStatusKerja,
      "id_agama": idAgama,
      "nip": nip,
      "nama_pegawai": namaPegawai,
      "inisial": inisial,
      "warga_neg": wargaNeg,
      "tempat_lahir": tempatLahir,
      "tgl_lahir": tglLahir,
      "tgl_mulai_kerja": tglMulaiKerja,
      "tgl_mulai_kontrak": tglMulaiKontrak,
      "tgl_akhir_kontrak": tglAkhirKontrak,
      "tgl_pengangkatan": tglPengangkatan,
      "tgl_berhenti_kerja": tglBerhentiKerja,
      "masa_kerja": masaKerja,
      "group_masa_kerja": groupMasaKerja,
      "umur": umur,
      "group_umur": groupUmur,
      "jenis_kelamin": jenisKelamin,
      "pendidikan": pendidikan,
      "pendidikan_jurusan": pendidikanJurusan,
      "pendidikan_institusi": pendidikanInstitusi,
      "jenjang_ojk": jenjangOjk,
      "status_perkawinan": statusPerkawinan,
      "gol_darah": golDarah,
      "no_telp": noTelp,
      "no_hp": noNp,
      "email": email,
      "alamat": alamat,
      "rt": rt,
      "rw": rw,
      "kel": kel,
      "kec": kec,
      "id_country": idCountry,
      "id_provinsi": idProvinsi,
      "id_kota": idKota,
      "kodepos": kodepos,
      "no_rek_bank": noRekBank,
      "nama_rek_bank": namaRekBank,
      "nama_bank": namaBank,
      "no_paspor": noPaspor,
      "file_paspor": filePaspor,
      "no_ktp": noKtp,
      "file_ktp": fileKtp,
      "no_bpjs": noBpjs,
      "file_bpjs": fileBpjs,
      "npwp": npwp,
      "file_npwp": fileNpwp,
      "id_status_pajak": idStatusPajak,
      "jml_anak": jmlAnak,
      "jml_tanggungan": jmlTanggungan,
      "file_photo": filePhoto,
      "nama_ibu_kandung": namaIbuKandung,
      "nama_darurat": namaDarurat,
      "no_telp_darurat": notelpDarurat,
      "ptkp": ptkp,
      "status_vaksin": statusVaksin,
      "file_kartu_keluarga": fileKartuKeluarga,
      "file_cv": fileCv,
      "file_surat_lamaran": fileSuratLamaran,
      "file_skck": fileSkck,
      "file_surat_ket_sehat": fileSuratKetSehat,
      "file_surat_rekom_kel": fileSuratRekomKel,
      "file_surat_rekom_kerja": fileSuratRekomKerja,
      "berkas_lainnya": berkasLainnya,
      "create_date": createDate,
      "update_date": updateDate,
      "update_id_user": updateIdUser,
      "id_group_location": idGroupLocation,
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

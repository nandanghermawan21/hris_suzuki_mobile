import 'package:suzuki/model/attendace_model.dart';

class KehadiranModel {
  int? pegawaiId;
  String? namaPegawai;
  String? fotoPegawai;
  int? jabatanId;
  String? namaJabatan;
  DateTime? tanggal;
  int? statusKehadiranId;
  String? namaStatusKehadiran;
  String? kodeStatusKehadiran;
  DateTime? jamMasuk;
  DateTime? jamKeluar;
  List<AttendaceModel> kehadiran = [];

  KehadiranModel({
    this.pegawaiId,
    this.namaPegawai,
    this.fotoPegawai,
    this.jabatanId,
    this.namaJabatan,
    this.tanggal,
    this.statusKehadiranId,
    this.namaStatusKehadiran,
    this.kodeStatusKehadiran,
    this.jamMasuk,
    this.jamKeluar,
    this.kehadiran = const [],
  });

  KehadiranModel.fromJson(Map<String, dynamic> json) {
    pegawaiId = json['pegawai_id'];
    namaPegawai = json['nama_pegawai'];
    fotoPegawai = json['foto_pegawai'];
    jabatanId = json['jabatan_id'];
    namaJabatan = json['nama_jabatan'];
    tanggal = DateTime.parse(json['tanggal']);
    statusKehadiranId = json['status_kehadiran_id'];
    namaStatusKehadiran = json['nama_status_kehadiran'];
    kodeStatusKehadiran = json['kode_status_kehadiran'];
    jamMasuk =
        json['jam_masuk'] != null ? DateTime.parse(json['jam_masuk']) : null;
    jamKeluar =
        json['jam_keluar'] != null ? DateTime.parse(json['jam_keluar']) : null;
    if (json['kehadiran'] != null) {
      kehadiran = <AttendaceModel>[];
      json['kehadiran'].forEach((v) {
        kehadiran.add(AttendaceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pegawai_id'] = pegawaiId;
    data['nama_pegawai'] = namaPegawai;
    data['foto_pegawai'] = fotoPegawai;
    data['jabatan_id'] = jabatanId;
    data['nama_jabatan'] = namaJabatan;
    data['tanggal'] = tanggal!.toIso8601String();
    data['status_kehadiran_id'] = statusKehadiranId;
    data['nama_status_kehadiran'] = namaStatusKehadiran;
    data['kode_status_kehadiran'] = kodeStatusKehadiran;
    data['jam_masuk'] = jamMasuk!.toIso8601String();
    data['jam_keluar'] = jamKeluar!.toIso8601String();
    if (kehadiran.isNotEmpty) {
      data['kehadiran'] = kehadiran.map((v) => v.toJson()).toList();
    }
    return data;
  }

  //dummy
  static List<KehadiranModel> dunnyKehadiranSaya() {
    return [
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'ANDRY',
        jabatanId: 1,
        namaJabatan: 'Manager',
        tanggal: DateTime.now().add(const Duration(days: 0)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 30, 0),
        // jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
        //     DateTime.now().day, 17, 30, 0),
        kehadiran: [],
      ),
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'ANDRY',
        jabatanId: 1,
        namaJabatan: 'Manager',
        tanggal: DateTime.now().add(const Duration(days: -1)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 30, 0),
        jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 30, 0),
        kehadiran: [],
      ),
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'ANDRY',
        jabatanId: 1,
        namaJabatan: 'Manager',
        tanggal: DateTime.now().add(const Duration(days: -2)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 30, 0),
        jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 30, 0),
        kehadiran: [],
      ),
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'ANDRY',
        jabatanId: 1,
        namaJabatan: 'Manager',
        tanggal: DateTime.now().add(const Duration(days: -3)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 30, 0),
        jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 30, 0),
        kehadiran: [],
      ),
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'ANDRY',
        jabatanId: 1,
        namaJabatan: 'Manager',
        tanggal: DateTime.now().add(const Duration(days: -4)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 30, 0),
        jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 30, 0),
        kehadiran: [],
      ),
    ];
  }

   static List<KehadiranModel> dunnyKehadiranPegawai() {
    return [
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'Ajeung Setia Asih',
        fotoPegawai: "https://media.licdn.com/dms/image/C5603AQEAJQgSTZBMWQ/profile-displayphoto-shrink_800_800/0/1660585228914?e=2147483647&v=beta&t=7E8PVS7yr9XOBW4O5OKVqZGY2xgjQNPG1_l3D3S1VVI",
        jabatanId: 1,
        namaJabatan: 'Manager',
        tanggal: DateTime.now().add(const Duration(days: 0)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 30, 0),
        // jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
        //     DateTime.now().day, 17, 30, 0),
        kehadiran: [],
      ),
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'Silvia Hutabarat',
        fotoPegawai: "https://dev.dent.maranatha.edu/wp-content/uploads/elementor/thumbs/dosen-Silvia-Naliani-2-q23gwzb9t4w7m1fzdh9ktlhv27zr35kdjkds20gglc.png",
        jabatanId: 1,
        namaJabatan: 'Manager',
        tanggal: DateTime.now().add(const Duration(days: 0)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 30, 0),
        // jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
        //     DateTime.now().day, 7, 30, 0),
        kehadiran: [],
      ),
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'Merriam Bell-Akram',
        fotoPegawai: "https://www.pdsoros.org/uploads/attachments/a205file807242155170978344-150204-delgado-daniela-002-v2.full.jpg",
        jabatanId: 1,
        namaJabatan: 'Staff',
        tanggal: DateTime.now().add(const Duration(days: 0)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 30, 0),
        // jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
        //     DateTime.now().day, 17, 30, 0),
        kehadiran: [],
      ),
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'Ahmad Nurhadi',
        fotoPegawai: 'https://pbs.twimg.com/profile_images/1581814823960334337/vUPWAr_g_400x400.jpg',
        jabatanId: 1,
        namaJabatan: 'Staff',
        tanggal: DateTime.now().add(const Duration(days: 0)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 30, 0),
        // jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
        //     DateTime.now().day, 17, 30, 0),
        kehadiran: [],
      ),
      KehadiranModel(
        pegawaiId: 1,
        namaPegawai: 'Ahlan Salmanan',
        fotoPegawai: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5wTArJoHbhK8TiNOnDMISBL2CS8OusDHb6qMCDy-y0_4ttm6QAFhZteWdDyFtzy9f2ro&usqp=CAU",
        jabatanId: 1,
        namaJabatan: 'Staff',
        tanggal: DateTime.now().add(const Duration(days: 0)),
        statusKehadiranId: 1,
        namaStatusKehadiran: 'Hadir Tepat Waktu',
        kodeStatusKehadiran: 'HDR',
        jamMasuk: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 7, 30, 0),
        // jamKeluar: DateTime(DateTime.now().year, DateTime.now().month,
        //     DateTime.now().day, 17, 30, 0),
        kehadiran: [],
      ),
    ];
  }
}

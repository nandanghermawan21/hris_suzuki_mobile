class TipeCutiModel {
  int? id;
  String? code;
  String? nama;
  bool? rangeMode;

  TipeCutiModel({
    this.id,
    this.code,
    this.nama,
    this.rangeMode,
  });

  TipeCutiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nama = json['nama'];
    rangeMode = json['range_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['nama'] = nama;
    data['range_mode'] = rangeMode;
    return data;
  }

  static List<TipeCutiModel> dummy() {
    return [
      TipeCutiModel(
        id: 1,
        code: "CUTI",
        nama: "Cuti Tahunan",
        rangeMode: false,
      ),
      TipeCutiModel(
        id: 2,
        code: "TRN",
        nama: "Training & Pelatihan",
        rangeMode: true,
      ),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:suzuki/model/tipe_cuti_model.dart';

class FormCutiViewModel extends ChangeNotifier {
  DateTime? focusedDay;
  DateTime? rangeStartDay;
  DateTime? rangeEndDay;
  TipeCutiModel tipeCuti = TipeCutiModel();
  int? tipeCutiId;
  List<DateTime> tanggalCuti = [];
  TextEditingController alasanCuti = TextEditingController();

  void commit() {
    notifyListeners();
  }
}

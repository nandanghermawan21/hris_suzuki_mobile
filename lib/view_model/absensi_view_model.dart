import 'package:flutter/material.dart';

class AbsensiViewModel extends ChangeNotifier {
  DateTime tanggalKehadiranKaryawan = DateTime.now();

  void commit(){
    notifyListeners();
  }
}
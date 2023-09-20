import 'package:flutter/material.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/model/kehadiran_model.dart';
import 'package:suzuki/util/error_handling_util.dart';
import 'package:suzuki/util/system.dart';

class AbsensiViewModel extends ChangeNotifier {
  DateTime tanggalKehadiranKaryawan = DateTime.now();
  int bulanTerpilih = DateTime.now().month;
  int tahunTerpilih = DateTime.now().year;

  //laoding controller untuk popup reject kehadiran
  CircularLoaderController rejectKehadiranControler =
      CircularLoaderController();

  TextEditingController alasanController = TextEditingController();

  void rejectKehadiran(BuildContext context, int idKehadiran, String alasan) {
    rejectKehadiranControler.startLoading();
    KehadiranModel.rejectKehadiran(
      token: System.data.global.token ?? "",
      idKehadiran: idKehadiran,
      alasan: alasan,
    ).then((value) {
      rejectKehadiranControler.stopLoading(
          message: "Kehadiran berhasil di reject",
          onCloseCallBack: () {
            Navigator.of(context).pop();
            commit();
          });
    }).catchError((onError) {
      rejectKehadiranControler.stopLoading(
        isError: true,
        message:
            "Kehadiran gagal di reject \n ${ErrorHandlingUtil.handleApiError(onError)}",
      );
    });
  }

  void commit() {
    notifyListeners();
  }
}

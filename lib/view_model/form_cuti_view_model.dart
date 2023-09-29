import 'dart:async';

import 'package:flutter/material.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/component/image_picker_component.dart';
import 'package:suzuki/model/category_attendace_model.dart';
import 'package:suzuki/model/leave_model.dart';
import 'package:suzuki/util/error_handling_util.dart';
import 'package:suzuki/util/system.dart';

class FormCutiViewModel extends ChangeNotifier {
  CircularLoaderController loadingController = CircularLoaderController();

  DateTime? focusedDay;
  DateTime? rangeStartDay;
  DateTime? rangeEndDay;
  CategoryAttendanceModel selectedCategoryAttendance =
      CategoryAttendanceModel();
  StreamController<CategoryAttendanceModel>
      selectedCategoryAttendanceController =
      StreamController<CategoryAttendanceModel>.broadcast();
  String? leaveType;
  StreamController<String> leaveTypeController =
      StreamController<String>.broadcast();
  int? leaveId;
  List<DateTime> tanggalCuti = [];
  TextEditingController alasanCuti = TextEditingController();
  ImagePickerController attachmentController = ImagePickerController();

  void submitIzin({VoidCallback? onSuccess}) {
    if (leaveType == null) {
      loadingController.stopLoading(
        message: "Mohon pilih tipe formulir",
        isError: true,
      );
      return;
    }

    if (leaveId == null) {
      loadingController.stopLoading(
        message: "Mohon pilih kategory $leaveType",
        isError: true,
      );
      return;
    }

    if (tanggalCuti.isEmpty) {
      loadingController.stopLoading(
        message: "Mohon pilih tanggal cuti",
        isError: true,
      );
      return;
    }

    loadingController.startLoading();
    LeaveModel.submitIzin(
      token: System.data.global.token ?? "",
      idAttendance: leaveId ?? 0,
      reason: alasanCuti.text,
      dates: tanggalCuti,
      attachment: attachmentController.getBase64Compress() ?? "",
    ).then((value) {
      loadingController.stopLoading(
          message: "Pengajuan Berhasil Terkirim",
          isError: false,
          onCloseCallBack: () {
            onSuccess?.call();
          });
    }).catchError((onError) {
      loadingController.stopLoading(
        message: ErrorHandlingUtil.handleApiError(onError),
        isError: true,
      );
    });
  }

  void submitCuti({VoidCallback? onSuccess}) {
    if (leaveType == null) {
      loadingController.stopLoading(
        message: "Mohon pilih tipe formulir",
        isError: true,
      );
      return;
    }

    if (leaveId == null) {
      loadingController.stopLoading(
        message: "Mohon pilih kategory $leaveType",
        isError: true,
      );
      return;
    }

    if (tanggalCuti.isEmpty) {
      loadingController.stopLoading(
        message: "Mohon pilih tanggal cuti",
        isError: true,
      );
      return;
    }

    loadingController.startLoading();
    LeaveModel.submitCuti(
      token: System.data.global.token ?? "",
      idAllowance: selectedCategoryAttendance.allowanceId ?? 0,
      idAttendance: leaveId ?? 0,
      reason: alasanCuti.text,
      dates: tanggalCuti,
      attachment: attachmentController.getBase64Compress() ?? "",
    ).then((value) {
      loadingController.stopLoading(
          message: "Pengajuan Berhasil Terkirim",
          isError: false,
          onCloseCallBack: () {
            onSuccess?.call();
          });
    }).catchError((onError) {
      loadingController.stopLoading(
        message: ErrorHandlingUtil.handleApiError(onError),
        isError: true,
      );
    });
  }

  bool validateTanggal() {
    //check apakah jumlah tanggal sudah melebihi batas
    if (selectedCategoryAttendance.count != null) {
      if (tanggalCuti.length > selectedCategoryAttendance.count!) {
        loadingController.stopLoading(
          isError: true,
          message:
              "Jumlah maksinal hari yang dapat diambil adalah ${selectedCategoryAttendance.count} hari",
        );
        return false;
      }
      return true;
    }

    //validasi tanggal apakah sudah melebihi batas pengajuan
    for (var tanggal in tanggalCuti) {
      if (validateTanggalPengajuan(tanggal) == false) {
        return false;
      }
    }
    return true;
  }

  bool validateTanggalPengajuan(DateTime tanggalPengajuan) {
    DateTime? batasPengajuan = tanggalPengajuan;
    DateTime? tangalSekarang =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (selectedCategoryAttendance.batasPengajuanBulan != null) {
      batasPengajuan = DateTime(
          batasPengajuan.year,
          batasPengajuan.month +
              (selectedCategoryAttendance.batasPengajuanBulan ?? 0),
          batasPengajuan.day);
    }
    if (selectedCategoryAttendance.batasPengajuan != null) {
      batasPengajuan = DateTime(
          batasPengajuan.year,
          batasPengajuan.month,
          batasPengajuan.day +
              (selectedCategoryAttendance.batasPengajuan ?? 0));
    }
    // debugPrint("batas pengajuan ${selectedCategoryAttendance.batasPengajuanBulan} $tanggalPengajuan => $batasPengajuan => $tangalSekarang");
    if (batasPengajuan.isAfter(tangalSekarang) ||
        batasPengajuan == tangalSekarang) {
      return true;
    } else {
      loadingController.stopLoading(
        isError: true,
        message:
            "Tanggal pengajuan melebihi batas pengajuan \n Batas maksimal pengajuan ${selectedCategoryAttendance.attendance} adalah ${selectedCategoryAttendance.batasPengajuanBulan != null && selectedCategoryAttendance.batasPengajuanBulan != 0 ? selectedCategoryAttendance.batasPengajuanBulan.toString() + " bulan" : ""} ${selectedCategoryAttendance.batasPengajuanBulan != null && selectedCategoryAttendance.batasPengajuan != 0 ? selectedCategoryAttendance.batasPengajuan.toString() + " hari" : ""}",
      );
      return false;
    }
  }

  void commit() {
    notifyListeners();
  }
}

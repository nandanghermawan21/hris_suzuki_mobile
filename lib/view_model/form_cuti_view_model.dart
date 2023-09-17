import 'dart:async';

import 'package:flutter/material.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/model/category_attendace_model.dart';
import 'package:suzuki/model/leave_model.dart';
import 'package:suzuki/util/error_handling_util.dart';
import 'package:suzuki/util/system.dart';

class FormCutiViewModel extends ChangeNotifier {
  CircularLoaderController loadingController =
      CircularLoaderController();

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

  void submitIzin({
    VoidCallback? onSuccess
  }) {
    if(leaveType == null) {
      loadingController.stopLoading(
        message: "Mohon pilih tipe formulir",
        isError: true,
      );
      return;
    }

    if(leaveId == null) {
      loadingController.stopLoading(
        message: "Mohon pilih kategory $leaveType",
        isError: true,
      );
      return;
    }

    if(tanggalCuti.isEmpty) {
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
    ).then((value) {
      loadingController.stopLoading(
        message: "Pengajuan Berhasil Terkirim",
        isError: false,
        onCloseCallBack: (){
          onSuccess?.call();
        }
      );
    }).catchError((onError){
      loadingController.stopLoading(
        message: ErrorHandlingUtil.handleApiError(onError),
        isError: true,
      );
    });
  }

  void commit() {
    notifyListeners();
  }
}

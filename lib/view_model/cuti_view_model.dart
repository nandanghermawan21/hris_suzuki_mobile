import 'package:flutter/material.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/component/list_data_component.dart';
import 'package:suzuki/model/leave_model.dart';
import 'package:suzuki/util/error_handling_util.dart';
import 'package:suzuki/util/system.dart';

class CutiViewModel extends ChangeNotifier {
  CircularLoaderController approvalLeaveController = CircularLoaderController();
  ListDataComponentController<LeaveModel> cutiSayaController =
      ListDataComponentController<LeaveModel>();
  ListDataComponentController<LeaveModel> cutiKaryawanController =
      ListDataComponentController<LeaveModel>();
  TextEditingController alasanController = TextEditingController();

  void approvalLeave(
      BuildContext context, int idLeave, bool accept, String alasan) {
    approvalLeaveController.startLoading();
    LeaveModel.approvalLeave(
      token: System.data.global.token ?? "",
      leaveId: idLeave,
      accept: accept,
      reason: alasan,
    ).then((value) {
      approvalLeaveController.stopLoading(
          message: "permohonan berhasil di${accept ? "setujui" : "tolak"}}",
          onCloseCallBack: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            commit();
            cutiKaryawanController.refresh();
          });
    }).catchError((onError) {
      approvalLeaveController.stopLoading(
        isError: true,
        message:
            "Kehadiran gagal ${accept ? "setujui" : "tolak"} \n ${ErrorHandlingUtil.handleApiError(onError)}",
      );
    });
  }

   void cancelLeave(
      BuildContext context, int idLeave, String alasan) {
    approvalLeaveController.startLoading();
    LeaveModel.cancelLeave(
      token: System.data.global.token ?? "",
      leaveId: idLeave,
      reason: alasan,
    ).then((value) {
      approvalLeaveController.stopLoading(
          message: "permohonan pembatalan berhasil terkirim",
          onCloseCallBack: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            commit();
            cutiKaryawanController.refresh();
          });
    }).catchError((onError) {
      approvalLeaveController.stopLoading(
        isError: true,
        message:
            "permohonan pembatalan gagal terkirim \n ${ErrorHandlingUtil.handleApiError(onError)}",
      );
    });
  }

  void commit() {
    notifyListeners();
  }
}

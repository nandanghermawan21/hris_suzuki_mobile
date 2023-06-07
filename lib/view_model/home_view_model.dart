import 'package:flutter/material.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/model/attendace_model.dart';
import 'package:suzuki/model/pegawai_model.dart';
import 'package:suzuki/util/error_handling_util.dart';
import 'package:suzuki/util/system.dart';

class HomeViewModel extends ChangeNotifier {
  CircularLoaderController circularLoaderController =
      CircularLoaderController();
  PegawaiModel myProfile = PegawaiModel();

  void checkIn() {
    circularLoaderController.startLoading(message: "Check In...");
    AttendaceModel.checkIn(
      token: System.data.global.token,
    ).then((value) {
      circularLoaderController.stopLoading(
        isError: false,
        message: "Check In Success",
      );
    }).catchError((e) {
      circularLoaderController.stopLoading(
        isError: true,
        message: "Check In Failed \n" + (ErrorHandlingUtil.handleApiError(e)),
      );
    });
  }

  void checkOut() {
    circularLoaderController.startLoading(message: "Check Out...");
    AttendaceModel.checkOut(
      token: System.data.global.token,
    ).then((value) {
      circularLoaderController.stopLoading(
        isError: false,
        message: "Check Out Success",
      );
    }).catchError((e) {
      circularLoaderController.stopLoading(
        isError: true,
        message: "Check Out Failed \n" + (ErrorHandlingUtil.handleApiError(e)),
      );
    });
  }

  void getMyprofile(){
    PegawaiModel.myProfile(
      token: System.data.global.token,
    ).then((value) {
       myProfile = value;
       commit();
    }).catchError((onError){
      circularLoaderController.stopLoading(
        isError: true,
        message: "Get Profile Failed \n" + (ErrorHandlingUtil.handleApiError(onError)),
      );
    });
  }

  void commit() {
    notifyListeners();
  }
}

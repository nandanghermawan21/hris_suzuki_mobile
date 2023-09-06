import 'package:flutter/material.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/component/image_picker_component.dart';
import 'package:suzuki/model/attendace_model.dart';
import 'package:suzuki/model/pegawai_model.dart';
import 'package:suzuki/util/error_handling_util.dart';
import 'package:suzuki/util/system.dart';

class HomeViewModel extends ChangeNotifier {
  CircularLoaderController circularLoaderController =
      CircularLoaderController();
  ImagePickerController attendanceImageController = ImagePickerController();

  void checkIn() {
    if (System.data.global.myProfile!.needPhoto == "y") {
      if (attendanceImageController.validate() == false) {
        circularLoaderController.stopLoading(
          isError: true,
          message: "Please take a photo",
        );
        return;
      }
    }

    circularLoaderController.startLoading(message: "Check In...");
    AttendaceModel.checkIn(
      token: System.data.global.token,
      image: attendanceImageController.getBase64Compress(),
    ).then((value) {
      circularLoaderController.stopLoading(
        isError: false,
        message: "Check In Success",
      );
    }).catchError((e) {
      circularLoaderController.stopLoading(
        isError: true,
        message: ErrorHandlingUtil.handleApiError(e),
      );
    });
  }

  void checkOut() {
    if (System.data.global.myProfile!.needPhoto == "y") {
      if (attendanceImageController.validate() == false) {
        circularLoaderController.stopLoading(
          isError: true,
          message: "Please take a photo",
        );
        return;
      }
    }
    
    circularLoaderController.startLoading(message: "Check Out...");
    AttendaceModel.checkOut(
      token: System.data.global.token,
      image: attendanceImageController.getBase64Compress(),
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

  Future<void> getMyprofile() {
    circularLoaderController.startLoading();
    return PegawaiModel.myProfile(
      token: System.data.global.token,
    ).then((value) {
      circularLoaderController.forceStop();
      System.data.global.myProfile = value;
      System.data.commit();
      return;
    }).catchError((onError) {
      circularLoaderController.stopLoading(
        isError: true,
        message: "Get Profile Failed \n" +
            (ErrorHandlingUtil.handleApiError(onError)),
      );
      throw onError;
    });
  }

  void commit() {
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/model/user_model.dart';
import 'package:suzuki/util/error_handling_util.dart';
import 'package:suzuki/util/system.dart';

class ActivasiAkunViewModel extends ChangeNotifier {
  CircularLoaderController circularLoaderController =
      CircularLoaderController();
  TextEditingController nipController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  TextEditingController tglMulaiKerjaController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  DateTime? _tglLahir;

  DateTime? get tglLahir => _tglLahir;

  set tglLahir(DateTime? value) {
    _tglLahir = value;
    tglLahirController.text = value == null
        ? ""
        : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(value);
  }

  DateTime? _tglMulaiKerja;

  DateTime? get tglMulaiKerja => _tglMulaiKerja;

  set tglMulaiKerja(DateTime? value) {
    _tglMulaiKerja = value;
    tglMulaiKerjaController.text = value == null
        ? ""
        : DateFormat("dd MMMM yyyy", System.data.strings!.locale).format(value);
  }

  void submit(VoidCallback? onLOginSuccess) {
    circularLoaderController.startLoading();
    UserModel.activasi(
      nip: nipController.text,
      nama: namaController.text,
      tglLahir: tglLahir,
      tglMulaiKerja: tglMulaiKerja,
      password: passwordController.text,
    ).then((value) {
      circularLoaderController.stopLoading(
        message:
            "Aktivasi akun berhasil, \n silahkan login dengan NIP dan password yang telah dibuat",
        onCloseCallBack: (){
          onLOginSuccess?.call();
        }
      );
      // circularLoaderController.forceStop();
      // System.data.global.user = value;
      // System.data.global.user?.password = passwordController.text;
      // System.data.global.token = value?.token ?? "";
      // System.data.session!
      //     .setString(SessionKey.user, json.encode(value?.toJson()));
      // System.data.global.user = value;
      // if (onLOginSuccess != null) {
      //   onLOginSuccess();
      // }
    }).catchError((onError) {
      circularLoaderController.stopLoading(
        isError: true,
        message:
            "Aktivasi akun gagal \n ${ErrorHandlingUtil.handleApiError(onError)}",
      );
    });
  }
}

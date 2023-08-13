import 'package:suzuki/model/pegawai_model.dart';
import 'package:suzuki/model/user_model.dart';

class Global {
  String? token = "";
  String? messagingToken;
  Uri? currentDeepLinkUri;
  UserModel? user;
  PegawaiModel? myProfile;
}

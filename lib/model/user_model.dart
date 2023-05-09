import 'package:suzuki/util/network.dart';
import 'package:suzuki/util/system.dart';

class UserModel {
  int? id; //": 1,
  String? username; //": "root",
  String?
      password; //": "$2y$10$SfiR42Y913qnwKO4ayVvVO5ufwkDTL2G3.5Kw2GJS.2TpHycQOnTq",
  String? name; //": "admin",
  String? alamat; //": "INA",
  String? nohp; //": "085",
  String? email; //": "admin@root.com",
  int? organitationId; //": null,
  String?
      token; ////": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NTUwNTE4NTgsImV4cCI6MTY5ODI1MTg1OCwidWlkIjoicm9vdCJ9.EPVtaxF0ntlAOkpnSvNMFKK-QIdSkR-53AGjsB4CQGo"

  UserModel({
    this.id,
    this.username,
    this.password,
    this.name,
    this.alamat,
    this.nohp,
    this.email,
    this.organitationId,
    this.token,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json["id"] as num?)?.toInt(),
      username: (json["username"] as String?),
      password: (json["password"] as String?),
      name: (json["name"] as String?),
      alamat: (json["alamat"] as String?),
      nohp: (json["nohp"] as String?),
      email: (json["email"] as String?),
      organitationId: (json["organitation_id"] as num?)?.toInt(),
      token: (json["token"] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "password": password,
      "name": name,
      "alamat": alamat,
      "nohp": nohp,
      "email": email,
      "organitation_id": organitationId,
      "token": token,
    };
  }

  static Future<UserModel?> login({
    required String? username,
    required String? password,
  }) {
    return Network.post(
      url: Uri.parse(
        System.data.apiEndPoint.url + System.data.apiEndPoint.loginUrl,
      ),
      otpRequired: null,
      body: {
        "username": username ?? "",
        "password": password ?? "",
      },
    ).then((value) {
      return value == null ? null : UserModel.fromJson((value));
    }).catchError(
      (onError) {
        throw onError;
      },
    );
  }
}

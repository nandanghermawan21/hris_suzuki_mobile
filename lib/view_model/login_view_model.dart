import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locker/flutter_locker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/model/user_model.dart';
import 'package:suzuki/util/enum.dart';
import 'package:suzuki/util/error_handling_util.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view/login_view.dart';

class LoginViewModel extends ChangeNotifier {
  final LocalAuthentication auth = LocalAuthentication();
  CircularLoaderController loadingController = CircularLoaderController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool canAuhth = false;
  bool canBio = false;

  void login({
    VoidCallback? onLOginSuccess,
    UserModel? user,
  }) {
    loadingController.startLoading();
    UserModel.login(
      username: user?.username ?? usernameController.text,
      password: user?.password ?? passwordController.text,
    ).then((value) {
      loadingController.forceStop();
      System.data.global.user = value;
      System.data.global.user?.password =
          user?.password ?? passwordController.text;
      System.data.global.token = value?.token ?? "";
      System.data.session!
          .setString(SessionKey.user, json.encode(value?.toJson()));
      if(onLOginSuccess != null) {
        onLOginSuccess();
      }
      // if (canAuhth == false) {
      //   if (onLOginSuccess != null) {
      //     onLOginSuccess();
      //   }
      // } else {
      //   if (user == null) {
      //     LoginViewState.safeAccountWirhBio(
      //       context: System.data.context,
      //       onTapSave: () {
      //         System.data.session!.setBool(SessionKey.userByBio, false);
      //         safeAccount(onLOginSuccess!);
      //       },
      //       onTapNo: () {
      //         if (onLOginSuccess != null) {
      //           onLOginSuccess();
      //         }
      //       },
      //     );
      //   } else {
      //     if (onLOginSuccess != null) {
      //       onLOginSuccess();
      //     }
      //   }
      // }
    }).catchError(
      (onError) {
        debugPrint("error $onError");
        loadingController.stopLoading(
          isError: true,
          message: ErrorHandlingUtil.handleApiError(onError),
        );
      },
    );
  }

  void safeAccount(VoidCallback onLoginSuccess) {
    deleteSecret(onSuccess: () {
      debugPrint('check can check biometric $canBio');
      if (Platform.isIOS) {
        safeSecreetOnLocker(onLoginSuccess);
      } else {
        if (canBio) {
          safeSecreetOnLocker(onLoginSuccess);
        } else {
          safeSecreetOnLoacAuth(onLoginSuccess);
        }
      }
    }, onFailed: () {
      loadingController.forceStop();
      LoginViewState.safeAccountWirhBio(
        context: System.data.context,
        message:
            "${System.data.strings!.authorizationInvalid} ${System.data.strings!.tryAgain}?",
        onTapSave: () {
          safeAccount(onLoginSuccess);
        },
        onTapNo: () {
          // onLoginSuccess();
        },
      );
    });
  }

  Future<void> safeSecreetOnLocker(VoidCallback onSaveSuccess) {
    return FlutterLocker.save(
      SaveSecretRequest(
        androidPrompt:
            AndroidPrompt(cancelLabel: 'Cancel', title: 'Authenticate'),
        key: SessionKey.user,
        secret: json.encode(System.data.global.user?.toJson()),
      ),
    ).then(
      (value) {
        System.data.session!.setBool(SessionKey.userByBio, true);
        loadingController.stopLoading(
          message: "Account has been saved",
          isError: false,
          onCloseCallBack: () {
            debugPrint("call on login success");
            onSaveSuccess();
          },
        );
      },
    ).catchError(
      (onError) {
        loadingController.forceStop();
        LoginViewState.safeAccountWirhBio(
          context: System.data.context,
          message:
              "${System.data.strings!.authorizationInvalid} ${System.data.strings!.tryAgain}?",
          onTapSave: () {
            safeAccount(onSaveSuccess);
          },
          onTapNo: () {
            // onLoginSuccess();
          },
        );
      },
    );
  }

  Future<void> safeSecreetOnLoacAuth(VoidCallback onSaveSuccess) {
    return auth.authenticate(localizedReason: "Authenticate").then(
      (value) {
        System.data.session!.setBool(SessionKey.userByBio, true);
        System.data.session!.setString(SessionKey.userLocalAuth,
            json.encode(System.data.global.user?.toJson()));
        loadingController.stopLoading(
          message: "Account has been saved",
          isError: false,
          onCloseCallBack: () {
            debugPrint("call on login success");
            onSaveSuccess();
          },
        );
      },
    ).catchError(
      (onError) {
        loadingController.forceStop();
        LoginViewState.safeAccountWirhBio(
          context: System.data.context,
          message:
              "${System.data.strings!.authorizationInvalid} ${System.data.strings!.tryAgain}?",
          onTapSave: () {
            safeAccount(onSaveSuccess);
          },
          onTapNo: () {
            // onLoginSuccess();
          },
        );
      },
    );
  }

  Future<void> retrieveSecretOnLocker(VoidCallback onLoginSuccess) async {
    try {
      final retrieved = await FlutterLocker.retrieve(RetrieveSecretRequest(
          key: SessionKey.user,
          androidPrompt: AndroidPrompt(
              title: 'Authenticate',
              cancelLabel: 'Cancel',
              descriptionLabel: 'Please authenticate'),
          iOsPrompt: IOsPrompt(touchIdText: 'Authenticate')));

      login(
          onLOginSuccess: onLoginSuccess,
          user: UserModel.fromJson(json.decode(retrieved)));
    } on Exception {
      loadingController.stopLoading(
          message:
              "${System.data.strings!.authorizationInvalid} ${System.data.strings!.pleaseTryAgain}!",
          isError: true);
    }
  }

  Future<void> retrieveSecretOnLocalAuth(VoidCallback onLoginSuccess) async {
    return auth.authenticate(localizedReason: "Authenticate").then(
      (value) {
        String userJson =
            System.data.session!.getString(SessionKey.userLocalAuth) ?? "{}";
        System.data.global.user = UserModel.fromJson(json.decode(userJson));
        onLoginSuccess();
      },
    ).catchError(
      (onError) {
        loadingController.stopLoading(
            message:
                "${System.data.strings!.authorizationInvalid} ${System.data.strings!.pleaseTryAgain}!",
            isError: true);
      },
    );
  }

  Future<void> canAuthenticate() async {
    try {
      final canAuthenticate = await FlutterLocker.canAuthenticate();

      canAuhth = canAuthenticate ?? false;
      comit();
    } on Exception catch (exception) {
      loadingController.stopLoading(message: exception.toString());
    }
  }

  Future<void> deleteSecret({
    VoidCallback? onSuccess,
    VoidCallback? onFailed,
  }) async {
    try {
      if (Platform.isIOS) {
        await validateAuth();
        await FlutterLocker.delete(SessionKey.user);
        if (onSuccess != null) {
          onSuccess();
        }
      } else {
        if (onSuccess != null) {
          onSuccess();
        }
      }
    } on Exception catch (exception) {
      if (onFailed != null) {
        onFailed();
      } else {
        loadingController.stopLoading(message: exception.toString());
      }
    }
  }

  Future<void> validateAuth() async {
    try {
      await FlutterLocker.save(
        SaveSecretRequest(
          key: "KUNCI",
          secret: "KUNCI",
          androidPrompt: AndroidPrompt(
              title: 'Authenticate',
              cancelLabel: 'Cancel',
              descriptionLabel: 'Please authenticate'),
        ),
      );

      debugPrint('save first secreet success');

      bool _valid = false;
      do {
        try {
          final retrieved = await FlutterLocker.retrieve(RetrieveSecretRequest(
              key: "KUNCI",
              androidPrompt: AndroidPrompt(
                  title: 'Authenticate',
                  cancelLabel: 'Cancel',
                  descriptionLabel: 'Please authenticate'),
              iOsPrompt: IOsPrompt(touchIdText: 'Authenticate')));
          _valid = true;
          debugPrint('read first secreet success $retrieved');
        } catch (e) {
          debugPrint('key belum siap');
        }
      } while (!_valid);
    } on Exception catch (exception) {
      debugPrint(exception.toString());
    }
  }

  Future<void> canCheckBiometrics() async {
    try {
      List<BiometricType> bios = await auth.getAvailableBiometrics();
      if (bios.contains(BiometricType.fingerprint)) {
        canBio = true;
      } else {
        canBio = false;
      }
    } on PlatformException {
      canBio = false;
    }
  }

  void comit() {
    notifyListeners();
  }
}

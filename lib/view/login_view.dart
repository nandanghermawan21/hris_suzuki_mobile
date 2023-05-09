import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:suzuki/component/basic_component.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/component/input_component.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view_model/login_view_model.dart';

import '../util/enum.dart';

class LoginView extends StatefulWidget {
  final VoidCallback? onLoginSuccess;
  final VoidCallback? onTapProfile;

  const LoginView({
    Key? key,
    this.onLoginSuccess,
    this.onTapProfile,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginViewState();
  }
}

class LoginViewState extends State<LoginView> {
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    // loginViewModel.canCheckBiometrics();
    // loginViewModel.canAuthenticate();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: loginViewModel,
      child: Scaffold(
        backgroundColor: System.data.color!.background,
        resizeToAvoidBottomInset: false,
        body: CircularLoaderComponent(
          controller: loginViewModel.loadingController,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: logo(),
                ),
                Center(
                  child: loginForm(),
                ),
                Consumer<LoginViewModel>(
                  builder: (c, d, w) {
                    return !loginViewModel.canAuhth ||
                            System.data.session!
                                    .getBool(SessionKey.userByBio) !=
                                true
                        ? const SizedBox()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 80),
                              padding: const EdgeInsets.all(5),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color: System.data.color!.primaryColor),
                              child: System.data.session!
                                          .getBool(SessionKey.userByBio) ==
                                      true
                                  ? GestureDetector(
                                      onTap: () {
                                        if (Platform.isIOS) {
                                          loginViewModel
                                              .retrieveSecretOnLocker(
                                                  widget.onLoginSuccess ??
                                                      () {});
                                        } else {
                                          if (loginViewModel.canBio) {
                                            loginViewModel
                                                .retrieveSecretOnLocker(
                                                    widget.onLoginSuccess ??
                                                        () {});
                                          } else {
                                            loginViewModel
                                                .retrieveSecretOnLocalAuth(
                                                    widget.onLoginSuccess ??
                                                        () {});
                                          }
                                        }
                                      },
                                      child: const Icon(
                                        Icons.fingerprint,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Versi : ",
                                style:
                                    System.data.textStyles!.basicLabel,
                              ),
                              Text(
                                System.data.versionName,
                                style:
                                    System.data.textStyles!.basicLabel,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Model : ",
                                style:
                                    System.data.textStyles!.basicLabel,
                              ),
                              Text(
                                System.data.deviceInfo?.deviceModel ?? "",
                                style:
                                    System.data.textStyles!.basicLabel,
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "DeviceId : ",
                                style:
                                    System.data.textStyles!.basicLabel,
                              ),
                              Text(
                                System.data.deviceInfo?.deviceId ?? "",
                                style:
                                    System.data.textStyles!.basicLabel,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                          text: System
                                              .data.deviceInfo?.deviceId))
                                      .then((value) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "${System.data.deviceInfo?.deviceId} telah di copy ke clipboard"),
                                    ));
                                  });
                                },
                                child: Icon(
                                  Icons.copy,
                                  color: System.data.color!.darkTextColor,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: ((MediaQuery.of(context).size.height - 350) / 2) > 100
            ? 100
            : ((MediaQuery.of(context).size.height - 350) / 2),
        child: BasicComponent.logoHorizontal(),
      ),
    );
  }

  Widget loginForm() {
    return IntrinsicHeight(
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 25, right: 25),
                  decoration:  BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: System.data.color!.primaryColor,
                        width: 5,
                      )
                    )
                  ),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "HRIS",
                          style: TextStyle(
                            color: System.data.color!.link,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: "MOB",
                              style: TextStyle(
                                color: System.data.color!.primaryColor,
                                fontSize: 40,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 50,
                        child: InputComponent.inputText(
                          controller: loginViewModel.usernameController,
                          hint: System.data.strings!.userName,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 50,
                        child: InputComponent.inputText(
                          controller: loginViewModel.passwordController,
                          hint: System.data.strings!.password,
                          obscureText: true,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // children: [
                          //   Row(
                          //     children: [
                          //       Text(
                          //         System.data.strings!.rememberMe,
                          //         style: TextStyle(
                          //           color: System.data.color!.darkTextColor,
                          //           fontSize: System.data.font!.m,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         width: 5,
                          //       ),
                          //       Checkbox(value: false, onChanged: (v) {})
                          //     ],
                          //   ),
                          //   Text(
                          //     System.data.strings!.forgotPassword,
                          //     style: TextStyle(
                          //       color: System.data.color!.link,
                          //       fontSize: System.data.font!.m,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: ElevatedButton(
                          onPressed: () {
                            loginViewModel.login(
                              onLOginSuccess: widget.onLoginSuccess,
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                System.data.color!.link),
                          ),
                          child: Text(
                            System.data.strings!.login,
                            style: TextStyle(
                              color: System.data.color!.lightTextColor,
                              fontSize: System.data.font!.xxxl,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void inputOtp() {
    System.data.resizeToAvoidBottomInset = true;
    System.data.commit();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          height: 310,
          color: Colors.transparent,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 150, left: 20, right: 20, bottom: 60),
                  height: 290,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        System.data.strings!.checkYourEmailAndEntertheOTPhere,
                        style: TextStyle(
                          color: System.data.color!.darkTextColor,
                          fontSize: System.data.font!.m,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 50,
                        color: Colors.transparent,
                        child: InputComponent.inputText(
                          hint: System.data.strings!.enterOtp,
                          obscureText: true,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 150,
                  color: Colors.transparent,
                  child: SvgPicture.asset("assets/mailbox_ilustration.svg"),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.transparent,
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onLoginSuccess!();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(System.data.color!.link)),
                    child: Text(
                      System.data.strings!.login,
                      style: TextStyle(
                        color: System.data.color!.lightTextColor,
                        fontSize: System.data.font!.xxxl,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    ).then((value) {
      System.data.resizeToAvoidBottomInset = false;
      System.data.commit();
    });
  }

  static void safeAccountWirhBio({
    required BuildContext context,
    required VoidCallback onTapSave,
    required VoidCallback onTapNo,
    String? message,
  }) {
    System.data.resizeToAvoidBottomInset = true;
    System.data.commit();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (ctx) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 260,
              width: (MediaQuery.of(context).size.width * 30 / 100) < 400
                  ? 400
                  : (MediaQuery.of(context).size.width * 30 / 100),
              color: Colors.transparent,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 150, left: 20, right: 20, bottom: 60),
                      height: 240,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: System.data.color!.background,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            message ??
                                System.data.strings!.willYouKeepThisAccount,
                            style: TextStyle(
                              color: System.data.color!.darkTextColor,
                              fontSize: System.data.font!.m,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 150,
                      color: Colors.transparent,
                      child: Image.asset("assets/account_safe.png"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.transparent,
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  onTapSave();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      System.data.color!.link),
                                ),
                                child: Text(
                                  System.data.strings!.yes,
                                  style: TextStyle(
                                    color: System.data.color!.lightTextColor,
                                    fontSize: System.data.font!.xxxl,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  onTapNo();
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        System.data.color!.darkBackground)),
                                child: Text(
                                  System.data.strings!.no,
                                  style: TextStyle(
                                    color: System.data.color!.lightTextColor,
                                    fontSize: System.data.font!.xxxl,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      System.data.resizeToAvoidBottomInset = false;
      System.data.commit();
    });
  }
}

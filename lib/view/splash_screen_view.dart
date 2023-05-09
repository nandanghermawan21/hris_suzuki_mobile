import 'package:flutter/material.dart';
import 'package:suzuki/component/basic_component.dart';
import 'package:suzuki/component/circular_loader_component.dart';
import 'package:suzuki/util/system.dart';
import 'package:suzuki/view_model/splash_screen_view_model.dart';

class SplashScreenView extends StatefulWidget {
  final ValueChanged<bool>? onFinish;

  const SplashScreenView({
    Key? key,
    this.onFinish,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenViewState();
  }
}

class SplashScreenViewState extends State<SplashScreenView> {
  SplashScrenViewModel splashScrenViewModel = SplashScrenViewModel();

  @override
  void initState() {
    super.initState();
    splashScrenViewModel.syncronizeMasterData(
      onSyncFinish: widget.onFinish,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircularLoaderComponent(
        controller: splashScrenViewModel.loadingController,
        cover: false,
        loadingBuilder: onLoading,
        child: Scaffold(
          backgroundColor: System.data.color!.background,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: logo(),
              ),
            ],
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

  Widget onLoading() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(10),
                color: Colors.transparent,
                child: CircularProgressIndicator(
                  color: System.data.color!.lightTextColor,
                  strokeWidth: 4,
                ),
              ),
              splashScrenViewModel.loadingController.value.loadingMessage !=
                          null &&
                      splashScrenViewModel
                              .loadingController.value.loadingMessage !=
                          ""
                  ? Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        splashScrenViewModel
                                .loadingController.value.loadingMessage ??
                            "",
                        style: System.data.textStyles!.boldTitleLightLabel,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

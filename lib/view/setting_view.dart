import 'package:flutter/material.dart';
import 'package:suzuki/util/sized_util.dart';
import 'package:suzuki/util/system.dart';

class SettingView extends StatefulWidget {
  final VoidCallback? onTapLogout;


  const SettingView({
    Key? key,
    this.onTapLogout,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SettingViewState();
  }
}

class SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: System.data.color!.primaryColor,
        centerTitle: true,
        title: Text(
          System.data.strings!.setting,
          style: System.data.textStyles!.boldTitleLightLabel,
        ),
      ),
      bottomSheet: Container(
        height: 50,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            popupLogout(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
            shadowColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
            side: MaterialStateProperty.all<BorderSide>(
               BorderSide(
                color: System.data.color!.primaryColor,
                width: 1,
              ),
            ),
          ),
          child: Text(
            System.data.strings!.logout,
            style: System.data.textStyles!.boldTitleLabel,
          ),
        ),
      ),
    );
  }

  void popupLogout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return SizedBox(
          height: SizedUtil.minMaxHegihtPercent(context, 25, 300, 400),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 150,
                    child: Image.asset("assets/logout_ilustration.webp"),
                  ),
                ),
                Text(
                  System.data.strings!.areYouSureToLogout+"?",
                  style: System.data.textStyles!.basicLabel.copyWith(
                    color: System.data.color!.darkTextColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: System.data.color!.primaryColor,
                        ),
                        onPressed: () {
                         Navigator.pop(context);
                        },
                        child: Text(
                          System.data.strings!.no,
                          style: System.data.textStyles!.headLine1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: System.data.color!.dangerColor,
                        ),
                        onPressed: () {
                         widget.onTapLogout!();
                        },
                        child: Text(
                          System.data.strings!.yes,
                          style: System.data.textStyles!.headLine1,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

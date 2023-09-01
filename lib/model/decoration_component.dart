import 'package:flutter/material.dart';
import 'package:suzuki/util/system.dart';

class DecorationComponent {
  static PreferredSize appBar({
    required BuildContext context,
    required String title,
    Color textColor = Colors.white,
    Widget? action,
  }) {
    return PreferredSize(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.centerLeft,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: textColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  title,
                  style: System.data.textStyles!.boldTitleLightLabel.copyWith(
                    color: textColor,
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              action ?? const SizedBox(),
            ],
          ),
        ),
      ),
      preferredSize: const Size(double.infinity, 50),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:suzuki/util/system.dart';

class DecorationComponent {
  static PreferredSize appBar({
    required BuildContext context,
    required String title,
    Color textColor = Colors.white,
  }) {
    return PreferredSize(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.centerLeft,
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: textColor,
                  ),
                  Text(
                    title,
                    style: System.data.textStyles!.boldTitleLightLabel.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      preferredSize: const Size(double.infinity, 50),
    );
  }
}

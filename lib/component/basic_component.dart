import 'package:flutter/material.dart';
import 'package:suzuki/util/system.dart';

class BasicComponent {
  static Widget avatar({
    double? size,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: System.data.color!.link,
          border: Border.all(
            color: Colors.white,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      height: size ?? 80,
      width: size ?? 80,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          child: Image.network(
            "",
            fit: BoxFit.fitHeight,
            errorBuilder: (bb, o, st) => Container(
              color: Colors.transparent,
              child: Image.asset(
                "assets/avatar.png",
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget logoHorizontal() {
    return Image.asset(
      "assets/logo_suzuki_red.png",
      // color: Colors.white,
    );
  }
}

import 'dart:convert';

extension StringExtenction on String {
  bool isNullOrEmpty() {
    if (isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  Map<String, dynamic>? decode() {
    return json.decode(this);
  }
}

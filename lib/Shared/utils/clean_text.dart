import 'dart:core';

class CleanText {
  static String clean(String? text) {
    if (text == null) return "";
    return text
        .replaceAll(r'\r\n', ' ')
        .replaceAll(RegExp(r'\[.*?\]'), '')
        .trim();
  }
}

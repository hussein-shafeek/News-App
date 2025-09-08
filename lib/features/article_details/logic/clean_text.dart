String cleanText(String? text) {
  if (text == null) return "";
  return text
      .replaceAll(r'\r\n', ' ')
      .replaceAll(RegExp(r'\[.*?\]'), '') // يشيل [+1529 chars]
      .trim();
}

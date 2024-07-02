class Validator {
  static String? required(String? value, {final String? message}) {
    if (value == null || value.isEmpty) {
      return message ?? "Kolom ini tidak boleh kosong.";
    }
    return null;
  }
}

import 'package:intl/intl.dart';

class Utils {
  static String formatCurrency(dynamic value) {
    final double fixedValue = double.tryParse(value.toString()) ?? 0.0;
    final formatter = NumberFormat.simpleCurrency(
      locale: "en_US",
      name: 'Rp. ',
      decimalDigits: 2,
    );

    return formatter.format(fixedValue);
  }
}

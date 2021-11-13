import 'package:intl/intl.dart';

extension Format on String {
  String formatCurrency() {
    return NumberFormat.currency(locale: 'pt-BR', customPattern: r'R$ #.##').format(double.tryParse(this));
  }
}
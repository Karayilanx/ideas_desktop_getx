import 'package:intl/intl.dart';

extension StringLocalization on String {
  bool get isDouble => tryParse();

  double? get getDouble => double.tryParse(replaceFirst(',', '.'));

  tryParse() {
    try {
      double.parse(replaceFirst(',', '.'));
      return true;
    } catch (e) {
      return false;
    }
  }
}

extension DoubleLocalization on double {
  int get getInt => int.parse(toStringAsFixed(0));

  String get getPriceString => NumberFormat("#,##0.00", "tr_TR").format(this);
}

extension ImagePathExtension on String {
  String get toSVG => 'asset/svg/$this.svg';
}

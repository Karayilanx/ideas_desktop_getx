import 'package:flutter/material.dart';
import '../../../model/end_of_day_unpayable_report_model.dart';
import '../component/end_of_day_table_widgets.dart';

class UnpayableCategoryReportTable extends StatelessWidget {
  final EndOfDayUnpayableReportModel report;
  const UnpayableCategoryReportTable({required this.report});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildUnpayableCategoryReport(report),
    );
  }

  List<Widget> buildUnpayableCategoryReport(
      EndOfDayUnpayableReportModel report) {
    List<Widget> ret = [];
    ret.add(
      EndOfDayReportHeader(
        header: 'Ana Kategoriler',
      ),
    );
    for (var item in report.categoryDistribution!) {
      ret.add(
        EndOfDayReportInformation(
          leftText: item.name!,
          rightText: item.amount!,
        ),
      );
    }
    ret.add(SizedBox(height: 10));
    ret.add(
      EndOfDayReportHeader(
        header: 'Alt Kategoriler',
      ),
    );
    for (var item in report.subCategoryDistribution!) {
      ret.add(
        EndOfDayReportInformation(
          leftText: item.name!,
          rightText: item.amount!,
        ),
      );
    }
    ret.add(SizedBox(height: 10));
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Toplam Tutar',
        rightText: report.totalAmount!,
      ),
    );
    return ret;
  }
}

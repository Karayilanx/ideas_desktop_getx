import 'package:flutter/material.dart';
import '../../../model/end_of_day_summary_model.dart';
import '../component/end_of_day_table_widgets.dart';

class SummaryReport extends StatelessWidget {
  final EndOfDaySummaryReportModel report;
  const SummaryReport({required this.report});

  @override
  Widget build(BuildContext context) {
    return buildSummaryReport(report);
  }

  Widget buildSummaryReport(EndOfDaySummaryReportModel report) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EndOfDayReportColumn(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EndOfDayReportHeader(
                header: 'Toplam Satışlar',
              ),
              EndOfDayReportInformation(
                leftText: 'Nakit Kasa',
                rightText: report.totalSales!.cash,
              ),
              ...buildTotalSalesCashDetails(report),
              EndOfDayReportInformation(
                leftText: 'Kredi',
                rightText: report.totalSales!.creditCard,
              ),
              ...buildTotalSalesCreditDetails(report),
              EndOfDayReportInformation(
                leftText: 'Toplam',
                rightText: report.totalSales!.total,
              ),
              SizedBox(height: 10),
              EndOfDayReportHeader(
                header: 'Cari Tahsilatlar',
              ),
              EndOfDayReportInformation(
                leftText: 'Nakit Tahsilat',
                rightText: report.checkAccountReceivings!.cash,
              ),
              EndOfDayReportInformation(
                leftText: 'Kredi Tahsilat',
                rightText: report.checkAccountReceivings!.creditCard,
              ),
              EndOfDayReportInformation(
                leftText: 'Toplam',
                rightText: report.checkAccountReceivings!.total,
              ),
              SizedBox(height: 10),
              EndOfDayReportHeader(
                header: 'Toplam Hasılat',
              ),
              EndOfDayReportInformation(
                leftText: 'Toplam Nakit',
                rightText: report.totalIncome!.cash,
              ),
              EndOfDayReportInformation(
                leftText: 'Toplam Kredi',
                rightText: report.totalIncome!.creditCard,
              ),
              ...buildTotalIncomeCreditDetails(report),
              EndOfDayReportInformation(
                leftText: 'Toplam',
                rightText: report.totalIncome!.total,
              ),
              SizedBox(height: 10),
              Text('--------------------------------------------'),
              EndOfDayReportHeader(
                header: 'Ciro Dağılımı',
              ),
              EndOfDayReportInformation(
                leftText: 'Restoran',
                rightText: report.endorsementDistribution!.restaurant -
                    report.endorsementDistribution!.checkAccount,
              ),
              EndOfDayReportInformation(
                leftText: 'Cari',
                rightText: report.endorsementDistribution!.checkAccount,
              ),
              if (report.endorsementDistribution!.yemeksepeti > 0)
                EndOfDayReportInformation(
                  leftText: 'Yemeksepeti',
                  rightText: report.endorsementDistribution!.yemeksepeti,
                ),
              if (report.endorsementDistribution!.getir > 0)
                EndOfDayReportInformation(
                  leftText: 'Getir',
                  rightText: report.endorsementDistribution!.getir,
                ),
              if (report.endorsementDistribution!.fuudy > 0)
                EndOfDayReportInformation(
                  leftText: 'Fuudy',
                  rightText: report.endorsementDistribution!.fuudy,
                ),
              if (report.endorsementDistribution!.delivery > 0)
                EndOfDayReportInformation(
                  leftText: 'Paket Servis',
                  rightText: report.endorsementDistribution!.delivery,
                ),
              EndOfDayReportInformation(
                leftText: 'Ara Toplam',
                rightText: report.endorsementDistribution!.subTotal,
              ),
              EndOfDayReportInformation(
                leftText: 'İskonto',
                rightText: report.endorsementDistribution!.discount,
              ),
              EndOfDayReportInformation(
                leftText: 'Toplam',
                rightText: report.endorsementDistribution!.total,
              ),
              Text('--------------------------------------------'),
            ],
          ),
        ),
        EndOfDayReportColumn(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildMidColumn(report),
          ),
        ),
        EndOfDayReportColumn(
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildRightColumn(report),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildTotalIncomeCreditDetails(
      EndOfDaySummaryReportModel report) {
    List<Widget> ret = [];
    for (var item in report.totalIncome!.creditDetails) {
      ret.add(
        EndOfDayReportInformation(
          leftText: item.name,
          rightText: item.amount,
          isSubInfo: true,
        ),
      );
    }
    return ret;
  }

  List<Widget> buildTotalSalesCreditDetails(EndOfDaySummaryReportModel report) {
    List<Widget> ret = [];
    for (var item in report.totalSales!.creditDetails) {
      ret.add(
        EndOfDayReportInformation(
          leftText: item.name,
          rightText: item.amount,
          isSubInfo: true,
        ),
      );
    }
    return ret;
  }

  List<Widget> buildTotalSalesCashDetails(EndOfDaySummaryReportModel report) {
    List<Widget> ret = [];
    for (var item in report.totalSales!.cashDetails) {
      ret.add(
        EndOfDayReportInformation(
          leftText: item.name,
          rightText: item.amount,
          isSubInfo: true,
        ),
      );
    }
    return ret;
  }

  List<Widget> buildRightColumn(EndOfDaySummaryReportModel report) {
    List<Widget> ret = [];
    ret.add(
      EndOfDayReportHeader(
        header: 'CARİ SATIŞLAR',
      ),
    );
    for (var item in report.checkAccountSales!.checkAccountSales) {
      ret.add(
        EndOfDayReportInformation(
          leftText: item.checkAccountName,
          rightText: item.amount,
        ),
      );
    }
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Toplam',
        rightText: report.checkAccountSales!.totalAmount,
      ),
    );
    return ret;
  }

  List<Widget> buildMidColumn(EndOfDaySummaryReportModel report) {
    List<Widget> ret = [];
    ret.add(EndOfDayReportHeader(
      header: 'SATIŞ DAĞILIMI',
    ));

    for (var item in report.sellDistribution!.categorySales) {
      ret.add(
        EndOfDayReportInformation(
          leftText: item.categoryName +
              " (" +
              item.quantity.toStringAsFixed(0) +
              " Adet)",
          rightText: item.amount,
        ),
      );
    }

    ret.add(EndOfDayReportInformation(
      leftText: 'Satışlar Toplamı',
      rightText: report.sellDistribution!.totalSales,
    ));
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Cari Hesaplar',
        rightText: report.sellDistribution!.checkAccountBorrowings,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Tahsilatlar',
        rightText: report.sellDistribution!.checkAccountReceivings,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'İskontolar',
        rightText: report.sellDistribution!.discounts,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Ödenmezler',
        rightText: report.sellDistribution!.unpayable,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Hasılat',
        rightText: report.sellDistribution!.income,
      ),
    );

    ret.add(SizedBox(height: 10));
    ret.add(EndOfDayReportHeader(header: 'BEKLENEN HASILAT'));
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Satışlar',
        rightText: report.expectedRevenue!.totalSales,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Tahsilatlar',
        rightText: report.expectedRevenue!.checkAccountReceivings,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Ara Toplam',
        rightText: report.expectedRevenue!.subTotal,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Açık Hesaplar',
        rightText: report.expectedRevenue!.totalActiveCheck,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Restoran',
        rightText: report.expectedRevenue!.totalRestaurant,
        isSubInfo: true,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Yemeksepeti',
        rightText: report.expectedRevenue!.totalYemeksepeti,
        isSubInfo: true,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Getir',
        rightText: report.expectedRevenue!.totalGetir,
        isSubInfo: true,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Fuudy',
        rightText: report.expectedRevenue!.totalFuudy,
        isSubInfo: true,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Hızlı Satış',
        rightText: report.expectedRevenue!.totalFastSell,
        isSubInfo: true,
      ),
    );
    ret.add(
      EndOfDayReportInformation(
        leftText: 'Beklenen Hasılat',
        rightText: report.expectedRevenue!.expectedRevenue,
      ),
    );

    return ret;
  }
}

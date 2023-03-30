import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'package:ideas_desktop_getx/model/eft_pos_model.dart';
import 'package:ideas_desktop_getx/view/end-of-day/tables/gift_report_table.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../_utility/loading/loading_screen.dart';
import '../_utility/service_helper.dart';
import 'end_of_day_view_model.dart';
import 'tables/cancel_report_table.dart';
import 'tables/check_account_receiving_table.dart';
import 'tables/check_account_report_table.dart';
import 'tables/check_report_table.dart';
import 'tables/sales_report_table.dart';
import 'tables/summary_report.dart';
import 'tables/unpayable_category_report.dart';
import 'tables/unpayable_check_report.dart';
import 'tables/unpayable_product_report.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'component/end_of_day_table_widgets.dart';

class EndOfDayPage extends StatelessWidget with ServiceHelper {
  EndOfDayPage({super.key});

  @override
  Widget build(BuildContext context) {
    EndOfDayController controller = Get.find();
    return Scaffold(
      body: Obx(
        () {
          return controller.initFinished.value &&
                  controller.summaryReport.value != null
              ? buildNewBody(context, controller)
              // ? buildBody(context, value)
              : const LoadingPage();
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget buildNewBody(BuildContext context, EndOfDayController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 240, child: buildLeftPanel(controller, context)),
        Expanded(child: buildRightPanel(controller)),
      ],
    );
  }

  Widget buildLeftPanel(
    EndOfDayController controller,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildSelectDateContainer(controller),
          if (controller.showCalender.value) buildCalender(controller),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 56,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Text(
                        "Gün Sonu İşlemleri",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(Icons.arrow_downward_outlined)
                  ],
                ),
              ),
              onSelected: (item) {
                if (item == 0) {
                  controller.openEndOfDayStepperDialog();
                } else if (item == 1) {
                  controller.openSelectReportDialog();
                } else if (item == 2) {
                  controller.sendEndOfDaysToServer();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  value: 0,
                  child: Text('Gün Sonu Yap'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('Ara Rapor Yazdır'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Verileri Sunucuya Gönder'),
                ),
              ],
            ),
          ),
          const Divider(),
          ReportButton(
            onTap: () =>
                controller.changeSelectedReport(EndOfDayReportEnum.SUMMARY),
            title: "Özet Rapor",
          ),
          ReportButton(
            onTap: () =>
                controller.changeSelectedReport(EndOfDayReportEnum.DETAIL),
            title: "Detay Rapor",
          ),
          ReportButton(
            onTap: () =>
                controller.changeSelectedReport(EndOfDayReportEnum.CHECK),
            title: "Adisyonlar",
          ),
          ReportButton(
            onTap: () =>
                controller.changeSelectedReport(EndOfDayReportEnum.SALE),
            title: "Satış Detayları",
          ),
          // ReportButton(
          //   onTap: () => value.changeSelectedReport(EndOfDayReportEnum.SUMMARY),
          //   title: "Paket Satışlar",
          // ),
          // ReportButton(
          //   onTap: () => value.changeSelectedReport(EndOfDayReportEnum.SUMMARY),
          //   title: "Kullanıcı Satışları",
          // ),
          ReportButton(
            onTap: () =>
                controller.changeSelectedReport(EndOfDayReportEnum.CANCEL),
            title: "İptal ve Zayiler",
          ),
          ReportButton(
            onTap: () =>
                controller.changeSelectedReport(EndOfDayReportEnum.UNPAYABLE),
            title: "Ödenmezler",
          ),
          ReportButton(
            onTap: () =>
                controller.changeSelectedReport(EndOfDayReportEnum.GIFT),
            title: "İkramlar",
          ),
          ReportButton(
            onTap: () => controller
                .changeSelectedReport(EndOfDayReportEnum.CHECK_ACOOUNT),
            title: "Cari Hesaplar",
          ),
          ReportButton(
            onTap: () =>
                controller.changeSelectedReport(EndOfDayReportEnum.LOG),
            title: "Loglar",
          ),
          ReportButton(
            onTap: () =>
                controller.changeSelectedReport(EndOfDayReportEnum.OKC_POS),
            title: "OKC Pos İşlemleri",
          ),
          const Divider(),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Çıkış'),
          ),
        ],
      ),
    );
  }

  Widget buildSelectDateContainer(EndOfDayController controller) {
    return GestureDetector(
      onTap: () => controller.changeShowCalender(),
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 175, 175, 175),
              blurRadius: 6,
              offset: Offset(0.0, 0.75),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              controller.showCalender.value ? "Bugüne Dön" : 'Takvimi Aç',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.calendar_month_outlined)
          ],
        ),
      ),
    );
  }

  Widget buildRightPanel(EndOfDayController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildHeaderContainer(controller),
        Expanded(child: buildSelectedReport(controller)),
      ],
    );
  }

  Widget buildSelectedReport(EndOfDayController controller) {
    switch (controller.selectedReportEnum.value) {
      case EndOfDayReportEnum.SUMMARY:
        return buildSummaryReport(controller);
      case EndOfDayReportEnum.CHECK:
        return buildCheckReport(controller);
      case EndOfDayReportEnum.SALE:
        return buildSaleReport(controller);
      case EndOfDayReportEnum.UNPAYABLE:
        return buildUnpaybleReport(controller);
      case EndOfDayReportEnum.CANCEL:
        return buildCancelReportTable(controller);
      case EndOfDayReportEnum.CHECK_ACOOUNT:
        return buildUCheckAccountReports(controller);
      case EndOfDayReportEnum.LOG:
        return buildLogsTable(controller);
      case EndOfDayReportEnum.DETAIL:
        return SummaryReport(report: controller.summaryReport.value!);
      case EndOfDayReportEnum.OKC_POS:
        if (controller.poss.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const VerticalDivider(),
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildTypeDropdown(controller),
                      const SizedBox(height: 12),
                      OkcPosActionButton(
                          callback: () => controller.xReport(),
                          color: Colors.blueGrey,
                          text: "X Raporu Al"),
                      const SizedBox(height: 6),
                      OkcPosActionButton(
                          callback: () => controller.zReport(),
                          color: Colors.blueGrey,
                          text: "Z Raporu Al"),
                      const SizedBox(height: 6),
                      OkcPosActionButton(
                          callback: () => controller.ekuReport(),
                          color: Colors.blueGrey,
                          text: "EKU Detay Rapor"),
                      const SizedBox(height: 6),
                      OkcPosActionButton(
                          callback: () => controller.voidEftPayment(),
                          color: Colors.blueGrey,
                          text: "Eft Ödeme İptal"),
                      const SizedBox(height: 6),
                      OkcPosActionButton(
                          callback: () => controller.voidReceipt(),
                          color: Colors.blueGrey,
                          text: "Fiş İptal"),
                      const SizedBox(height: 6),
                      OkcPosActionButton(
                          callback: () => controller.closeDoc(),
                          color: Colors.blueGrey,
                          text: "Belge Kapat"),
                    ],
                  ),
                ),
                const VerticalDivider(),
                SizedBox(
                  width: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Departmanlar",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Divider(),
                      ...buildDepartments(controller),
                      const Divider(),
                      OkcPosActionButton(
                        callback: () => controller.paymentStart.value
                            ? null
                            : controller.makePayment(),
                        height: 40,
                        color: Colors.blue,
                        text: "Nakit Fiş Kes",
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
              ],
            ),
          );
        } else {
          return Container();
        }
      case EndOfDayReportEnum.GIFT:
        return buildGiftReport(controller);
    }
  }

  buildDepartments(EndOfDayController controller) {
    List<Widget> ret = [];
    for (var i = 0; i < controller.departments.length; i++) {
      var element = controller.departments[i];
      ret.add(
        Row(
          children: [
            Expanded(
              child: Text("${element.deptName!} (%${element.kdv})"),
            ),
            SizedBox(
              width: 138,
              height: 30,
              child: TextFormField(
                controller: controller.controllers[i],
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                ),
              ),
            ),
          ],
        ),
      );
      ret.add(const SizedBox(height: 4));
    }
    return ret;
  }
}

Container buildTypeDropdown(EndOfDayController controller) {
  return Container(
    width: 150,
    height: 50,
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: DropdownSearch<EftPosModel>(
        mode: Mode.MENU,
        items: controller.poss,
        showSearchBox: false,
        itemAsString: (item) => item!.eftPosName!,
        maxHeight: 200,
        onChanged: (val) {
          controller.changeSelectedPos(val!);
        },
        selectedItem: controller.poss[0]),
  );
}

Widget buildSummaryReport(EndOfDayController controller) {
  return Container(
    color: const Color(0xFFD1D9E3),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Column(
      children: [
        buildCards(controller),
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 30, child: buildLeftInfoContainer(controller)),
              const SizedBox(width: 8),
              Expanded(
                flex: 70,
                child: Column(
                  children: [
                    Expanded(
                      flex: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: buildDetailsContainer(controller),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: SfCircularChart(
                                series: [
                                  DoughnutSeries<ChartData, String>(
                                    dataSource: getSellDistributionChartData(
                                        controller),
                                    explode: true,
                                    explodeAll: true,
                                    explodeOffset: "1",
                                    xValueMapper: (ChartData data, _) => data.x,
                                    yValueMapper: (ChartData data, _) => data.y,
                                    dataLabelMapper: (ChartData data, _) =>
                                        data.x,
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                      labelIntersectAction:
                                          LabelIntersectAction.shift,
                                      // labelPosition:
                                      //     ChartDataLabelPosition
                                      //         .outside,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      flex: 30,
                      child: Container(
                        color: Colors.white,
                        child: SfCartesianChart(
                          title: ChartTitle(
                            text: 'Saatlik Satış Dağılımı',
                            alignment: ChartAlignment.near,
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          primaryXAxis: CategoryAxis(),
                          series: <ChartSeries>[
                            // Initialize line series
                            ColumnSeries<ChartData, String>(
                              dataSource: getHourlySellDistributionChartData(
                                  controller),
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

List<ChartData> getHourlySellDistributionChartData(
    EndOfDayController controller) {
  List<ChartData> ret = [];

  for (var element in controller.hourlySaleModel) {
    var hourString = element.hour.toString();
    if (hourString.length == 1) {
      hourString = '0$hourString:00';
    } else {
      hourString = '$hourString:00';
    }

    ret.add(ChartData(hourString, element.saleAmount!));
    // }
  }

  return ret;
}

List<ChartData> getSellDistributionChartData(EndOfDayController controller) {
  List<ChartData> ret = [];

  double total =
      controller.summaryReport.value!.endorsementDistribution!.subTotal;
  for (var element
      in controller.summaryReport.value!.sellDistribution!.categorySales) {
    if (element.amount > 0) {
      ret.add(ChartData(
          '${element.categoryName}\n%${((element.amount / total) * 100).toStringAsFixed(2)}',
          element.amount));
    }
  }

  return ret;
}

Container buildLeftInfoContainer(EndOfDayController controller) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderText(title: "Satışlar"),
        InfoText(
          title: "Nakit",
          info: controller.summaryReport.value!.totalSales!.cash.getPriceString,
        ),
        InfoText(
          title: "Kredi",
          info: controller
              .summaryReport.value!.totalSales!.creditCard.getPriceString,
        ),
        InfoText(
          title: "Toplam",
          info:
              controller.summaryReport.value!.totalSales!.total.getPriceString,
          isLast: true,
        ),
        const HeaderText(title: "Tahsilatlar"),
        InfoText(
          title: "Nakit",
          info: controller
              .summaryReport.value!.checkAccountReceivings!.cash.getPriceString,
        ),
        InfoText(
          title: "Kredi",
          info: controller.summaryReport.value!.checkAccountReceivings!
              .creditCard.getPriceString,
        ),
        InfoText(
          title: "Toplam",
          info: controller.summaryReport.value!.checkAccountReceivings!.total
              .getPriceString,
          isLast: true,
        ),
        const HeaderText(title: "Dağılım"),
        InfoText(
          title: "Restoran Satış",
          info: controller.summaryReport.value!.endorsementDistribution!
              .restaurant.getPriceString,
        ),
        InfoText(
          title: "Cari Satış",
          info: controller.summaryReport.value!.endorsementDistribution!
              .checkAccount.getPriceString,
        ),
        if (controller.summaryReport.value!.endorsementDistribution!.delivery >
            0)
          InfoText(
            title: "Restoran Paket",
            info: controller.summaryReport.value!.endorsementDistribution!
                .delivery.getPriceString,
          ),
        if (controller
                .summaryReport.value!.endorsementDistribution!.yemeksepeti >
            0)
          InfoText(
            title: "Yemeksepeti",
            info: controller.summaryReport.value!.endorsementDistribution!
                .yemeksepeti.getPriceString,
          ),
        if (controller.summaryReport.value!.endorsementDistribution!.getir > 0)
          InfoText(
            title: "Getir",
            info: controller.summaryReport.value!.endorsementDistribution!.getir
                .getPriceString,
          ),
        if (controller.summaryReport.value!.endorsementDistribution!.fuudy > 0)
          InfoText(
            title: "Fuudy",
            info: controller.summaryReport.value!.endorsementDistribution!.fuudy
                .getPriceString,
          ),
        InfoText(
          title: "Ara Toplam",
          info: controller.summaryReport.value!.endorsementDistribution!
              .subTotal.getPriceString,
        ),
        InfoText(
          title: "İskonto",
          info: controller.summaryReport.value!.endorsementDistribution!
              .discount.getPriceString,
        ),
        InfoText(
          title: "Toplam",
          info: controller.summaryReport.value!.endorsementDistribution!.total
              .getPriceString,
        ),
      ],
    ),
  );
}

Container buildDetailsContainer(EndOfDayController controller) {
  return Container(
    color: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeaderText(title: "Detaylar"),
        InfoText(
          title: "Satışlar",
          info: controller
              .summaryReport.value!.sellDistribution!.totalSales.getPriceString,
        ),
        InfoText(
          title: "Ödenmezler",
          info:
              (controller.summaryReport.value!.sellDistribution!.unpayable * -1)
                  .getPriceString,
        ),
        InfoText(
          title: "İkramlar",
          info: (0.0).getPriceString,
        ),
        InfoText(
          title: "İskontolar",
          info:
              (controller.summaryReport.value!.sellDistribution!.discounts * -1)
                  .getPriceString,
        ),
        InfoText(
          title: "Cari Hesaplar",
          info: (controller.summaryReport.value!.endorsementDistribution!
                      .checkAccount *
                  -1)
              .getPriceString,
        ),
        InfoText(
          title: "Tahsilatlar",
          info: controller.summaryReport.value!.sellDistribution!
              .checkAccountReceivings.getPriceString,
        ),
        // InfoText(
        //   title: "İkramlar",
        //   info: value
        //       .summaryReport!.sellDistribution!.totalSales.getPriceString,
        // ),
        if (controller.summaryReport.value!.totalPersonCount! > 0)
          InfoText(
            title: "Kişi Sayısı",
            info: controller.summaryReport.value!.totalPersonCount!.toString(),
          ),
        InfoText(
          title: "Toplam",
          info: controller
              .summaryReport.value!.sellDistribution!.income.getPriceString,
        ),
      ],
    ),
  );
}

Container buildCards(EndOfDayController controller) {
  return Container(
    height: 90,
    margin: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        EndOfDayInfoCard(
          title: "Nakit",
          info:
              controller.summaryReport.value!.totalIncome!.cash.getPriceString,
          isFirst: true,
        ),
        EndOfDayInfoCard(
          title: "Kredi",
          info: controller
              .summaryReport.value!.totalIncome!.creditCard.getPriceString,
        ),
        EndOfDayInfoCard(
          title: "Toplam",
          info:
              controller.summaryReport.value!.totalIncome!.total.getPriceString,
        ),
        EndOfDayInfoCard(
          title: "Açık Hesaplar",
          info: controller.summaryReport.value!.expectedRevenue!
              .totalActiveCheck.getPriceString,
        ),
        EndOfDayInfoCard(
          title: "Beklenen Ciro",
          info: controller.summaryReport.value!.expectedRevenue!.expectedRevenue
              .getPriceString,
        ),
      ],
    ),
  );
}

Widget buildHeaderContainer(EndOfDayController controller) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF393A3E),
          Color(0xFF233541),
        ],
        stops: [0.0, 0.6],
      ),
    ),
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 16),
    height: 50,
    child: Text(
      controller.header.value,
      style: const TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Widget buildCalender(EndOfDayController controller) {
  return SfDateRangePicker(
    backgroundColor: Colors.white,
    showNavigationArrow: true,
    selectableDayPredicate: (date) {
      return controller.specialDates.contains(date);
    },
    controller: controller.dateCtrl,
    onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
      if (dateRangePickerSelectionChangedArgs.value != null) {
        controller.changeTabIndex(controller.tabIndex.value);
      }
    },
    headerStyle: const DateRangePickerHeaderStyle(
      backgroundColor: Colors.blueAccent,
      textAlign: TextAlign.center,
    ),
  );
}

Widget buildLogsTable(EndOfDayController controller) {
  return Obx(() {
    return LogReportTable(
      source: controller.logReportDataSource.value!,
    );
  });
}

Widget buildCancelReportTable(EndOfDayController controller) {
  return Obx(() {
    return CancelReportTable(
      source: controller.cancelReportDataSource.value!,
    );
  });
}

Widget buildUnpaybleReport(EndOfDayController controller) {
  return Column(
    children: [
      SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EndOfDayTabButton(
              callback: () => controller.unpayableTabIndex.value = 0,
              text: "Ürünler",
              selected: controller.unpayableTabIndex.value == 0,
            ),
            const SizedBox(width: 16),
            EndOfDayTabButton(
                callback: () => controller.unpayableTabIndex.value = 1,
                text: "Hesaplar",
                selected: controller.unpayableTabIndex.value == 1),
          ],
        ),
      ),
      if (controller.unpayableTabIndex.value == 0)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(2, 6, 8, 4),
                child: UnpayableCategoryReportTable(
                    report: controller.unpayableReport.value!),
              ),
            ),
            const VerticalDivider(
              color: Colors.black,
            ),
            Expanded(
              flex: 2,
              child: buildUnpayableProductReportTable(controller),
            ),
          ],
        ),
      if (controller.unpayableTabIndex.value == 1)
        buildUnpayableChecksReportTable(controller)
    ],
  );
}

Widget buildUCheckAccountReports(EndOfDayController controller) {
  return Column(
    children: [
      SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EndOfDayTabButton(
              callback: () => controller.checkAccountTabIndex.value = 0,
              text: "Veresiyeler",
              selected: controller.checkAccountTabIndex.value == 0,
            ),
            const SizedBox(width: 16),
            EndOfDayTabButton(
                callback: () => controller.checkAccountTabIndex.value = 1,
                text: "Tahsilatlar",
                selected: controller.checkAccountTabIndex.value == 1),
          ],
        ),
      ),
      if (controller.checkAccountTabIndex.value == 0)
        buildCheckAccountReportTable(controller),
      if (controller.checkAccountTabIndex.value == 1)
        buildCheckAccountReceivingReportTable(controller),
    ],
  );
}

Widget buildCheckAccountReportTable(EndOfDayController controller) {
  return Obx(() {
    return Expanded(
      child: CheckAccountReportTable(
        source: controller.checkAccountReportDataSource.value!,
        totalAmount: controller.checkAccountReport.value!.totalLoan!,
      ),
    );
  });
}

Widget buildCheckAccountReceivingReportTable(EndOfDayController controller) {
  return Obx(() {
    return Expanded(
      child: CheckAccountReceivingReportTable(
        source: controller.checkAccountReceivingReportDataSource.value!,
        totalAmount: controller.checkAccountReport.value!.totalReceiving!,
      ),
    );
  });
}

Widget buildUnpayableProductReportTable(EndOfDayController controller) {
  return Obx(() {
    return UnpableProductReport(
      source: controller.unpayableProductsDataSource.value!,
    );
  });
}

Widget buildUnpayableChecksReportTable(EndOfDayController controller) {
  return Obx(() {
    return UnpayableCheckReportTable(
      source: controller.unpayableChecksDataSource.value!,
      totalAmount: controller.unpayableReport.value!.totalAmount!,
    );
  });
}

Widget buildSaleReport(EndOfDayController controller) {
  return Obx(() {
    return SalesReportTable(
      source: controller.saleReportDataSource.value!,
    );
  });
}

Widget buildCheckReport(EndOfDayController controller) {
  return Obx(() {
    return CheckReportTable(
      source: controller.checkReportDataSource.value!,
    );
  });
}

Widget buildGiftReport(EndOfDayController controller) {
  return Obx(() {
    return GiftReportTable(
      source: controller.giftReportDataSource.value!,
    );
  });
}

class OkcPosActionButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final Color color;
  final Color foreColor;
  final double height;
  const OkcPosActionButton({
    Key? key,
    required this.text,
    required this.callback,
    required this.color,
    this.foreColor = Colors.white,
    this.height = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: () => callback(),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: foreColor),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final String title;
  const HeaderText({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 6),
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  final String title;
  final String info;
  final bool isLast;
  const InfoText({
    Key? key,
    required this.title,
    required this.info,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLast ? EdgeInsets.zero : const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            info,
            style: const TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}

class EndOfDayInfoCard extends StatelessWidget {
  final String title;
  final String info;
  final bool isFirst;
  const EndOfDayInfoCard({
    Key? key,
    required this.title,
    required this.info,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: isFirst ? EdgeInsets.zero : const EdgeInsets.only(left: 8),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              info,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFFFB6226),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReportButton extends StatelessWidget {
  final Callback onTap;
  final String title;
  const ReportButton({super.key, required this.onTap, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 56,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

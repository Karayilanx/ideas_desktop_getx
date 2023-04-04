import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/extension/string_extension.dart';
import 'package:intl/intl.dart';

import '../../model/check_model.dart';
import '../../theme/theme.dart';
import '../_utility/loading/loading_screen.dart';
import '../_utility/service_helper.dart';
import '../closed-check/closed-checks/view/closed_checks_view.dart';
import 'check_detail_view_model.dart';
import 'order_logs_table.dart';

class CheckDetailPage extends StatelessWidget with ServiceHelper {
  CheckDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    CheckDetailController controller = Get.put(CheckDetailController());
    return buildBody(controller);
  }

  Widget buildBody(CheckDetailController controller) {
    return Dialog(child: Obx(() {
      return Container(
        width: 8500,
        height: 650,
        color: ideasTheme.scaffoldBackgroundColor,
        child: controller.checkDetail.value != null
            ? buildNew(controller)
            : const LoadingPage(),
      );
    }));
  }

  Widget buildNew(CheckDetailController controller) {
    return Row(
      children: [
        if (controller.selectedTab.value != 2)
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Ürünler',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          var groupedItem = controller.groupedItems[index];
                          return ClosedOrderListTile(groupedItem: groupedItem);
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: controller.groupedItems.length),
                  ),
                ],
              ),
            ),
          ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.changeSelectedTab(0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10)),
                              color: controller.selectedTab.value == 0
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.6)),
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Hesap Bilgileri',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.changeSelectedTab(1),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(),
                              color: controller.selectedTab.value == 1
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.5)),
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Hesap Logları',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.changeSelectedTab(2),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10)),
                              color: controller.selectedTab.value == 2
                                  ? Colors.white
                                  : Colors.grey.withOpacity(0.5)),
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Sipariş Logları',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: controller.selectedTab.value == 0
                      ? Column(
                          children: [
                            const Divider(),
                            Text(controller.checkDetail.value != null
                                ? getCheckString(controller)
                                : ''),
                            const Divider(),
                            Container(
                              height: 210,
                              color: Colors.grey[200],
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blueGrey[100],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          controller.checkDetail.value!
                                                      .checkAccountTransaction !=
                                                  null
                                              ? Text(
                                                  'Cari: ${controller.checkDetail.value!.checkAccountTransaction!.checkAccountName!}')
                                              : Container(),
                                          ClosedCheckPaymentTextRow(
                                              text1: 'Toplam: ',
                                              text2: controller
                                                  .checkDetail
                                                  .value!
                                                  .payments!
                                                  .checkAmount!
                                                  .getPriceString),
                                          const Divider(),
                                          ClosedCheckPaymentTextRow(
                                              text1: 'Nakit: ',
                                              text2: controller
                                                  .checkDetail
                                                  .value!
                                                  .payments!
                                                  .cashAmount!
                                                  .getPriceString),
                                          const Divider(),
                                          ClosedCheckPaymentTextRow(
                                              text1: 'Kredi: ',
                                              text2: controller
                                                  .checkDetail
                                                  .value!
                                                  .payments!
                                                  .creditCardAmount!
                                                  .getPriceString),
                                          const Divider(),
                                          ClosedCheckPaymentTextRow(
                                              text1: 'İskonto: ',
                                              text2: controller
                                                  .checkDetail
                                                  .value!
                                                  .payments!
                                                  .discountAmount!
                                                  .getPriceString),
                                          const Divider(),
                                          ClosedCheckPaymentTextRow(
                                              text1: 'Ödenmez: ',
                                              text2: controller
                                                  .checkDetail
                                                  .value!
                                                  .payments!
                                                  .unpayableAmount!
                                                  .getPriceString),
                                          const Divider(),
                                          ClosedCheckPaymentTextRow(
                                              text1: 'Kalan: ',
                                              text2: controller
                                                  .checkDetail
                                                  .value!
                                                  .payments!
                                                  .remainingAmount!
                                                  .getPriceString),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.printCheck(
                                        controller.checkId,
                                        controller.endOfDayId),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[300],
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.print_outlined),
                                          SizedBox(width: 8),
                                          Text(
                                            'Yazdır',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 1),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => controller.printSlip(
                                        controller.checkId,
                                        controller.endOfDayId),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[300],
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.receipt),
                                          SizedBox(width: 8),
                                          Text(
                                            'Adisyon Yazdır',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : controller.selectedTab.value == 1
                          ? ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                CheckLogModel log = controller.checkLogs[index];
                                return ListTile(
                                  title: Text(log.info!),
                                  subtitle: Text(
                                      '${log.terminalUserName!}\n${getDateString(log.createDate!)}'),
                                );
                              },
                              itemCount: controller.checkLogs.length,
                            )
                          : buildOrderLogsTable(controller),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOrderLogsTable(CheckDetailController controller) {
    return Obx(() {
      return OrderLogsTable(
        source: controller.orderLogsDataSource.value!,
      );
    });
  }

  String getCondimentText(CheckMenuItemModel item) {
    String ret = '';
    for (var menuItem in item.condiments!) {
      ret += '${menuItem.nameTr!},';
    }
    return ret;
  }

  String getItemNoteString(CheckMenuItemModel item) {
    if (item.note != null && item.note!.isNotEmpty) {
      return '        ${item.note!}';
    } else {
      return '';
    }
  }

  String getCheckString(CheckDetailController controller) {
    String closeDate = controller.checkDetail.value!.closeDate != null
        ? ' - (Kapanış: ${DateFormat('dd.MM.yyyy HH:mm').format(controller.checkDetail.value!.closeDate!)})'
        : '';
    if (controller.checkDetail.value!.alias != null &&
        controller.checkDetail.value!.alias != '') {
      return getAliasInformationString(controller);
    } else if (controller.checkDetail.value!.table != null) {
      return getTableInformationString(controller);
    } else if (controller.checkDetail.value!.delivery != null) {
      return 'PAKET SİPARİŞ';
    } else {
      return 'Hızlı Satış \n(Açılış: ${DateFormat('dd.MM.yyyy HH:mm').format(controller.checkDetail.value!.createDate!)}) $closeDate';
    }
  }

  String getAliasInformationString(CheckDetailController controller) {
    String closeDate = controller.checkDetail.value!.closeDate != null
        ? ' - (Kapanış: ${DateFormat('dd.MM.yyyy HH:mm').format(controller.checkDetail.value!.closeDate!)})'
        : '';

    return '${controller.checkDetail.value!.alias} / ${controller.checkDetail.value!.checkId} \n${controller.checkDetail.value!.terminalUsername} (Açılış: ${DateFormat('dd.MM.yyyy HH:mm').format(controller.checkDetail.value!.createDate!)}) $closeDate';
  }

  String getTableInformationString(CheckDetailController controller) {
    String closeDate = controller.checkDetail.value!.closeDate != null
        ? ' - (Kapanış: ${DateFormat('dd.MM.yyyy HH:mm').format(controller.checkDetail.value!.closeDate!)})'
        : '';
    return '${controller.checkDetail.value!.table!.name} / ${controller.checkDetail.value!.checkId} \n${controller.checkDetail.value!.table!.terminalUserName} (Açılış: ${DateFormat('dd.MM.yyyy HH:mm').format(controller.checkDetail.value!.createDate!)}) $closeDate';
  }
}

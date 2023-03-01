import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'package:ideas_desktop_getx/view/closed-check/closed-checks/viewmodel/closed_checks_view_model.dart';
import 'package:styled_text/styled_text.dart';
import '../../../../locale_keys_enum.dart';
import '../../../../model/check_model.dart';
import '../../../_utility/screen_keyboard/screen_keyboard_view.dart';
import '../../../_utility/service_helper.dart';
import '../../component/closed_check_list_tile.dart';

class ClosedChecksPage extends StatelessWidget {
  const ClosedChecksPage({super.key});

  @override
  Widget build(BuildContext context) {
    ClosedChecksController controller = Get.find();
    return SafeArea(
        child: Scaffold(
      body: buildBody(controller),
    ));
  }

  Widget buildBody(ClosedChecksController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Kapanmış hesap ara',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                    controller: controller.searchCtrl,
                    onTap: () async {
                      if (controller.localeManager
                          .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                        var res = await Get.dialog(
                          const ScreenKeyboard(),
                        );
                        if (res != null) {
                          controller.searchCtrl.text = res;
                          buildFilteredItems(controller);
                          controller.filterTables();
                        }
                      }
                    },
                    onChanged: (v) => {
                          buildFilteredItems(controller),
                          controller.filterTables(),
                        }),
              ),
            ),
            GestureDetector(
              onTap: () => controller.closePage(),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Kapat',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Expanded(
                  flex: 75,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(() {
                            return GridView.extent(
                              maxCrossAxisExtent: 300,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              childAspectRatio: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              children: buildFilteredItems(controller),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Obx(() {
                  return Expanded(
                    flex: 25,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200],
                      ),
                      child: controller.checkDetail.value != null
                          ? Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  height: 100,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () => controller
                                                    .printClosedCheck(),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueGrey[300],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                          Icons.print_outlined),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Yazdır',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    controller.printSlip(),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueGrey[500],
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                          Icons.print_outlined),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Adisyon Yazdır',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    controller.restoreCheck(),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueGrey[500],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(Icons
                                                          .restart_alt_rounded),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Geri Yükle',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    controller.restoreCheck(),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueGrey[300],
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(Icons
                                                          .point_of_sale_outlined),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        'Fiş Kes',
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black87),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 75,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        var groupedItem =
                                            controller.groupedCheckItems[index];
                                        return ClosedOrderListTile(
                                            groupedItem: groupedItem);
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider();
                                      },
                                      itemCount:
                                          controller.groupedCheckItems.length),
                                ),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blueGrey[100],
                                          ),
                                          child: SingleChildScrollView(
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
                                                if (controller
                                                    .checkDetail
                                                    .value!
                                                    .payments!
                                                    .paymentDetails!
                                                    .any((element) =>
                                                        element
                                                            .checkPaymentTypeId ==
                                                        0))
                                                  ...getPaymentDetails(controller
                                                      .checkDetail
                                                      .value!
                                                      .payments!
                                                      .paymentDetails!
                                                      .where((element) =>
                                                          element
                                                              .checkPaymentTypeId ==
                                                          0)
                                                      .toList()),
                                                const Divider(),
                                                ClosedCheckPaymentTextRow(
                                                    text1: 'Kredi: ',
                                                    text2: controller
                                                        .checkDetail
                                                        .value!
                                                        .payments!
                                                        .creditCardAmount!
                                                        .getPriceString),
                                                if (controller
                                                    .checkDetail
                                                    .value!
                                                    .payments!
                                                    .paymentDetails!
                                                    .any((element) =>
                                                        element
                                                            .checkPaymentTypeId ==
                                                        1))
                                                  ...getPaymentDetails(controller
                                                      .checkDetail
                                                      .value!
                                                      .payments!
                                                      .paymentDetails!
                                                      .where((element) =>
                                                          element
                                                              .checkPaymentTypeId ==
                                                          1)
                                                      .toList()),
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Detay görmek için sol taraftan hesap seçiniz.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getPaymentDetails(List<PaymentCheckAccountDetailModel> model) {
    List<Widget> ret = [];
    for (var e in model) {
      ret.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "   ${e.checkAcccountName!}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            '${e.amount!.getPriceString} TL',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          )
        ],
      ));
    }
    return ret;
  }
}

class ClosedCheckPaymentTextRow extends StatelessWidget {
  final String text1;
  final String text2;
  const ClosedCheckPaymentTextRow(
      {Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        Text(
          '$text2 TL',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        )
      ],
    );
  }
}

class ClosedOrderListTile extends StatelessWidget with ServiceHelper {
  ClosedOrderListTile({
    Key? key,
    required this.groupedItem,
  }) : super(key: key);

  final GroupedCheckItem groupedItem;

  @override
  Widget build(BuildContext context) {
    String condimentStr = groupedItem.getCondimentNames();
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!, width: 0.8),
            ),
            child: Text(
              groupedItem.itemCount!.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupedItem.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
                SizedBox(height: condimentStr.isNotEmpty ? 4 : 0),
                condimentStr.isNotEmpty
                    ? StyledText(
                        text: condimentStr,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12),
                        tags: {
                          'b': StyledTextTag(
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            groupedItem.totalPrice.getPriceString,
            style: TextStyle(color: Colors.red[800], fontSize: 14),
          ),
        ],
      ),
    );
  }
}

List<Widget> buildFilteredItems(ClosedChecksController controller) {
  List<ClosedCheckListItem> filteredList = controller.checks
      .where((element) =>
          element.checkId!
              .toString()
              .toUpperCase()
              .contains(controller.searchCtrl.text.toUpperCase()) ||
          element.checkName
              .toString()
              .toUpperCase()
              .contains(controller.searchCtrl.text.toUpperCase()))
      .toList();

  if (filteredList.isNotEmpty) {
    return List.generate(filteredList.length, (index) {
      ClosedCheckListItem check = filteredList[index];
      return ClosedCheckListTile(
        check: check,
        isSelected: controller.isAccountSelected(check),
        callback: () => controller.selectCheckAccount(check),
      );
    });
  } else {
    return [];
  }
}

List<Widget> createTables(ClosedChecksController controller) {
  if (controller.checks.isNotEmpty) {
    return List.generate(controller.checks.length, (index) {
      ClosedCheckListItem check = controller.checks[index];
      return ClosedCheckListTile(
        check: check,
        isSelected: controller.isAccountSelected(check),
        callback: () => controller.selectCheckAccount(check),
      );
    });
  } else {
    return [];
  }
}

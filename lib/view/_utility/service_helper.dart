// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:ideas_desktop/signalr/signalr_manager.dart';
import 'package:intl/intl.dart';
import '../../locale_keys_enum.dart';
import '../../locale_manager.dart';
import '../../model/check_model.dart';
import '../../model/delivery_model.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../theme/theme.dart';

abstract class ServiceHelper {
  final SignalRManager signalRManager = SignalRManager.instance!;

  void showSpinner(String message) async {
    Get.defaultDialog(
      title: 'Bağlantı',
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              //
              child: Text(message),
            ),
          ),
        ],
      ),
    );
  }

  void showSnackbarError(String msg) {
    // Get.snackbar("LocaleKeys.general_error".tr(), msg,
    //     backgroundColor: Colors.red.withOpacity(0.4),
    //     colorText: Colors.white,
    //     margin: EdgeInsets.fromLTRB(8, 8, 8, 0));
    Get.defaultDialog(
        title: "Bilgi",
        backgroundColor: Colors.white,
        titleStyle: const TextStyle(color: Colors.black),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ideasTheme.scaffoldBackgroundColor),
            onPressed: () {
              Get.back();
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Tamam',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            )),
        radius: 5,
        content: Text(
          msg,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ));
  }

  Future checkSignalR() async {
    if (signalRManager.hubConnection.state != HubConnectionState.connected) {
      await Get.dialog(AlertDialog(
        content: const Text('Bağlantı kurulamadı lütfen tekrar deneyiniz.'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (signalRManager.hubConnection.state ==
                  HubConnectionState.disconnected) {
                showSpinner('Tekrar Deneniyor');
                try {
                  await signalRManager.hubConnection.start();
                  Get.back();
                } on Exception {
                  Get.back();
                }
              }

              if (signalRManager.hubConnection.state ==
                  HubConnectionState.connected) Get.back();
            },
            child: const Text('Tekrar bağlan'),
          )
        ],
      ));
    }
  }

  Future showDefaultDialog(String title, String msg) async {
    // Get.snackbar("LocaleKeys.general_error".tr(), msg,
    //     backgroundColor: Colors.red.withOpacity(0.4),
    //     colorText: Colors.white,
    //     margin: EdgeInsets.fromLTRB(8, 8, 8, 0));
    await Get.defaultDialog(
        title: title,
        backgroundColor: Colors.white,
        titleStyle: const TextStyle(color: Colors.black),
        cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: ideasTheme.scaffoldBackgroundColor),
            onPressed: () {
              Get.back();
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Tamam',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            )),
        radius: 5,
        content: Text(
          msg,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ));
  }

  Future<bool> openYesNoDialog(String message) async {
    var ret = await Get.defaultDialog(
      title: "İşlem Onayı",
      content: Text(message),
      actions: <Widget>[
        ElevatedButton(
            child: const Text('Onayla'),
            onPressed: () {
              Get.back(result: true);
            }),
        ElevatedButton(
          child: const Text('Vazgeç'),
          onPressed: () {
            Get.back();
          },
        )
      ],
    );

    return ret == true;
  }

  Future<bool> openFisDialog(CheckPaymentTypeEnum type) async {
    var ret = await Get.defaultDialog(
      barrierDismissible: false,
      title: "Fiş",
      content: const Text("Fiş kesmek istiyor musunuz?"),
      actions: [
        SizedBox(
          height: 80,
          width: 120,
          child: ElevatedButton(
            onPressed: () {
              Get.back(result: true);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, foregroundColor: Colors.white),
            child: Text(
              type == CheckPaymentTypeEnum.Cash ? 'Fiş Kes' : 'Posa Gönder',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 80,
          width: 120,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, foregroundColor: Colors.white),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Geç',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
    return ret == true;
  }

  List<GroupedCheckItem> getGroupedMenuItems(
      List<CheckMenuItemModel?> menuItemList) {
    List<GroupedCheckItem> ret = [];
    for (var item in menuItemList) {
      bool found = false;
      for (var groupedItem in ret) {
        if (groupedItem.originalItem!.isSame(item!)) {
          groupedItem.itemCount = 1 + groupedItem.itemCount!;
          groupedItem.totalPrice += item.totalPrice;
          found = true;
          if (item.checkMenuItemId != null) {
            groupedItem.checkMenuItemIds!.add(item.checkMenuItemId!);
          }
          break;
        }
      }
      if (!found) {
        ret.add(GroupedCheckItem(
          name: item!.name,
          checkMenuItemIds:
              item.checkMenuItemId != null ? [item.checkMenuItemId!] : [],
          originalItem: CheckMenuItemModel(
            totalPrice: item.totalPrice,
            actionType: item.actionType,
            condiments: item.condiments,
            isStopped: item.isStopped,
            menuItemId: item.menuItemId,
            name: item.name,
            note: item.note,
            sellUnit: item.sellUnit,
            sellUnitQuantity: item.sellUnitQuantity,
            printerId: item.printerId,
          ),
          sellUnitQuantity: item.sellUnitQuantity,
          itemCount: 1,
          totalPrice: item.totalPrice,
        ));
      }
    }
    return ret;
  }

  String getDeliveryPaymentTypeText(DeliveryPaymentTypeEnum? type) {
    switch (type) {
      case DeliveryPaymentTypeEnum.Cash:
        return 'NAKİT';
      case DeliveryPaymentTypeEnum.Account:
        return 'CARİ';
      case DeliveryPaymentTypeEnum.CreditCard:
        return 'KREDİ KARTI';
      case DeliveryPaymentTypeEnum.Other:
        return 'DİĞER';
      default:
        return '';
    }
  }

  String getDateString(DateTime date) {
    String dateString = '';
    final DateFormat formatter = DateFormat('dd-MMMM-yyyy');
    dateString += formatter.format(date);
    dateString += ' ';
    dateString += DateFormat.Hm().format(date);
    return dateString;
  }

  String getDateStringNumber(DateTime date) {
    String dateString = '';
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    dateString += formatter.format(date);
    dateString += ' ';
    dateString += DateFormat.Hm().format(date);
    return dateString;
  }

  Future checkServerSignalR(BuildContext context) async {
    if (signalRManager.serverHubConnection.state !=
        HubConnectionState.connected) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text(
                'Server ile bağlantı kurulamadı lütfen tekrar deneyiniz.'),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  if (signalRManager.serverHubConnection.state ==
                      HubConnectionState.disconnected) {
                    showSpinner('Tekrar Deneniyor');
                    try {
                      await signalRManager.serverHubConnection.start();
                      Navigator.pop(context);
                    } on Exception {
                      Navigator.pop(context);
                    }
                  }

                  if (signalRManager.serverHubConnection.state ==
                      HubConnectionState.connected) Navigator.pop(context);
                },
                child: const Text('Tekrar bağlan'),
              )
            ],
          );
        },
      );
    }
  }

  String getPort() {
    var ip = LocaleManager.instance.getStringValue(PreferencesKeys.IP_ADDRESS);
    return ip.split(":")[1];
  }

  String getUsername() {
    return LocaleManager.instance.getStringValue(PreferencesKeys.BRANCH_EMAIL);
  }
}

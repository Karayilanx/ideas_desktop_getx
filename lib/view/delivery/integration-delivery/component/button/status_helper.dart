import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/fuudy_model.dart';
import 'package:ideas_desktop_getx/view/delivery/integration-delivery/component/button/select_couirer.dart';
import '../../../../../model/delivery_model.dart';
import '../../../../../model/getir_model.dart';
import '../../../../../model/yemeksepeti_model.dart';
import 'order_deliver_button.dart';
import 'order_make_payment_button.dart';
import 'order_prepare_button.dart';
import 'order_verify_button.dart';
import 'waiting_for_courier_button.dart';
import '../update-status-dialog/update_status_dialog_view_model.dart';
import '../../integration_delivery_view_model.dart';

import 'cancel_order_button.dart';

abstract class StatusHelper {
  List<Widget> getStatusButtons({
    required int statusId,
    String? getirId,
    String? yemeksepetiId,
    int? getirStatus,
    int? checkId,
    CourierModel? courier,
    required bool isVale,
    required bool getirGetirsin,
    required int? fuudyId,
  }) {
    List<Widget> ret = [];

    if (statusId == DeliveryStatusTypeEnum.NewOrder.index) {
      ret.add(OrderVerifyButton(
        getirId: getirId,
        getirStatus: getirStatus,
        yemeksepetiId: yemeksepetiId,
        isVale: isVale,
        fuudyId: fuudyId,
      ));
    } else if (statusId == DeliveryStatusTypeEnum.Preparing.index) {
      ret.add(OrderPrepareButton(
        getirId: getirId,
        yemeksepetiId: yemeksepetiId,
        getirStatus: getirStatus,
        getirGetirsin: getirGetirsin,
        fuudyId: fuudyId,
      ));
    } else if (statusId == DeliveryStatusTypeEnum.OnTheWay.index) {
      ret.add(OrderDeliverButton(
        getirId: getirId,
        yemeksepetiId: yemeksepetiId,
        isVale: isVale,
        checkId: checkId,
        fuudyId: fuudyId,
      ));
    } else if (statusId == DeliveryStatusTypeEnum.Delivered.index) {
      ret.add(OrderMakePaymentButton(
        getirId: getirId,
        checkId: checkId,
        yemeksepetiId: yemeksepetiId,
      ));
    } else if (statusId ==
        DeliveryStatusTypeEnum.WaitingForGetirCourierToFinish.index) {
      ret.add(WaitingForCourierButton(
        getirId: getirId,
        checkId: checkId,
        yemeksepetiId: yemeksepetiId,
      ));
    }

    if (fuudyId == null &&
        statusId != DeliveryStatusTypeEnum.WaitingForSchedule.index &&
        statusId != DeliveryStatusTypeEnum.Completed.index &&
        statusId != DeliveryStatusTypeEnum.Cancelled.index &&
        statusId != DeliveryStatusTypeEnum.Delivered.index &&
        statusId !=
            DeliveryStatusTypeEnum.WaitingForGetirCourierToFinish.index) {
      ret.add(OrderCancelButton(
        getirId: getirId,
        yemeksepetiId: yemeksepetiId,
      ));
    }

    if (fuudyId == null && getirId == null && yemeksepetiId == null) {
      ret.add(SelectCouirerButton(
        checkId: checkId!,
        courierModel: courier,
      ));
    }

    return ret;
  }

  List<Widget> getStatusButtonsForDialog({
    required int statusId,
    String? getirId,
    String? yemeksepetiId,
    int? getirStatus,
    int? checkId,
    required bool isVale,
    required bool getirGetirsin,
    required UpdateStatusDialogController value,
    required int? fuudyId,
  }) {
    List<Widget> ret = [];

    if (statusId == DeliveryStatusTypeEnum.NewOrder.index) {
      ret.add(OrderVerifyButton(
        getirId: getirId,
        getirStatus: getirStatus,
        yemeksepetiId: yemeksepetiId,
        isVale: isVale,
        fuudyId: fuudyId,
      ));
    } else if (statusId == DeliveryStatusTypeEnum.Preparing.index) {
      ret.add(OrderPrepareButton(
        getirId: getirId,
        yemeksepetiId: yemeksepetiId,
        getirStatus: getirStatus,
        getirGetirsin: getirGetirsin,
        fuudyId: fuudyId,
      ));
    } else if (statusId == DeliveryStatusTypeEnum.OnTheWay.index) {
      ret.add(OrderDeliverButton(
        getirId: getirId,
        yemeksepetiId: yemeksepetiId,
        isVale: isVale,
        fuudyId: fuudyId,
      ));
    }

    ret.add(
      ConstrainedBox(
        constraints: BoxConstraints(minWidth: 150),
        child: Container(
          margin: EdgeInsets.fromLTRB(4, 4, 0, 4),
          child: ElevatedButton(
            onPressed: () => value.openPrinterDialog(getirId, yemeksepetiId),
            child: Text(
              'Yazdır',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ),
    );

    ret.add(
      ConstrainedBox(
        constraints: BoxConstraints(minWidth: 150),
        child: Container(
          margin: EdgeInsets.fromLTRB(4, 4, 0, 4),
          child: ElevatedButton(
            onPressed: () => Get.back(),
            child: Text(
              'Vazgeç',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700]!,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ),
    );

    return ret;
  }

  String getTitleTextForDialogYemeksepeti(
      YemeksepetiCheckDetailsModel yemeksepetiCheck) {
    switch (yemeksepetiCheck.status) {
      case 0:
        return 'Sipariş onayı';
      case 1:
        return 'Siparişi yola çıkar';
      case 4:
        return 'Tamamla';
      case 5:
        if (yemeksepetiCheck.deliveryStatusTypeId ==
            DeliveryStatusTypeEnum.Delivered.index) {
          return 'Ödeme Al';
        } else {
          return 'Teslim Edildi';
        }
      case 2:
        return 'Restoran tarafından iptal edildi';
      case 3:
        return 'Teknik nedenlerden iptal edildi';
      default:
        return 'Bilinmiyor';
    }
  }

  String getTitleTextForDialogGetir(GetirCheckDetailsModel getirCheck) {
    switch (getirCheck.status) {
      case 325:
        return 'İleri zamanlı sipariş ön onayı';
      case 350:
        return 'İleri zamanlı sipariş';
      case 400:
        return 'Sipariş onayı';
      case 500:
        if (getirCheck.getirGetirsin!) {
          return 'Sipariş hazırlandı olarak işaretle';
        }
        return 'Siparişi yola çıkar';
      case 550:
        return 'Getir kuryesine teslim edildi olarak işaretle';
      case 600:
        return 'Getir kuryesine teslim edildi';
      case 700:
        return 'Tamamlandı olarak işaretle';
      case 800:
        return 'Getir kuryesi adrese ulaştı';
      case 900:
        if (getirCheck.deliveryStatusTypeId ==
            DeliveryStatusTypeEnum.Delivered.index) {
          return 'Ödeme Al';
        } else {
          return 'Teslim Edildi';
        }
      case 1500:
        return 'Admin tarafından iptal edildi';
      case 1600:
        return 'Restoran tarafından iptal edildi';
      default:
        return 'Bilinmiyor';
    }
  }

  String getTitleTextForDialogFuudy(FuudyCheckDetailsModel fuudyCheck) {
    switch (fuudyCheck.status) {
      case 1:
        return 'Sipariş Geldi';
      case 2:
        return 'Hazırlanıyor';
      case 3:
        return 'Fuudy Kurye Çağrıldı';
      case 4:
        return 'Fuudy Kuryeye Verildi';
      case 5:
        return 'Özel Kuryeye Verildi';
      case 6:
        return 'Tamamlandı';
      case 7:
        return 'Tamamlandı / Kart ile Ödendi';
      case 8:
        return 'Teslim Edilemedi';
      case 9:
        return 'Teslim Edilemedi / Gelmedi';
      case 10:
        return 'Teslim Edilemedi / Geldi Almadı';
      case 11:
        return 'İptal';
      case 12:
        return 'Tamamlandı / Nakit Ödendi';
      case 13:
        return 'Ödeme Bekliyor';
      case 14:
        return 'Fuudy Kurye İptal';
      case 15:
        return 'Özel Kurye İptal';
      case 16:
        return 'Restoran Kuryeye Verildi';
      case 17:
        return 'Restoran Kurye İptal';
      case 18:
        return 'Vigo Kure Çağrıldı';
      case 19:
        return 'Vigo Kuryeye Verildi';
      case 20:
        return 'Vigo Kure İptal';
      case 21:
        return 'Bilinmiyor';
      case 22:
        return 'İlave Ödeme Bekliyor';
      case 23:
        return 'Fuudy Yeni Kurye Çağrıldı';
      case 24:
        return 'Fuudy Yeni Kuryeye Verildi';
      case 25:
        return 'Fuudy Yeni Kurye İptal';
      default:
        return 'Bilinmiyor';
    }
  }
}

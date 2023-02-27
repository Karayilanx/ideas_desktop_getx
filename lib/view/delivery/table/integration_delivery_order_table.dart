import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'package:ideas_desktop_getx/view/delivery/integration-delivery/integration_delivery_view_model.dart';
import '../../../model/delivery_model.dart';
import '../../_utility/service_helper.dart';
import '../integration-delivery/component/button/status_helper.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class IntegrationDeliveryOrderTable extends StatelessWidget {
  final IntegrationDeliveryOrderDataSource source;
  IntegrationDeliveryOrderTable({required this.source});

  @override
  Widget build(BuildContext context) {
    final IntegrationDeliveryController controller = Get.find();

    return SfDataGrid(
      source: source,
      selectionMode: SelectionMode.single,
      allowSorting: true,
      gridLinesVisibility: GridLinesVisibility.both,
      onSelectionChanged: (addedRows, removedRows) {
        var getirId = addedRows[0].getCells()[9].value;
        var yemeksepetiId = addedRows[0].getCells()[10].value;
        var fuudyId = addedRows[0].getCells()[17].value;
        if (getirId != null && getirId != '') {
          controller.openGetirDialog(getirId);
        } else if (yemeksepetiId != null && yemeksepetiId != '') {
          controller.openYemeksepetiDialog(yemeksepetiId);
        } else if (fuudyId != null) {
          // controller.openFuudyDialog(fuudyId);
        }
      },
      columns: [
        GridColumn(
          columnName: 'Müşteri',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Müşteri',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Teslimat Zamanı',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Teslimat Zamanı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Semt/Adres',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Semt/Adres',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Tutar',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Tutar',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Sipariş Tarihi',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Sipariş Tarihi',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Ödeme Yöntemi',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Ödeme Yöntemi',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Durum',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Durum',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'İşlemler',
          columnWidthMode: ColumnWidthMode.fill,
          minimumWidth: 320,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'İşlemler',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'deliveryDate',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'getirId',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'yemeksepetiId',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'integrationString',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'paymentTypeId',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'statusTypeId',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'getirStatusId',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'checkId',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'getirGetirsin',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'fuudyId',
          visible: false,
          label: Container(),
        ),
        GridColumn(
          columnName: 'courier',
          visible: false,
          label: Container(),
        ),
      ],
    );
  }
}

class IntegrationDeliveryOrderDataSource extends DataGridSource
    with ServiceHelper, StatusHelper {
  final IntegrationDeliveryController controller = Get.find();
  IntegrationDeliveryOrderDataSource({
    required List<DeliveryListItem> deliveries,
  }) {
    dataGridRows = deliveries
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'Müşteri', value: dataGridRow.customerFullName),
              DataGridCell<bool>(
                  columnName: 'Teslimat Zamanı',
                  value: dataGridRow.isScheduled),
              DataGridCell<String>(
                  columnName: 'Semt/Adres', value: dataGridRow.region),
              DataGridCell<double>(
                  columnName: 'Tutar', value: dataGridRow.amount),
              DataGridCell<DateTime>(
                  columnName: 'Sipariş Tarihi', value: dataGridRow.createDate),
              DataGridCell<int>(
                  columnName: 'Ödeme Yöntemi',
                  value: dataGridRow.deliveryPaymentTypeId),
              DataGridCell<int>(
                columnName: 'Durum',
                value: dataGridRow.deliveryStatusTypeId,
              ),
              DataGridCell<dynamic>(
                  columnName: 'İşlemler', value: dataGridRow.checkId),
              DataGridCell<dynamic>(
                  columnName: 'deliveryDate', value: dataGridRow.deliveryDate),
              DataGridCell<dynamic>(
                  columnName: 'getirId', value: dataGridRow.getirId),
              DataGridCell<dynamic>(
                  columnName: 'yemeksepetiId',
                  value: dataGridRow.yemeksepetiId),
              DataGridCell<dynamic>(
                  columnName: 'integrationString',
                  value: dataGridRow.integrationPaymentString),
              DataGridCell<dynamic>(
                  columnName: 'paymentTypeId',
                  value: dataGridRow.deliveryPaymentTypeId),
              DataGridCell<dynamic>(
                  columnName: 'statusTypeId',
                  value: dataGridRow.deliveryStatusTypeId),
              DataGridCell<dynamic>(
                  columnName: 'getirStatusId', value: dataGridRow.getirStatus),
              DataGridCell<dynamic>(
                  columnName: 'checkId', value: dataGridRow.checkId),
              DataGridCell<bool>(
                  columnName: 'getirGetirsin',
                  value: dataGridRow.getirGetirsin),
              DataGridCell<int?>(
                  columnName: 'fuudyId', value: dataGridRow.fuudyId),
              DataGridCell<CourierModel?>(
                  columnName: 'courier', value: dataGridRow.courier),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    var getirId = row.getCells()[9].value;
    var yemeksepetiId = row.getCells()[10].value;
    var deliveryStatusTypeId = row.getCells()[13].value;
    var getirStatusId = row.getCells()[14].value;
    var checkId = row.getCells()[15].value;
    var getirGetirsin = row.getCells()[16].value;
    var fuudyId = row.getCells()[17].value;
    var courier = row.getCells()[18].value;
    String getDeliveryTimeString(bool isScheuled) {
      if (!isScheuled) {
        return 'Hemen';
      } else {
        return getDateString(row.getCells()[8].value);
      }
    }

    String getPriceString(double amount) {
      return amount.getPriceString;
    }

    String getPaymentString() {
      if ((getirId != null && getirId != '') ||
          (yemeksepetiId != null && yemeksepetiId != '')) {
        return row.getCells()[11].value;
      } else {
        var id = row.getCells()[12].value;
        if (DeliveryPaymentTypeEnum.Cash.index == id) {
          return 'NAKİT';
        } else if (DeliveryPaymentTypeEnum.CreditCard.index == id) {
          return 'KREDİ KARTI';
        } else if (DeliveryPaymentTypeEnum.Account.index == id) {
          return 'CARİ';
        } else if (DeliveryPaymentTypeEnum.Other.index == id) {
          return 'DİĞER';
        } else {
          return 'HATA';
        }
      }
    }

    String getStatusString() {
      if (deliveryStatusTypeId == DeliveryStatusTypeEnum.NewOrder.index) {
        return 'Yeni Sipariş';
      } else if (deliveryStatusTypeId ==
          DeliveryStatusTypeEnum.Cancelled.index) {
        return 'İptal Edildi';
      } else if (deliveryStatusTypeId ==
          DeliveryStatusTypeEnum.Completed.index) {
        return 'Tamamlandı';
      } else if (deliveryStatusTypeId ==
          DeliveryStatusTypeEnum.Delivered.index) {
        return 'Ödeme Bekliyor';
      } else if (deliveryStatusTypeId ==
          DeliveryStatusTypeEnum.OnTheWay.index) {
        return 'Yolda';
      } else if (deliveryStatusTypeId ==
          DeliveryStatusTypeEnum.Preparing.index) {
        return 'Hazırlanıyor';
      } else if (deliveryStatusTypeId ==
          DeliveryStatusTypeEnum.WaitingForSchedule.index) {
        return 'Ön Onaylandı';
      } else if (deliveryStatusTypeId ==
          DeliveryStatusTypeEnum.WaitingForGetirCourierToFinish.index) {
        return 'Getir Kuryesine Teslim Edildi';
      } else {
        return 'HATA';
      }
    }

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'actions') {
        return IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz));
      } else if (dataGridCell.columnName == 'Teslimat Zamanı') {
        return Container(
            alignment: Alignment.center,
            child: Text(
              getDeliveryTimeString(dataGridCell.value),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ));
      } else if (dataGridCell.columnName == 'Tutar') {
        return Container(
            alignment: Alignment.center,
            child: Text(
              getPriceString(dataGridCell.value),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ));
      } else if (dataGridCell.columnName == 'Sipariş Tarihi') {
        return Container(
            alignment: Alignment.center,
            child: Text(
              getDateString(dataGridCell.value),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ));
      } else if (dataGridCell.columnName == 'Ödeme Yöntemi') {
        return Container(
            alignment: Alignment.center,
            child: Text(
              getPaymentString(),
              textAlign: TextAlign.center,
            ));
      } else if (dataGridCell.columnName == 'Durum') {
        return Container(
            alignment: Alignment.center,
            child: Text(
              getStatusString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ));
      } else if (dataGridCell.columnName == 'İşlemler') {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: getStatusButtons(
              statusId: deliveryStatusTypeId,
              checkId: checkId,
              getirId: getirId,
              getirStatus: getirStatusId,
              yemeksepetiId: yemeksepetiId,
              isVale: controller.restaurantModel != null
                  ? controller.restaurantModel!.isVale!
                  : false,
              getirGetirsin: getirGetirsin ?? false,
              fuudyId: fuudyId,
              courier: courier),
        );
      }
      return Container(
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

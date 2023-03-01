import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'package:ideas_desktop_getx/view/check-account/check-account-transactions/viewmodel/check_account_transactions_view_model.dart';
import 'package:ideas_desktop_getx/view/delivery/integration-delivery/component/button/status_base_button.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../model/check_account_model.dart';
import '../../../_utility/service_helper.dart';
import '../../../check-detail/check_detail_view.dart';

class CheckAccountTransactionsTable extends StatelessWidget {
  final CheckAccountTransactionsDataSource source;
  const CheckAccountTransactionsTable({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SfDataGrid(
        source: source,
        selectionMode: SelectionMode.single,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        gridLinesVisibility: GridLinesVisibility.both,
        onSelectionChanged: (addedRows, removedRows) {
          var checkId = addedRows[0].getCells()[1].value;
          if (checkId != null) {
            var endOfDayId = addedRows[0].getCells()[7].value;
            Get.dialog(CheckDetailPage(), arguments: [checkId, endOfDayId]);
          }
        },
        columns: [
          GridColumn(
            columnName: 'Tarih',
            columnWidthMode: ColumnWidthMode.auto,
            autoFitPadding: const EdgeInsets.all(16),
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Tarih',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'Çek/Fiş No',
            columnWidthMode: ColumnWidthMode.auto,
            autoFitPadding: const EdgeInsets.all(16),
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Çek/Fiş No',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'İşlem Tipi',
            columnWidthMode: ColumnWidthMode.auto,
            autoFitPadding: const EdgeInsets.all(16),
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'İşlem Tipi',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'Alt Bilgi',
            columnWidthMode: ColumnWidthMode.auto,
            autoFitPadding: const EdgeInsets.all(16),
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Alt Bilgi',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'Açıklamalar',
            columnWidthMode: ColumnWidthMode.fill,
            autoFitPadding: const EdgeInsets.all(20),
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: const Text(
                'Açıklamalar',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'Tutar',
            columnWidthMode: ColumnWidthMode.auto,
            autoFitPadding: const EdgeInsets.all(16),
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Tutar',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'actions',
            columnWidthMode: ColumnWidthMode.fill,
            minimumWidth: 320,
            maximumWidth: 320,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'İşlemler',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'endOfDayId',
            visible: false,
            label: Container(),
          ),
          GridColumn(
            columnName: 'checkAccountTransactionId',
            visible: false,
            label: Container(),
          ),
        ],
      ),
    );
  }
}

class CheckAccountTransactionsDataSource extends DataGridSource with ServiceHelper {
  CheckAccountTransactionsController controller = Get.find();
  CheckAccountTransactionsDataSource({required GetCheckAccountTransactionsOutput account}) {
    dataGridRows = account.checkAccountTransactions!
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell(columnName: 'Tarih', value: dataGridRow.createDate),
              DataGridCell<int>(columnName: 'Çek/Fiş No', value: dataGridRow.checkId),
              DataGridCell<String>(
                  columnName: 'İşlem Tipi',
                  value: getTransactionTypeString(dataGridRow.checkAccountTransactionTypeId!)),
              DataGridCell<String>(columnName: 'Alt Bilgi', value: dataGridRow.info),
              const DataGridCell<String>(columnName: 'Açıklamalar', value: ''),
              DataGridCell<double>(columnName: 'Tutar', value: dataGridRow.amount),
              DataGridCell<dynamic>(columnName: 'action', value: dataGridRow),
              DataGridCell<dynamic>(columnName: 'endOfDayId', value: dataGridRow.endOfDayId),
              DataGridCell<dynamic>(
                  columnName: 'checkAccountTransactionId', value: dataGridRow.checkAccountTransactionId),
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
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        if (dataGridCell.columnName == 'Tarih') {
          return Container(
              alignment: Alignment.center,
              child: Text(
                getDateString(dataGridCell.value),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ));
        }
        if (dataGridCell.columnName == 'Çek/Fiş No') {
          return Container(
              alignment: Alignment.center,
              child: Text(
                dataGridCell.value != null ? dataGridCell.value.toString() : '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ));
        } else if (dataGridCell.columnName == 'action') {
          var endOfDayId = row.getCells()[7].value;
          var checkId = row.getCells()[1].value;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatusButton(
                callback: () => controller.printCheckAccountCheck(row.getCells()[1].value, row.getCells()[7].value),
                color: const Color(0xFFF29106),
                text: 'Yazdır',
              ),
              if (endOfDayId == null && checkId == null)
                StatusButton(
                  callback: () => controller.removeCheckAccountTransaction(row.getCells()[8].value),
                  color: Colors.red,
                  text: 'Sil',
                )
              else
                StatusButton(
                  callback: () =>
                      controller.transferCheckAccountTransaction(row.getCells()[8].value, row.getCells()[7].value),
                  color: const Color(0xFFF29106),
                  text: 'Aktar',
                ),
            ],
          );
        } else if (dataGridCell.columnName == 'Tutar') {
          return Container(
              alignment: Alignment.center,
              child: Text(
                (dataGridCell.value as double).getPriceString,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ));
        } else {
          return Container(
              alignment: Alignment.center,
              child: Text(
                dataGridCell.value.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ));
        }
      },
    ).toList());
  }
}

String getTransactionTypeString(int type) {
  switch (type) {
    case 0:
      return 'İskonto';
    case 1:
      return 'Adisyon';
    case 2:
      return 'Nakit Ödeme Alındı';
    case 3:
      return 'Kredi Kartı Ödeme Alındı';
    case 4:
      return 'Nakit Ödeme Yapıldı';
    case 5:
      return 'Kredi Kartı ile Ödeme Yapıldı';
    case 6:
      return 'Ödenmez';
    default:
      return 'Error';
  }
}

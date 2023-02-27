import 'package:flutter/material.dart';
import 'package:ideas_desktop_getx/model/check_model.dart';
import 'package:ideas_desktop_getx/view/_utility/service_helper.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OrderLogsTable extends StatelessWidget {
  final OrderLogsDataSource source;
  // final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  const OrderLogsTable({required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      // columnSizer: _customColumnSizer,
      selectionMode: SelectionMode.single,
      columnWidthMode: ColumnWidthMode.fill,
      headerRowHeight: 30,
      rowHeight: 30,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      allowSorting: true,
      columns: [
        GridColumn(
          columnName: 'orderNo',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: EdgeInsets.all(30),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Sip. No',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'terminalUserName',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Kullanıcı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'createDate',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Tarih',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'menuItemName',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ürün',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'sellUnitQuantity',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Miktar',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'totalPrice',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Tutar',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'orderType',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Tipi',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class OrderLogsDataSource extends DataGridSource with ServiceHelper {
  OrderLogsDataSource({
    required List<OrderLogModel> logs,
  }) {
    dataGridRows = logs
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int?>(
                  columnName: 'orderNo', value: dataGridRow.orderNo),
              DataGridCell<String>(
                  columnName: 'terminalUserName',
                  value: dataGridRow.terminalUserName),
              DataGridCell<DateTime>(
                  columnName: 'createDate', value: dataGridRow.createDate),
              DataGridCell<String>(
                  columnName: 'menuItemName', value: dataGridRow.menuItemName),
              DataGridCell<double>(
                  columnName: 'sellUnitQuantity',
                  value: dataGridRow.sellUnitQuantity),
              DataGridCell<double>(
                  columnName: 'totalPrice', value: dataGridRow.totalPrice),
              DataGridCell<String>(
                  columnName: 'orderType', value: dataGridRow.orderType),
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
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'createDate') {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              getDateString(dataGridCell.value),
              overflow: TextOverflow.ellipsis,
            ));
      }
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

// class CustomColumnSizer extends ColumnSizer {
//   @override
//   double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
//       TextStyle textStyle) {
//     if (column.columnName == 'isAdmin') {
//       cellValue = 'Admin ';
//     }
//     if (column.columnName == 'canGift') {
//       cellValue = "İkram ";
//     }
//     if (column.columnName == 'canDiscount') {
//       cellValue = "İskonto ";
//     }
//     if (column.columnName == 'canTransferCheck') {
//       cellValue = "Aktarma ";
//     }
//     if (column.columnName == 'canRestoreCheck') {
//       cellValue = "Geri Yükleme ";
//     }
//     if (column.columnName == 'canSendCheckToCheckAccount') {
//       cellValue = "Cari ";
//     }
//     if (column.columnName == 'canMakeCheckPayment') {
//       cellValue = "Ödeme ";
//     }
//     if (column.columnName == 'canCancel') {
//       cellValue = "İptal ";
//     }
//     if (column.columnName == 'canEndDay') {
//       cellValue = "Gün Sonu ";
//     }
//     if (column.columnName == 'canSeeActions') {
//       cellValue = "İşlemler ";
//     }
//     if (column.columnName == 'isActive') {
//       cellValue = "Aktif ";
//     }
//     if (column.columnName == 'canMarkUnpayable') {
//       cellValue = "Ödenmez ";
//     }
//     if (column.columnName == 'maxDiscountPercentage') {
//       cellValue = "Max İskonto(%) ";
//     }
//     return super.computeCellWidth(column, row, cellValue, textStyle);
//   }
// }

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../model/end_of_day_cancel_report_model.dart';
import '../../_utility/service_helper.dart';

class GiftReportTable extends StatelessWidget {
  final GiftReportTableDataSource source;
  const GiftReportTable({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      selectionMode: SelectionMode.single,
      headerRowHeight: 30,
      rowHeight: 30,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      columnWidthMode: ColumnWidthMode.auto,
      shrinkWrapRows: true,
      allowSorting: true,
      columns: [
        GridColumn(
          columnName: 'checkName',
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Hesap Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'checkMenuItemName',
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Ürün Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'quantity',
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Adet',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'amount',
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Tutar',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'orderDate',
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Sipariş Zamanı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'cancelDate',
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'İkram Zamanı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Kullanıcı',
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Kullanıcı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class GiftReportTableDataSource extends DataGridSource with ServiceHelper {
  GiftReportTableDataSource({required List<EndOfDayCancelModel> giftReport}) {
    dataGridRows = giftReport
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'checkName', value: dataGridRow.checkName),
              DataGridCell<String>(
                  columnName: 'checkMenuItemName',
                  value: dataGridRow.checkMenuItemName),
              DataGridCell<double>(
                  columnName: 'quantity', value: dataGridRow.quantity),
              DataGridCell<double>(
                  columnName: 'amount', value: dataGridRow.amount),
              DataGridCell<String>(
                columnName: 'orderDate',
                value: getDateString(dataGridRow.orderDate!),
              ),
              DataGridCell<String>(
                columnName: 'cancelDate',
                value: getDateString(dataGridRow.cancelDate!),
              ),
              DataGridCell<String>(
                columnName: 'Kullanıcı',
                value: dataGridRow.terminalUserName!,
              ),
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
      return Container(
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

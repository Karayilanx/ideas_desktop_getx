import 'package:flutter/material.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import '../../../model/end_of_day_check_account_report_model.dart';
import '../../_utility/service_helper.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CheckAccountReceivingReportTable extends StatelessWidget {
  final CheckAccountReceivingReportDataSource source;
  final double totalAmount;
  const CheckAccountReceivingReportTable(
      {required this.source, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      headerRowHeight: 30,
      rowHeight: 30,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      selectionMode: SelectionMode.single,
      columnWidthMode: ColumnWidthMode.fill,
      shrinkWrapRows: true,
      allowSorting: true,
      footerFrozenRowsCount: 1,
      footer: Center(
          child: Text(
        'Toplam Tutar: ${totalAmount.getPriceString}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )),
      columns: [
        GridColumn(
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Hesap Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'createDate',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Tarih',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'type',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Tipi',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'amount',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'Tutar',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class CheckAccountReceivingReportDataSource extends DataGridSource
    with ServiceHelper {
  CheckAccountReceivingReportDataSource(
      {required List<EndOfDayCheckAccountReceivingModel>
          checkAccountReceivingReport}) {
    dataGridRows = checkAccountReceivingReport
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'createDate',
                  value: getDateString(dataGridRow.createDate!)),
              DataGridCell<String>(columnName: 'type', value: dataGridRow.type),
              DataGridCell<double>(
                  columnName: 'amount', value: dataGridRow.amount),
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
          padding: EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

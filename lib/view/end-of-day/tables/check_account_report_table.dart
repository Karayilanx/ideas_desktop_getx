import 'package:flutter/material.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import '../../../model/end_of_day_check_account_report_model.dart';
import '../../_utility/service_helper.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CheckAccountReportTable extends StatelessWidget {
  final CheckAccountReportDataSource source;
  final double totalAmount;
  const CheckAccountReportTable(
      {super.key, required this.source, required this.totalAmount});

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
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      )),
      columns: [
        GridColumn(
          columnName: 'checkId',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Fiş No',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Hesap Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'cash',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Nakit',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'creditCard',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Kredi Kartı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'discount',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'İskonto',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'checkAccountAmount',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Cari',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'total',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Toplam',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class CheckAccountReportDataSource extends DataGridSource with ServiceHelper {
  CheckAccountReportDataSource(
      {required List<EndOfDayCheckAccountCheckModel> checkAccountReport}) {
    dataGridRows = checkAccountReport
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                  columnName: 'checkId', value: dataGridRow.checkId),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<double>(
                  columnName: 'cash', value: dataGridRow.cashAmount),
              DataGridCell<double>(
                  columnName: 'creditCard',
                  value: dataGridRow.creditCardAmount),
              DataGridCell<double>(
                  columnName: 'discount', value: dataGridRow.discountAmount),
              DataGridCell<double>(
                  columnName: 'checkAccountAmount',
                  value: dataGridRow.checkAccountAmount),
              DataGridCell<double>(
                  columnName: 'total', value: dataGridRow.checkAmount),
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

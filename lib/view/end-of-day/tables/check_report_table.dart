import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/end_of_day_check_report_model.dart';
import '../../_utility/service_helper.dart';
import '../../check-detail/check_detail_view.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CheckReportTable extends StatelessWidget {
  final CheckReportDataSource source;
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  CheckReportTable({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      columnSizer: _customColumnSizer,
      headerRowHeight: 30,
      rowHeight: 30,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      selectionMode: SelectionMode.single,
      columnWidthMode: ColumnWidthMode.fill,
      shrinkWrapRows: true,
      allowSorting: true,
      columns: [
        GridColumn(
          columnName: 'actions',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Detay',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'id',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'ID',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'closeDate',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(4),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Kapanış',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.fill,
          autoFitPadding: const EdgeInsets.all(0),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'İsim',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Nakit',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(0),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Nakit',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Kredi',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(0),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Kredi',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Cari',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(0),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Cari',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Toplam',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(0),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Toplam',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'İskonto',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(0),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'İskonto',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Garsoniye',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(0),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Garsoniye',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Hesap',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Hesap',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Kalan',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Kalan',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Ödenmez',
          columnWidthMode: ColumnWidthMode.auto,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Ödenmez',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'endOfDayId',
          columnWidthMode: ColumnWidthMode.auto,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Ödenmez',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class CheckReportDataSource extends DataGridSource with ServiceHelper {
  CheckReportDataSource({required List<EndOfDayCheckReportModel> checks}) {
    dataGridRows = checks
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                  columnName: 'actions', value: dataGridRow.checkId),
              DataGridCell<int>(columnName: 'id', value: dataGridRow.checkId),
              DataGridCell<String>(
                  columnName: 'closeDate',
                  value: getDateStringNumber(dataGridRow.closeDate!)),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<double>(
                  columnName: 'Nakit', value: dataGridRow.cashAmount),
              DataGridCell<double>(
                  columnName: 'Kredi', value: dataGridRow.creditCardAmount),
              DataGridCell<double>(
                  columnName: 'Cari', value: dataGridRow.checkAccountAmount),
              DataGridCell<double>(
                  columnName: 'Toplam', value: dataGridRow.checkAmount),
              DataGridCell<double>(
                  columnName: 'İskonto', value: dataGridRow.discountAmount),
              DataGridCell<double>(
                  columnName: 'Garsoniye',
                  value: dataGridRow.serviceChargeAmount),
              DataGridCell<double>(
                  columnName: 'Hesap', value: dataGridRow.amount),
              DataGridCell<double>(
                  columnName: 'Kalan', value: dataGridRow.verification),
              DataGridCell<bool>(
                  columnName: 'Ödenmez', value: dataGridRow.isUnpayable),
              DataGridCell<int?>(
                  columnName: 'endOfDayId', value: dataGridRow.endOfDayId),
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
    Color getRowBackgroundColor() {
      final bool isUnpayable = row.getCells()[12].value;
      final double checkAccountAmount = row.getCells()[6].value;
      final double verification = row.getCells()[11].value;

      if (verification == 0 || verification == checkAccountAmount) {
        if (isUnpayable) {
          return Colors.green;
        }
        return Colors.transparent;
      } else {
        return Colors.red;
      }
    }

    return DataGridRowAdapter(
        color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          if (dataGridCell.columnName == 'actions') {
            return IconButton(
                onPressed: () async {
                  Get.dialog(CheckDetailPage(), arguments: [
                    row.getCells()[1].value,
                    row.getCells()[13].value,
                  ]);
                },
                icon: const Icon(Icons.more_horiz));
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

class LogReportTable extends StatelessWidget {
  final LogReportDataSource source;

  const LogReportTable({super.key, required this.source});

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
      columns: [
        GridColumn(
          columnName: 'actions',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          allowSorting: false,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              '',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'createDate',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(4),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Tarih',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'logType',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(0),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Tipi',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'info',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          autoFitPadding: const EdgeInsets.all(0),
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Bilgi',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Kullanıcı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'id',
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
          columnName: 'terminalUserId',
          columnWidthMode: ColumnWidthMode.auto,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Kullanıcı No',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'endOfDayId',
          columnWidthMode: ColumnWidthMode.auto,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Gün Sonu No',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class LogReportDataSource extends DataGridSource with ServiceHelper {
  LogReportDataSource({required List<EndOfDayLogModel> logs}) {
    dataGridRows = logs
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                  columnName: 'actions', value: dataGridRow.checkId),
              DataGridCell<String>(
                  columnName: 'createDate',
                  value: getDateStringNumber(dataGridRow.createDate!)),
              DataGridCell<String>(
                columnName: 'logType',
                value: dataGridRow.logType,
              ),
              DataGridCell<String>(columnName: 'info', value: dataGridRow.info),
              DataGridCell<String>(
                  columnName: 'name', value: dataGridRow.terminalUserName),
              DataGridCell<int>(columnName: 'id', value: dataGridRow.checkId),
              DataGridCell<int?>(
                  columnName: 'terminalUserId',
                  value: dataGridRow.terminalUserId),
              DataGridCell<int?>(
                  columnName: 'endOfDayId', value: dataGridRow.endOfDayId),
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
      if (dataGridCell.columnName == 'actions') {
        return IconButton(
            onPressed: () async {
              Get.dialog(CheckDetailPage(), arguments: [
                row.getCells()[5].value,
                row.getCells()[7].value,
              ]);
            },
            icon: const Icon(Icons.more_horiz));
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

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    if (column.columnName == 'actions') {
      cellValue = "Detay ";
    }
    if (column.columnName == 'cashAmount') {
      cellValue = "Nakit ";
      textStyle = const TextStyle(fontWeight: FontWeight.bold);
    }
    if (column.columnName == 'serviceChargeAmount') {
      cellValue = "asd ";
    }
    if (column.columnName == 'isIndigriend') {
      cellValue = "Çıkarılcak Malzeme ";
    }
    if (column.columnName == 'condimentName') {
      textStyle = const TextStyle(fontWeight: FontWeight.bold);
    }

    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}

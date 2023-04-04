import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../model/end_of_day_unpayable_report_model.dart';
import '../../_utility/service_helper.dart';

class UnpableProductReport extends StatelessWidget {
  final UnpayableProductReportDataSource source;

  const UnpableProductReport({super.key, required this.source});

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
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.fill,
          autoFitPadding: const EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Ürün Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'quantity',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(20),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Satış Miktarı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'price',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Tutar',
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ],
    );
  }
}

class UnpayableProductReportDataSource extends DataGridSource
    with ServiceHelper {
  UnpayableProductReportDataSource(
      {required List<EndOfDayUnpayableCheckMenuItemModel> products}) {
    dataGridRows = products
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<double>(
                  columnName: 'quantity', value: dataGridRow.quantity),
              DataGridCell<double>(
                  columnName: 'price', value: dataGridRow.price),
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
            alignment: Alignment.centerLeft,
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ));
      }).toList(),
    );
  }
}

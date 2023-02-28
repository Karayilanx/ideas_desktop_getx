import 'package:flutter/material.dart';
import '../../../model/end_of_day_sales_report.dart';
import '../../_utility/service_helper.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SalesReportTable extends StatelessWidget {
  final SaleReportDataSource source;

  const SalesReportTable({required this.source});

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
          columnName: 'categoryName',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Kategori',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'subCategoryName',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Alt Kategori',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ürün Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'quantity',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: EdgeInsets.all(30),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Satış Miktarı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'price',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: EdgeInsets.all(30),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
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

class SaleReportDataSource extends DataGridSource with ServiceHelper {
  SaleReportDataSource({required List<EndOfDaySaleReportModel> sales}) {
    dataGridRows = sales
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'categoryName', value: dataGridRow.categoryName),
              DataGridCell<String>(
                  columnName: 'subCategoryName',
                  value: dataGridRow.subCategoryName),
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
    Color getRowBackgroundColor() {
      final int index = effectiveRows.indexOf(row);
      if (index % 2 == 0) {
        return Colors.grey[100]!;
      }

      return Colors.transparent;
    }

    return DataGridRowAdapter(
        color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
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

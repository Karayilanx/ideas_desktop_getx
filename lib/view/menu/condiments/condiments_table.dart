import 'package:flutter/material.dart';
import 'package:ideas_desktop/model/menu_model.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CondimentsTable extends StatelessWidget {
  final CondimentsTableDataSource source;
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  CondimentsTable({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(),
      child: SfDataGrid(
        columnSizer: _customColumnSizer,
        source: source,
        headerRowHeight: 30,
        rowHeight: 30,
        shrinkWrapRows: true,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        selectionMode: SelectionMode.single,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        columns: [
          GridColumn(
            columnName: 'condimentName',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: const Text(
                'Grup Adı',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'price',
            columnWidthMode: ColumnWidthMode.auto,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Fiyat',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'mappedCondimentGroups',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Bağlı Grup Sayısı',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'prerequisteLength',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Önkoşul Sayısı',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'isIndigriend',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Çıkarılcak Malzeme',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CondimentsTableDataSource extends DataGridSource {
  CondimentsTableDataSource({
    required List<CondimentForEditOutput> condiments,
  }) {
    dataGridRows = condiments
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'condimentName', value: dataGridRow.nameTr),
              DataGridCell<double>(
                  columnName: 'price', value: dataGridRow.price),
              DataGridCell<List<CondimentCondimentGroupMappingForEditOutput>>(
                  columnName: 'mappedCondimentGroups',
                  value: dataGridRow.condimentCondimentGroupMappings!),
              DataGridCell<int>(
                  columnName: 'prerequisteLength',
                  value: dataGridRow.prerequisiteCondimentMappings!.length),
              DataGridCell<bool>(
                  columnName: 'isIndigriend', value: dataGridRow.isIngredient),
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
          if (dataGridCell.columnName == 'isIndigriend') {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                dataGridCell.value ? 'EVET' : 'HAYIR',
                maxLines: 2,
              ),
            );
          } else if (dataGridCell.columnName == 'mappedCondimentGroups') {
            List<String> text = [];
            for (var element in dataGridCell.value
                as List<CondimentCondimentGroupMappingForEditOutput>) {
              text.add(element.condimentGroup!.nameTr!);
            }
            return Tooltip(
              message: text.join("\n"),
              showDuration: Duration.zero,
              waitDuration: const Duration(milliseconds: 100),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  dataGridCell.value.length.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                dataGridCell.value.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          }
        }).toList());
  }
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    if (column.columnName == 'condimentLength') {
      cellValue = "Ekseçim Sayısı ";
    }
    if (column.columnName == 'mappedCondimentGroups') {
      cellValue = "Bağlı Grup Sayısı ";
    }
    if (column.columnName == 'prerequisteLength') {
      cellValue = "Önkoşul Sayısı ";
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

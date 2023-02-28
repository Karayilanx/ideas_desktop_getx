import 'package:flutter/material.dart';
import 'package:ideas_desktop_getx/model/menu_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class CondimentGroupsTable extends StatelessWidget {
  final CondimentGroupsTableDataSource source;
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  CondimentGroupsTable({required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(),
      child: SfDataGrid(
        columnSizer: _customColumnSizer,
        source: source,
        headerRowHeight: 30,
        shrinkWrapRows: true,
        rowHeight: 30,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        selectionMode: SelectionMode.single,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        columns: [
          GridColumn(
            columnName: 'condimentGroupName',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Text(
                'Grup Adı',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'mappedMenuItem',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Bağlı Ürün Sayısı',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'condimentLength',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Ekseçim Sayısı',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'isRequired',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Zorunlu',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'isMultiple',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Çoklu',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'minCount',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'En Az Seçim Sayısı',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'maxCount',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'En Çok Seçim Sayısı',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'isIndigriend',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Çıkarılcak Malzeme',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'prerequisteLength',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Önkoşul Sayısı',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CondimentGroupsTableDataSource extends DataGridSource {
  CondimentGroupsTableDataSource({
    required List<CondimentGroupForEditOutput> condimentGroups,
  }) {
    dataGridRows = condimentGroups
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<String>(
                  columnName: 'condimentGroupName', value: dataGridRow.nameTr),
              DataGridCell<List<MenuItemCondimentGroupMappingForEditOutput>>(
                  columnName: 'mappedMenuItem',
                  value: dataGridRow.menuItemCondimentGroupMappings),
              DataGridCell<List<CondimentCondimentGroupMappingForEditOutput>>(
                  columnName: 'condimentLength',
                  value: dataGridRow.condimentCondimentGroupMappings!),
              DataGridCell<bool>(
                  columnName: 'isRequired', value: dataGridRow.isRequired),
              DataGridCell<bool>(
                  columnName: 'isMultiple', value: dataGridRow.isMultiple),
              DataGridCell<int>(
                  columnName: 'minCount', value: dataGridRow.minCount),
              DataGridCell<int>(
                  columnName: 'maxCount', value: dataGridRow.maxCount),
              DataGridCell<bool>(
                  columnName: 'isIndigriend', value: dataGridRow.isIngredient),
              DataGridCell<int>(
                  columnName: 'prerequisteLength',
                  value: dataGridRow.prerequisiteCondimentMappings!.length),
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
          if (dataGridCell.columnName == 'isRequired' ||
              dataGridCell.columnName == 'isMultiple' ||
              dataGridCell.columnName == 'isIndigriend') {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                dataGridCell.value ? 'EVET' : 'HAYIR',
                maxLines: 2,
              ),
            );
          } else if (dataGridCell.columnName == 'condimentLength') {
            List<String> text = [];
            for (var element in dataGridCell.value
                as List<CondimentCondimentGroupMappingForEditOutput>) {
              text.add(element.condiment!.nameTr!);
            }
            return Tooltip(
              message: text.join("\n"),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  dataGridCell.value.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              showDuration: Duration.zero,
              waitDuration: Duration(milliseconds: 100),
            );
          } else if (dataGridCell.columnName == 'mappedMenuItem') {
            List<String> text = [];
            for (var element in dataGridCell.value
                as List<MenuItemCondimentGroupMappingForEditOutput>) {
              text.add(element.menuItem!.nameTr!);
            }
            return Tooltip(
              message: text.join("\n"),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  dataGridCell.value.length.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              showDuration: Duration.zero,
              waitDuration: Duration(milliseconds: 100),
            );
          } else {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                dataGridCell.value.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
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
      // textStyle = TextStyle(fontWeight: FontWeight.bold);
    }
    if (column.columnName == 'isRequired') {
      cellValue = 'Zorunlu ';
    }
    if (column.columnName == 'isMultiple') {
      cellValue = "Çoklu ";
    }
    if (column.columnName == 'mappedMenuItem') {
      cellValue = "Bağlı Ürün Sayısı";
    }
    if (column.columnName == 'prerequisteLength') {
      cellValue = "Önkoşul Sayısı ";
    }
    if (column.columnName == 'minCount') {
      cellValue = "En Az Seçim Sayısı ";
    }
    if (column.columnName == 'maxCount') {
      cellValue = "En Çok Seçim Sayısı ";
    }
    if (column.columnName == 'isIndigriend') {
      cellValue = "Çıkarılcak Malzeme ";
    }
    if (column.columnName == 'condimentGroupName') {
      textStyle = TextStyle(fontWeight: FontWeight.bold);
    }

    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/menu_model.dart';
import 'package:ideas_desktop_getx/view/menu/select-condiment-group/select_condiment_group_view_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/theme.dart';

class SelectCondimentTable extends StatelessWidget {
  final SelectCondimentDataSource source;
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  SelectCondimentTable({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(),
      child: SfDataGrid(
        columnSizer: _customColumnSizer,
        source: source,
        headerRowHeight: 30,
        rowHeight: 30,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        selectionMode: SelectionMode.single,
        columnWidthMode: ColumnWidthMode.fill,
        allowSorting: true,
        columns: [
          GridColumn(
            columnName: 'select',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: const Text(
                'Seç',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'condimentGroupName',
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
            columnName: 'condimentLength',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Çoklu',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'isPrerequiste',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Önkoşul',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'condiments',
            columnWidthMode: ColumnWidthMode.fill,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: const Text(
                '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectCondimentDataSource extends DataGridSource {
  SelectCondimentGroupController controller = Get.find();
  SelectCondimentDataSource({
    required List<CondimentGroupForEditOutput> condimentGroups,
  }) {
    dataGridRows = condimentGroups
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                  columnName: 'select', value: dataGridRow.condimentGroupId),
              DataGridCell<String>(
                  columnName: 'condimentGroupName', value: dataGridRow.nameTr),
              DataGridCell<int>(
                  columnName: 'condimentLength',
                  value: dataGridRow.condimentCondimentGroupMappings!.length),
              DataGridCell<bool>(
                  columnName: 'isRequired', value: dataGridRow.isRequired),
              DataGridCell<bool>(
                  columnName: 'isMultiple', value: dataGridRow.isMultiple),
              DataGridCell<bool>(
                  columnName: 'isPrerequiste',
                  value: dataGridRow.prerequisiteCondimentMappings!.isNotEmpty),
              DataGridCell<List<CondimentCondimentGroupMappingForEditOutput>>(
                  columnName: 'condiments',
                  value: dataGridRow.condimentCondimentGroupMappings),
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

    final int condimentGroupId = row.getCells()[0].value;
    final bool selected = controller.isCondimentGroupSelected(condimentGroupId);
    return DataGridRowAdapter(
        color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          if (dataGridCell.columnName == 'select') {
            return Checkbox(
              activeColor: Colors.blue,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: selected,
              onChanged: (show) {
                if (selected) {
                  controller.removeCondimentGroupSelection(condimentGroupId);
                } else {
                  controller.selectCondimentGroup(condimentGroupId);
                }
              },
            );
          } else if (dataGridCell.columnName == 'isRequired' ||
              dataGridCell.columnName == 'isMultiple') {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                dataGridCell.value ? 'EVET' : 'HAYIR',
                maxLines: 2,
              ),
            );
          } else if (dataGridCell.columnName == 'isPrerequiste') {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                dataGridCell.value ? 'VAR' : 'YOK',
              ),
            );
          } else if (dataGridCell.columnName == 'condiments') {
            List<String> text = [];
            for (var element in dataGridCell.value
                as List<CondimentCondimentGroupMappingForEditOutput>) {
              text.add(element.condiment!.nameTr!);
            }
            return Tooltip(
              message: text.join("\n"),
              showDuration: Duration.zero,
              waitDuration: const Duration(milliseconds: 100),
              child: const Icon(
                Icons.info,
                color: Colors.blue,
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
      // textStyle = TextStyle(fontWeight: FontWeight.bold);
    }
    if (column.columnName == 'isRequired') {
      cellValue = 'Zorunlu ';
    }
    if (column.columnName == 'isMultiple') {
      cellValue = "Çoklu ";
    }
    if (column.columnName == 'isPrerequiste') {
      cellValue = "Önkoşul ";
    }
    if (column.columnName == 'condiments') {
      cellValue = "asd";
    }
    if (column.columnName == 'condimentGroupName') {
      textStyle = const TextStyle(fontWeight: FontWeight.bold);
    }
    if (column.columnName == 'select') {
      cellValue = "Seç ";
    }
    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}

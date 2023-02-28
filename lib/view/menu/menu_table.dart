import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/menu_model.dart';
import 'package:ideas_desktop_getx/view/menu/menu_view_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MenuTable extends StatelessWidget {
  final MenuDataSource source;
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  MenuTable({required this.source});

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
        shrinkWrapRows: true,
        allowSorting: true,
        columns: [
          GridColumn(
            columnName: 'isVisible',
            columnWidthMode: ColumnWidthMode.auto,
            visible: false,
            label: Container(
              alignment: Alignment.center,
              child: Text(
                'menuItemId',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'categoryName',
            columnWidthMode: ColumnWidthMode.auto,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
              ),
            ),
          ),
          GridColumn(
            columnName: 'name',
            columnWidthMode: ColumnWidthMode.auto,
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
            columnName: 'printerMappings',
            columnWidthMode: ColumnWidthMode.fitByCellValue,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Yazıcılar',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'price',
            columnWidthMode: ColumnWidthMode.auto,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Fiyat',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'isVisible',
            columnWidthMode: ColumnWidthMode.none,
            width: 80,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Göster',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'topList',
            columnWidthMode: ColumnWidthMode.none,
            width: 90,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Top List',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GridColumn(
            columnName: 'actions',
            columnWidthMode: ColumnWidthMode.none,
            width: 150,
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'İşlemler',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuDataSource extends DataGridSource {
  MenuController controller = Get.find();
  MenuDataSource({
    required List<MenuItemLocalEditModel> menuItems,
  }) {
    dataGridRows = menuItems
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                  columnName: 'menuItemId', value: dataGridRow.menuItemId),
              DataGridCell<String>(
                  columnName: 'categoryName', value: dataGridRow.categoryName),
              DataGridCell<String>(
                  columnName: 'subCategoryName',
                  value: dataGridRow.subCategoryName),
              DataGridCell<String>(
                  columnName: 'name', value: dataGridRow.nameTr),
              DataGridCell<List<MenuItemLocalPrinterMappingModel>>(
                  columnName: 'printerMappings',
                  value: dataGridRow.printerMappings),
              DataGridCell<double>(
                  columnName: 'price', value: dataGridRow.price),
              DataGridCell<bool>(
                  columnName: 'isVisible', value: dataGridRow.isVisible),
              DataGridCell<bool>(
                  columnName: 'topList', value: dataGridRow.topList),
              DataGridCell<MenuItemLocalEditModel>(
                  columnName: 'actions', value: dataGridRow),
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

    final int menuItemId = row.getCells()[0].value;
    return DataGridRowAdapter(
        color: getRowBackgroundColor(),
        cells: row.getCells().map<Widget>((dataGridCell) {
          // ISVISIBLE CheckBox
          if (dataGridCell.columnName == 'isVisible') {
            return Checkbox(
              activeColor: Colors.blue,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: dataGridCell.value,
              onChanged: (show) {
                controller.changeIsVisible(menuItemId, show!);
              },
            );
          } else if (dataGridCell.columnName == 'topList') {
            return Checkbox(
              value: dataGridCell.value,
              onChanged: (topList) {
                controller.changeTopList(menuItemId, topList!);
              },
            );
          } else if (dataGridCell.columnName == 'printerMappings') {
            var selectedPrinterNames = '';

            for (var i = 0; i < dataGridCell.value.length; i++) {
              if (i == 0) {
                selectedPrinterNames += dataGridCell.value[i].printerName;
              } else {
                selectedPrinterNames +=
                    ' - ' + dataGridCell.value[i].printerName;
              }
            }

            return GestureDetector(
              onTap: () {
                controller.openSelectPrinter(menuItemId, dataGridCell.value);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    selectedPrinterNames.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          } else if (dataGridCell.columnName == 'actions') {
            return Row(
              children: [
                TextButton(
                  onPressed: () => controller.navigateToCreateMenuItemPage(
                      dataGridCell.value.serverMenuItemId),
                  child: Text(
                    "Düzenle",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                VerticalDivider(),
                TextButton(
                  onPressed: () =>
                      controller.deleteMenuItem(dataGridCell.value),
                  child: Text("Sil", style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          }
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                dataGridCell.value.toString(),
                maxLines: 1,
              ));
        }).toList());
  }

  @override
  bool shouldRecalculateColumnWidths() {
    return true;
  }
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    if (column.columnName == 'printerMappings') {
      var selectedPrinterNames = '';
      var value = cellValue as List<MenuItemLocalPrinterMappingModel>;

      for (var i = 0; i < value.length; i++) {
        if (i == 0) {
          selectedPrinterNames += value[i].printerName!;
        } else {
          selectedPrinterNames += ' - ' + value[i].printerName!;
        }
      }

      cellValue = selectedPrinterNames;
      textStyle = TextStyle(fontWeight: FontWeight.bold);
    }

    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}

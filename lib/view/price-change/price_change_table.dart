import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/menu_model.dart';
import 'package:ideas_desktop_getx/view/price-change/price_change_view_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PriceChangeTable extends StatelessWidget {
  final PriceChangeDataSource source;
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  PriceChangeTable({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      columnSizer: _customColumnSizer,
      selectionMode: SelectionMode.single,
      columnWidthMode: ColumnWidthMode.fill,
      allowSorting: true,
      headerRowHeight: 30,
      rowHeight: 30,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      shrinkWrapRows: true,
      columns: [
        GridColumn(
          columnName: 'menuItemId',
          columnWidthMode: ColumnWidthMode.auto,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'menuItemId',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'condimentId',
          columnWidthMode: ColumnWidthMode.auto,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'condimentId',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'categoryName',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Kategori',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'subCategoryName',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Alt Kategori',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
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
          columnName: 'price',
          columnWidthMode: ColumnWidthMode.fill,
          autoFitPadding: const EdgeInsets.all(30),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Fiyat',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class PriceChangeDataSource extends DataGridSource {
  PriceChangeController controller = Get.find();
  PriceChangeDataSource({
    required List<PriceChangeItemModel> menuItems,
  }) {
    dataGridRows = menuItems
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int?>(
                  columnName: 'menuItemId', value: dataGridRow.menuItemId),
              DataGridCell<int?>(
                  columnName: 'condimentId', value: dataGridRow.condimentId),
              DataGridCell<String>(
                  columnName: 'categoryName', value: dataGridRow.categoryName),
              DataGridCell<String>(
                  columnName: 'subCategoryName',
                  value: dataGridRow.subCategoryName),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
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
    final int? menuItemId = row.getCells()[0].value;
    final int? condimentId = row.getCells()[1].value;
    TextEditingController ctrl =
        TextEditingController(text: row.getCells()[5].value.toString());
    var focusNode = FocusNode();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        ctrl.selection =
            TextSelection(baseOffset: 0, extentOffset: ctrl.text.length);
      }
    });

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'price') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: TextFormField(
            controller: ctrl,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (newPrice) =>
                controller.changePrice(menuItemId, condimentId, newPrice),
            onTap: () {
              ctrl.selection =
                  TextSelection(baseOffset: 0, extentOffset: ctrl.text.length);
            },
            focusNode: focusNode,
          ),
        );
      }
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ));
    }).toList());
  }
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    textStyle = const TextStyle(fontWeight: FontWeight.bold);
    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}

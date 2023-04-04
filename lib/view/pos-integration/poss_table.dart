import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/model/eft_pos_model.dart';
import 'package:ideas_desktop/view/pos-integration/pos_integration_view_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PossTable extends StatelessWidget {
  final PossDataSource source;
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  PossTable({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      columnSizer: _customColumnSizer,
      selectionMode: SelectionMode.single,
      allowEditing: true,
      navigationMode: GridNavigationMode.cell,
      columnWidthMode: ColumnWidthMode.fill,
      headerRowHeight: 30,
      rowHeight: 30,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      shrinkWrapRows: true,
      columns: [
        GridColumn(
          columnName: 'ID',
          columnWidthMode: ColumnWidthMode.fill,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'ID',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Cihaz Adı',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'Cihaz Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'IP Adresi',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'IP Adresi',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Fiscal Kodu',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Fiscal Kodu',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Banka Kodu',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Banka Kodu',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Cari Hesap',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Cari Hesap',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'İşlemler',
          columnWidthMode: ColumnWidthMode.auto,
          width: 260,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'İşlemler',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'checkAccountIds',
          columnWidthMode: ColumnWidthMode.fill,
          autoFitPadding: const EdgeInsets.all(30),
          visible: false,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              '',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'branchId',
          columnWidthMode: ColumnWidthMode.fill,
          autoFitPadding: const EdgeInsets.all(30),
          visible: false,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              '',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class PossDataSource extends DataGridSource {
  PosIntegrationController controller = Get.find();
  PossDataSource({
    required List<EftPosModel> menuItems,
  }) {
    dataGridRows = menuItems
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int?>(columnName: 'ID', value: dataGridRow.eftPosId),
              DataGridCell<String>(
                  columnName: 'Cihaz Adı', value: dataGridRow.eftPosName),
              DataGridCell<String>(
                  columnName: 'IP Adresi', value: dataGridRow.ipAddress),
              DataGridCell<String>(
                  columnName: 'Fiscal Kodu', value: dataGridRow.fiscalId),
              DataGridCell<String>(
                  columnName: 'Banka Kodu', value: dataGridRow.acquirerId),
              DataGridCell<String>(
                  columnName: 'Cari Hesap',
                  value: dataGridRow.checkAccountName),
              DataGridCell<int>(
                  columnName: 'İşlemler', value: dataGridRow.eftPosId),
              DataGridCell<List<int>>(
                  columnName: 'checkAccountIds',
                  value: dataGridRow.checkAccountIds),
              DataGridCell<int>(
                  columnName: 'branchId', value: dataGridRow.branchId),
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
    final int? eftPosId = row.getCells()[0].value;
    final List<int>? checkAccountIds = row.getCells()[7].value;
    TextEditingController nameCtrl =
        TextEditingController(text: row.getCells()[1].value.toString());
    TextEditingController ipCtrl =
        TextEditingController(text: row.getCells()[2].value.toString());
    TextEditingController fiscalCtrl =
        TextEditingController(text: row.getCells()[3].value.toString());
    TextEditingController acquirerCtrl =
        TextEditingController(text: row.getCells()[4].value.toString());
    var focusNode = FocusNode();

    // focusNode.addListener(() {
    //   if (focusNode.hasFocus) {
    //     ctrl.selection =
    //         TextSelection(baseOffset: 0, extentOffset: ctrl.text.length);
    //   }
    // });
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'Cihaz Adı') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: TextFormField(
            controller: nameCtrl,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (name) => controller.changeName(eftPosId, name),
            onTap: () {
              nameCtrl.selection = TextSelection(
                  baseOffset: 0, extentOffset: nameCtrl.text.length);
            },
            focusNode: focusNode,
          ),
        );
      } else if (dataGridCell.columnName == 'IP Adresi') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: TextFormField(
            controller: ipCtrl,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (name) => controller.changeIp(eftPosId, name),
            onTap: () {
              ipCtrl.selection = TextSelection(
                  baseOffset: 0, extentOffset: ipCtrl.text.length);
            },
          ),
        );
      } else if (dataGridCell.columnName == 'Fiscal Kodu') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: TextFormField(
            controller: fiscalCtrl,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (name) => controller.changeFiscal(eftPosId, name),
            onTap: () {
              fiscalCtrl.selection = TextSelection(
                  baseOffset: 0, extentOffset: fiscalCtrl.text.length);
            },
          ),
        );
      } else if (dataGridCell.columnName == 'Banka Kodu') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: TextFormField(
            controller: acquirerCtrl,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (name) => controller.changeacquirer(eftPosId, name),
            onTap: () {
              acquirerCtrl.selection = TextSelection(
                  baseOffset: 0, extentOffset: acquirerCtrl.text.length);
            },
          ),
        );
      } else if (dataGridCell.columnName == 'Cari Hesap') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: DropdownButtonHideUnderline(
            child: Obx(() {
              return DropdownButton2(
                isExpanded: true,
                hint: const Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'Cari Hesap Seçiniz',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                items: buildCondimentDropdownItems(controller, eftPosId!),
                onChanged: (value) {},
                buttonHeight: 40,
                buttonWidth: 230,
                itemHeight: 30,
                dropdownWidth: 300,
                itemPadding: EdgeInsets.zero,
                value: checkAccountIds!.isEmpty ? null : checkAccountIds.last,
                selectedItemBuilder: (context) {
                  return List.generate(controller.checkAccounts.length,
                      (index) {
                    return Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "${checkAccountIds.length} tane seçildi",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
                    );
                  });
                },
              );
            }),
          ),
        );
      } else if (dataGridCell.columnName == 'İşlemler') {
        return Row(
          children: [
            TextButton(
              onPressed: () => controller.removeEftPos(eftPosId!),
              child: const Text(
                "Sil",
                style: TextStyle(color: Colors.red),
              ),
            ),
            const VerticalDivider(),
            TextButton(
              onPressed: () => controller.voidReceipt(eftPosId!),
              child: const Text(
                "Fiş İptal",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            const VerticalDivider(),
            TextButton(
              onPressed: () => controller.closeReceipt(eftPosId!),
              child: const Text(
                "Belge Kapat",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
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

List<DropdownMenuItem<Object>> buildCondimentDropdownItems(
    PosIntegrationController controller, int eftPosId) {
  List<DropdownMenuItem<Object>> ret = [];
  for (var con in controller.checkAccounts) {
    ret.add(DropdownMenuItem(
      value: con.checkAccountId,
      enabled: true,
      child: Obx(() {
        return InkWell(
          onTap: () {
            controller.isCheckAccountSelected(con.checkAccountId!, eftPosId)
                ? controller.removeCondiment(con.checkAccountId, eftPosId)
                : controller.addCondiment(con.checkAccountId, eftPosId);
          },
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                controller.isCheckAccountSelected(con.checkAccountId!, eftPosId)
                    ? const Icon(Icons.check_box_outlined)
                    : const Icon(Icons.check_box_outline_blank),
                const SizedBox(width: 16),
                Text(
                  con.name!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ));
  }
  return ret;
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    textStyle = const TextStyle(fontWeight: FontWeight.bold);
    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/branch_model.dart';
import 'package:ideas_desktop_getx/view/terminal-users/terminal_users_view_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TerminalUsersTable extends StatelessWidget {
  final TerminalUsersDataSource source;
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();
  TerminalUsersTable({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      columnSizer: _customColumnSizer,
      selectionMode: SelectionMode.single,
      columnWidthMode: ColumnWidthMode.fill,
      headerRowHeight: 30,
      rowHeight: 30,
      gridLinesVisibility: GridLinesVisibility.both,
      headerGridLinesVisibility: GridLinesVisibility.both,
      // allowSorting: true,
      columns: [
        GridColumn(
          columnName: 'terminalUserId',
          columnWidthMode: ColumnWidthMode.auto,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: const Text(
              'terminalUserId',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(30),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'pin',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Pin',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'maxDiscountPercentage',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Max İskonto(%)',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'isAdmin',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Admin',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canGift',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'İkram',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canMarkUnpayable',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Ödenmez',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canDiscount',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'İskonto',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canTransferCheck',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Aktarma',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canRestoreCheck',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Geri Yükleme',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canSendCheckToCheckAccount',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Cari',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canMakeCheckPayment',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Ödeme',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canCancel',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'İptal',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canEndDay',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Gün Sonu',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'canSeeActions',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
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
          columnName: 'isActive',
          columnWidthMode: ColumnWidthMode.fitByCellValue,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Aktif',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}

class TerminalUsersDataSource extends DataGridSource {
  TerminalUsersController controller = Get.find();
  TerminalUsersDataSource({
    required List<TerminalUserModel> menuItems,
  }) {
    dataGridRows = menuItems
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                  columnName: 'terminalUserId',
                  value: dataGridRow.terminalUserId),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(columnName: 'pin', value: dataGridRow.pin),
              DataGridCell<int?>(
                  columnName: 'maxDiscountPercentage',
                  value: dataGridRow.maxDiscountPercentage),
              DataGridCell<bool>(
                  columnName: 'isAdmin', value: dataGridRow.isAdmin),
              DataGridCell<bool>(
                  columnName: 'canGift', value: dataGridRow.canGift),
              DataGridCell<bool>(
                  columnName: 'canMarkUnpayable',
                  value: dataGridRow.canMarkUnpayable),
              DataGridCell<bool>(
                  columnName: 'canDiscount', value: dataGridRow.canDiscount),
              DataGridCell<bool>(
                  columnName: 'canTransferCheck',
                  value: dataGridRow.canTransferCheck),
              DataGridCell<bool>(
                  columnName: 'canRestoreCheck',
                  value: dataGridRow.canRestoreCheck),
              DataGridCell<bool>(
                  columnName: 'canSendCheckToCheckAccount',
                  value: dataGridRow.canSendCheckToCheckAccount),
              DataGridCell<bool>(
                  columnName: 'canMakeCheckPayment',
                  value: dataGridRow.canMakeCheckPayment),
              DataGridCell<bool>(
                  columnName: 'canCancel', value: dataGridRow.canCancel),
              DataGridCell<bool>(
                  columnName: 'canEndDay', value: dataGridRow.canEndDay),
              DataGridCell<bool>(
                  columnName: 'canSeeActions',
                  value: dataGridRow.canSeeActions),
              DataGridCell<bool>(
                  columnName: 'isActive', value: dataGridRow.isActive),
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
    final int terminalUserId = row.getCells()[0].value;
    TextEditingController nameCtrl =
        TextEditingController(text: row.getCells()[1].value.toString());

    TextEditingController pinCtrl =
        TextEditingController(text: row.getCells()[2].value.toString());

    TextEditingController maxDiscountController = TextEditingController(
        text: row.getCells()[3].value != null
            ? row.getCells()[3].value.toString()
            : '100');

    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'name') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: TextFormField(
            controller: nameCtrl,
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (newName) =>
                controller.changeName(terminalUserId, newName),
          ),
        );
      } else if (dataGridCell.columnName == 'pin') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: TextFormField(
            controller: pinCtrl,
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (newPin) => controller.changePin(terminalUserId, newPin),
          ),
        );
      } else if (dataGridCell.columnName == 'maxDiscountPercentage') {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
          child: TextFormField(
            controller: maxDiscountController,
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: (newDiscountPercentage) =>
                controller.changeMaxDiscountPercentage(
                    terminalUserId, newDiscountPercentage),
          ),
        );
      } else if (dataGridCell.columnName == 'canGift') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanGift(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'canMarkUnpayable') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanMarkUnpayable(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'canDiscount') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanDiscount(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'canTransferCheck') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanTransferCheck(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'canRestoreCheck') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanRestoreCheck(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'canSendCheckToCheckAccount') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanSendCheckToCheckAccount(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'canMakeCheckPayment') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanMakeCheckPayment(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'canCancel') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanCancel(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'canEndDay') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanEndDay(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'canSeeActions') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeCanSeeActions(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'isActive') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeIsActive(terminalUserId, val!);
          },
        );
      } else if (dataGridCell.columnName == 'isAdmin') {
        return Checkbox(
          value: dataGridCell.value,
          activeColor: Colors.blue,
          onChanged: (val) {
            controller.changeIsAdmin(terminalUserId, val!);
          },
        );
      }

      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    if (column.columnName == 'isAdmin') {
      cellValue = 'Admin ';
    }
    if (column.columnName == 'canGift') {
      cellValue = "İkram ";
    }
    if (column.columnName == 'canDiscount') {
      cellValue = "İskonto ";
    }
    if (column.columnName == 'canTransferCheck') {
      cellValue = "Aktarma ";
    }
    if (column.columnName == 'canRestoreCheck') {
      cellValue = "Geri Yükleme ";
    }
    if (column.columnName == 'canSendCheckToCheckAccount') {
      cellValue = "Cari ";
    }
    if (column.columnName == 'canMakeCheckPayment') {
      cellValue = "Ödeme ";
    }
    if (column.columnName == 'canCancel') {
      cellValue = "İptal ";
    }
    if (column.columnName == 'canEndDay') {
      cellValue = "Gün Sonu ";
    }
    if (column.columnName == 'canSeeActions') {
      cellValue = "İşlemler ";
    }
    if (column.columnName == 'isActive') {
      cellValue = "Aktif ";
    }
    if (column.columnName == 'canMarkUnpayable') {
      cellValue = "Ödenmez ";
    }
    if (column.columnName == 'maxDiscountPercentage') {
      cellValue = "Max İskonto(%) ";
    }
    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}

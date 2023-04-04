import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../model/check_model.dart';
import '../../_utility/service_helper.dart';
import '../../check-detail/check_detail_view.dart';
import '../../delivery/integration-delivery/component/button/status_base_button.dart';
import '../requests_view_model.dart';

class CancelRequestsTable extends StatelessWidget {
  final CancelRequestsDataSource source;
  const CancelRequestsTable({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: source,
      selectionMode: SelectionMode.single,
      columnWidthMode: ColumnWidthMode.fill,
      allowSorting: true,
      gridLinesVisibility: GridLinesVisibility.both,
      onCellTap: (details) {
        var index = details.rowColumnIndex.rowIndex;
        if (index == 0) return;
        var checkId = source.dataGridRows[index - 1].getCells()[6].value;
        if (checkId != null) {
          Get.dialog(CheckDetailPage(), arguments: [
            checkId,
            null,
          ]);
        }
      },
      onSelectionChanged: (addedRows, removedRows) {
        // var checkId = addedRows[0].getCells()[6].value;
        // if (checkId != null) {
        //   Get.dialog(CheckDetailPage(
        //     checkId: checkId,
        //     endOfDayId: null,
        //   ));
        // }
      },
      columns: [
        GridColumn(
          columnName: 'Tarih',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Tarih',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Kullanıcı Adı',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Kullanıcı Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'İşlem Tipi',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'İşlem Tipi',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Adet/Ürün',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: const EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Adet/Ürün',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'Açıklamalar',
          columnWidthMode: ColumnWidthMode.fill,
          autoFitPadding: const EdgeInsets.all(20),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: const Text(
              'Açıklamalar',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'actions',
          columnWidthMode: ColumnWidthMode.fill,
          minimumWidth: 320,
          maximumWidth: 320,
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
          columnName: 'checkId',
          visible: false,
          label: Container(),
        ),
      ],
    );
  }
}

class CancelRequestsDataSource extends DataGridSource with ServiceHelper {
  RequestsController controller = Get.find();
  CancelRequestsDataSource({
    required List<CancelRequest> cancelRequests,
  }) {
    dataGridRows = cancelRequests
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell(columnName: 'Tarih', value: dataGridRow.createDate),
              DataGridCell<String>(
                  columnName: 'Kullanıcı Adı',
                  value: dataGridRow.terminalUserName),
              DataGridCell<int>(
                  columnName: 'İşlem Tipi', value: dataGridRow.cancelTypeId),
              DataGridCell<String>(
                  columnName: 'Adet/Ürün',
                  value: '${dataGridRow.rows!.length} X ${dataGridRow.name!}'),
              DataGridCell<String>(
                  columnName: 'Açıklamalar', value: dataGridRow.note),
              DataGridCell<CancelRequest>(
                  columnName: 'action', value: dataGridRow),
              DataGridCell<int>(
                  columnName: 'checkId', value: dataGridRow.checkId),
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
        cells: row.getCells().map<Widget>(
      (dataGridCell) {
        if (dataGridCell.columnName == 'Tarih') {
          return Container(
              alignment: Alignment.center,
              child: Text(
                getDateString(dataGridCell.value),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ));
        } else if (dataGridCell.columnName == 'İşlem Tipi') {
          return Container(
              alignment: Alignment.center,
              child: Text(
                getCancelType(dataGridCell.value),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ));
        } else if (dataGridCell.columnName == 'action') {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StatusButton(
                callback: () => controller.confirmCancelRequest(
                    (dataGridCell.value as CancelRequest)
                        .checkMenuItemCancelRequestId!),
                color: const Color(0xFFF29106),
                text: 'Onayla',
              ),
              StatusButton(
                callback: () => controller.rejectCancelRequest(
                    (dataGridCell.value as CancelRequest)
                        .checkMenuItemCancelRequestId!),
                color: Colors.red,
                text: 'Reddet',
              ),
            ],
          );
        } else {
          return Container(
              alignment: Alignment.center,
              child: Text(
                dataGridCell.value.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ));
        }
      },
    ).toList());
  }
}

String getCancelType(int type) {
  switch (type) {
    case 0:
      return 'İptal';
    case 1:
      return 'Zayi';
    default:
      return 'Hata';
  }
}

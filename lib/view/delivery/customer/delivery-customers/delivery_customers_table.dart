import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/model/delivery_model.dart';
import 'package:ideas_desktop_getx/view/delivery/customer/delivery-customers/viewmodel/delivery_customers_view_model.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DeliveryCustomersTable extends StatelessWidget {
  final DeliveryCustomersDataSource source;

  const DeliveryCustomersTable({required this.source});

  @override
  Widget build(BuildContext context) {
    DeliveryCustomersController controller = Get.find();
    return SfDataGrid(
      source: source,
      selectionMode: SelectionMode.single,
      columnWidthMode: ColumnWidthMode.fill,
      allowSorting: true,
      onSelectionChanged: (addedRows, removedRows) async {
        if (controller.showSelect) {
          await controller.selectCustomer(
              addedRows[0].getCells()[0].value,
              addedRows[0].getCells()[2].value,
              addedRows[0].getCells()[1].value);
        }
      },
      columns: [
        GridColumn(
          columnName: 'deliveryCustomerId',
          columnWidthMode: ColumnWidthMode.auto,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'deliveryCustomerId',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'deliveryCustomerAddressId',
          columnWidthMode: ColumnWidthMode.auto,
          visible: false,
          label: Container(
            alignment: Alignment.center,
            child: Text(
              'deliveryCustomerAddressId',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: EdgeInsets.all(16),
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Müşteri Adı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'phoneNumber',
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Telefon',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'addressTitle',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Adres Başlığı',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'address',
          columnWidthMode: ColumnWidthMode.fill,
          label: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Adres',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'actions',
          columnWidthMode: ColumnWidthMode.auto,
          autoFitPadding: EdgeInsets.all(30),
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
    );
  }
}

class DeliveryCustomersDataSource extends DataGridSource {
  DeliveryCustomersController controller = Get.find();
  DeliveryCustomersDataSource({
    required List<DeliveryCustomerTableRowModel> customers,
  }) {
    dataGridRows = customers
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<int>(
                  columnName: 'deliveryCustomerId',
                  value: dataGridRow.deliveryCustomerId),
              DataGridCell<int>(
                  columnName: 'deliveryCustomerAddressId',
                  value: dataGridRow.deliveryCustomerAddressId),
              DataGridCell<String>(
                  columnName: 'name', value: dataGridRow.fullName),
              DataGridCell<String>(
                  columnName: 'phoneNumber', value: dataGridRow.phoneNumber),
              DataGridCell<String>(
                  columnName: 'addressTitle', value: dataGridRow.addressTitle),
              DataGridCell<String>(
                  columnName: 'address', value: dataGridRow.address),
              DataGridCell<String>(
                  columnName: 'actions',
                  value: 'asdasdasdsadsadsdasdasaasddasdasd'),
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
    // final int deliveryCustomerId = row.getCells()[0].value;
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      if (dataGridCell.columnName == 'actions') {
        return Row(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await controller.addAddress(
                      row.getCells()[0].value, row.getCells()[2].value);
                },
                child: Text('Adres Ekle')),
            SizedBox(width: 8),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await controller.editCustomer(row.getCells()[0].value,
                      row.getCells()[2].value, row.getCells()[1].value);
                },
                child: Text('Düzenle')),
            if (controller.showSelect) SizedBox(width: 8),
            if (controller.showSelect)
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () async {
                    await controller.selectCustomer(row.getCells()[0].value,
                        row.getCells()[2].value, row.getCells()[1].value);
                  },
                  child: Text('Seç')),
          ],
        );
      }
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

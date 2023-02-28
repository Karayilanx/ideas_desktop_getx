import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'multi_select_view_model.dart';

class MultiSelectDialog<T> extends StatelessWidget {
  const MultiSelectDialog();

  @override
  Widget build(BuildContext context) {
    MultiSelectController controller = Get.put(MultiSelectController());
    return AlertDialog(
      title: Text('Filtre'),
      contentPadding: EdgeInsets.only(top: 12.0),
      content: SingleChildScrollView(
        child: ListTileTheme(
          contentPadding: EdgeInsets.fromLTRB(14.0, 0.0, 24.0, 0.0),
          child: Obx(() {
            return ListBody(
              children: controller.items
                  .map<Widget>((e) =>
                      _buildItem(e as MultiSelectDialogItem<T>, controller))
                  .toList(),
            );
          }),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Vazgeç'),
          onPressed: () => controller.onCancelTap(),
        ),
        ElevatedButton(
          child: Text('Onayla'),
          onPressed: () => controller.onSubmitTap(),
        )
      ],
    );
  }

  Widget _buildItem(
      MultiSelectDialogItem<T> item, MultiSelectController controller) {
    final checked = controller.selectedValues.contains(item.value);
    return CheckboxListTile(
      value: checked,
      title: Text(item.label),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (checked) =>
          controller.onItemCheckedChange(item.value, checked!),
    );
  }
}

class MultiSelectDialogItem<T> {
  const MultiSelectDialogItem(this.value, this.label);

  final T value;
  final String label;
}

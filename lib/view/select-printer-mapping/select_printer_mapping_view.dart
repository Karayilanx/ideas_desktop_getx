import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/select-printer-mapping/select_printer_mapping_view_model.dart';
import '../../theme/theme.dart';

class SelectPrinterMapping extends StatelessWidget {
  const SelectPrinterMapping({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SelectPrinterMappingController controller =
        Get.put(SelectPrinterMappingController());
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          width: 600,
          height: 400,
          child: buildBody(controller),
        )
      ],
    );
  }

  Widget buildBody(SelectPrinterMappingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: ideasTheme.scaffoldBackgroundColor,
          height: 60,
          child: const Center(
            child: Text(
              'Yazıcı Seçimi',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: Obx(() => ListView.builder(
                itemBuilder: (context, index) {
                  var printer = controller.printers[index];
                  return Obx(() {
                    return CheckboxListTile(
                      value: controller.isPrinterSelected(printer),
                      onChanged: (val) => controller.selectPrinter(printer),
                      title: Text(printer.printerName!),
                    );
                  });
                },
                itemCount: controller.printers.length,
              )),
        ),
        Container(
            height: 60,
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Get.back(result: controller.selectedPrinters),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ideasTheme.scaffoldBackgroundColor),
                    child: const Center(
                      child: Text(
                        'KAYDET',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red),
                    child: const Center(
                      child: Text(
                        'VAZGEÇ',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

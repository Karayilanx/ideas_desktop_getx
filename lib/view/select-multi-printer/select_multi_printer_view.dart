import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../locale_keys_enum.dart';
import '../../theme/theme.dart';
import '../_utility/loading/loading_screen.dart';
import 'select_multi_printer_view_model.dart';

class SelectMultiPrinter extends StatelessWidget {
  final List<String> printerIds;
  final bool save;
  const SelectMultiPrinter(
      {Key? key, this.printerIds = const [], this.save = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SelectMultiPrinterController controller =
        Get.put(SelectMultiPrinterController());
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(0),
      children: [
        Obx(() {
          return SizedBox(
            width: 600,
            height: 400,
            child: controller.printers.isNotEmpty
                ? buildBody(controller)
                : const LoadingPage(),
          );
        })
      ],
    );
  }

  Widget buildBody(SelectMultiPrinterController controller) {
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
          child: ListView.builder(
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
          ),
        ),
        Container(
            height: 60,
            margin: const EdgeInsets.fromLTRB(0, 0, 10, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.localeManager.setSetStringList(
                      PreferencesKeys.PRINTER_IDS,
                      controller.selectedPrinters
                          .map((e) => e.printerId.toString())
                          .toList(),
                    );
                    Get.back(result: controller.selectedPrinters);
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ideasTheme.scaffoldBackgroundColor),
                    child: const Center(
                      child: Text(
                        'YAZDIR',
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

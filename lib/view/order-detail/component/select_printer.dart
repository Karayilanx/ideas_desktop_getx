import 'package:flutter/material.dart';
import 'package:ideas_desktop_getx/extension/context_extension.dart';
import '../../../model/printer_model.dart';

class SelectPrinter extends StatelessWidget {
  final List<PrinterOutput> printers;

  const SelectPrinter(this.printers, {super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        SizedBox(
          width: context.width * 50 / 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: context.theme.primaryColor,
                  padding: const EdgeInsets.all(10),
                  child: const Center(
                    child: Text(
                      'Yazıcı Seç',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    crossAxisSpacing: 10,
                    children: createPrinters(context),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, null);
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 8)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ))),
                        child: const Text(
                          'Vazgeç',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> createPrinters(BuildContext context) {
    if (printers.isNotEmpty) {
      return List.generate(printers.length, (index) {
        PrinterOutput printer = printers[index];
        return ElevatedButton(
            onPressed: () {
              Navigator.pop(context, printer);
            },
            child: Text(printer.printerName!));
      });
    } else {
      return [];
    }
  }
}

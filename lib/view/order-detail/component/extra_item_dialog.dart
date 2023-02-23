import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ideas_desktop_getx/theme/theme.dart';
import '../../../locale_keys_enum.dart';
import '../../../locale_manager.dart';
import '../../../model/printer_model.dart';
import '../../_utility/screen_keyboard/screen_keyboard_view.dart';
import 'edit_item_actions_dialog.dart';

class ExtraItemDialog extends StatefulWidget {
  final List<PrinterOutput> printers;
  const ExtraItemDialog(this.printers, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExtraItemDialogState createState() => _ExtraItemDialogState();
}

class _ExtraItemDialogState extends State<ExtraItemDialog> {
  final TextEditingController nameCtrl = TextEditingController();

  final TextEditingController quantityCtrl = TextEditingController();

  final TextEditingController priceCtrl = TextEditingController();
  int selectedPrinter = -1;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        Container(
            color: ideasTheme.primaryColor,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Ekstra Ürün',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: nameCtrl,
                onTap: () async {
                  if (LocaleManager.instance
                      .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                    var res = await showDialog(
                      context: context,
                      builder: (context) => const ScreenKeyboard(),
                    );
                    if (res != null) {
                      nameCtrl.text = res;
                    }
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Ürün Adı',
                  isDense: true,
                ),
                style: const TextStyle(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: quantityCtrl,
                onTap: () async {
                  if (LocaleManager.instance
                      .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                    await showDialog(
                      context: context,
                      builder: (context) => QuantityDialog(
                        updateAction: (quantity) {
                          quantityCtrl.text = quantity;
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\,?\d{0,4}'))
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Adet',
                  isDense: true,
                ),
                style: const TextStyle(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: priceCtrl,
                onTap: () async {
                  if (LocaleManager.instance
                      .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                    await showDialog(
                      context: context,
                      builder: (context) => QuantityDialog(
                        updateAction: (quantity) {
                          priceCtrl.text = quantity;
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }
                },
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\,?\d{0,4}'))
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Birim Fiyatı',
                  isDense: true,
                ),
                style: const TextStyle(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Row(
            children: [
              const Text(
                'Yazıcı: ',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Expanded(
                child: DropdownButton(
                  icon: const Expanded(
                    child: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  items: getCancelButtons(),
                  value: selectedPrinter,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (dynamic newGroup) {
                    setState(() {
                      selectedPrinter = newGroup;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, [
                      nameCtrl.text,
                      priceCtrl.text,
                      quantityCtrl.text,
                      selectedPrinter
                    ]);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 8)),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffF1A159)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ))),
                  child: const Text(
                    'Kaydet',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 8)),
                      backgroundColor: MaterialStateProperty.all(Colors.red),
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
    );
  }

  List<DropdownMenuItem> getCancelButtons() {
    List<DropdownMenuItem> items = [];
    items.add(const DropdownMenuItem(
      value: -1,
      child: Text(
        'Seçmeden devam et',
      ),
    ));
    for (var item in widget.printers) {
      items.add(DropdownMenuItem(
        value: item.printerId,
        child: Text(
          item.printerName!,
        ),
      ));
    }
    return items;
  }
}

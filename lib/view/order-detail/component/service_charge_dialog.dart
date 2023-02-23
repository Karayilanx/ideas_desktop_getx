import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ideas_desktop_getx/locale_keys_enum.dart';
import 'package:ideas_desktop_getx/theme/theme.dart';
import '../../../locale_manager.dart';
import 'edit_item_actions_dialog.dart';

class ServiceChargeDialog extends StatelessWidget {
  const ServiceChargeDialog();

  @override
  Widget build(BuildContext context) {
    final TextEditingController discountCtrl = TextEditingController();

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        Container(
            color: ideasTheme.primaryColor,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Servis Ücreti',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: discountCtrl,
                onTap: () async {
                  if (LocaleManager.instance
                      .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                    await showDialog(
                      context: context,
                      builder: (context) => QuantityDialog(
                        updateAction: (quantity) {
                          discountCtrl.text = quantity;
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
                  prefix: const Text('₺'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  hintText: 'Tutar Giriniz',
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
              const SizedBox(height: 10)
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, discountCtrl.text);
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
}

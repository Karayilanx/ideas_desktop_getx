import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_utility/keyboard/button_type_enum.dart';
import '../../_utility/keyboard/numeric_keyboard.dart';
import '../../_utility/service_helper.dart';

class CustomerCountDialog extends StatelessWidget with ServiceHelper {
  final bool canClose;
  CustomerCountDialog({super.key, required this.canClose});

  @override
  Widget build(BuildContext context) {
    TextEditingController countCtrl = TextEditingController();
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: context.height * 70 / 100,
          width: context.width * 25 / 100,
          child: Column(
            children: [
              Container(
                color: context.theme.primaryColor,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Kişi Sayısı',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextFormField(
                  controller: countCtrl,
                  enabled: false,
                  style: const TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: NumericKeyboard(
                    buttonColor: Colors.white54,
                    pinFieldController: countCtrl,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    type: KeyboardType.DOUBLE,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (countCtrl.text != '' &&
                              countCtrl.text != '0' &&
                              int.tryParse(countCtrl.text) != null) {
                            Navigator.of(context).pop(countCtrl.text);
                          } else {
                            showSnackbarError('Lütfen tam sayı giriniz.');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            backgroundColor: const Color(0xffF1A159),
                            padding: const EdgeInsets.symmetric(vertical: 8)),
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
                          if (canClose) {
                            Navigator.of(context).pop(null);
                          } else {
                            Navigator.of(context).pop(false);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 8)),
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
        )
      ],
    );
  }
}

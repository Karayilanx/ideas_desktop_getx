import 'package:flutter/material.dart';
import 'package:ideas_desktop_getx/extension/context_extension.dart';
import '../../_utility/keyboard/button_type_enum.dart';
import '../../_utility/keyboard/numeric_keyboard.dart';

class PortionQuantityDialog extends StatelessWidget {
  const PortionQuantityDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController quantityController =
        TextEditingController(text: '');
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: context.height * 70 / 100,
          width: context.width * 25 / 100,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextFormField(
                  controller: quantityController,
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
                child: NumericKeyboard(
                  buttonColor: Colors.white54,
                  pinFieldController: quantityController,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  type: KeyboardType.DOUBLE,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, quantityController.text);
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
                          Navigator.pop(context, null);
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/theme.dart';

class ScreenKeyboard extends StatelessWidget {
  const ScreenKeyboard({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController ctrl = TextEditingController();
    return Dialog(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: context.width * 95 / 100,
        height: context.height * 33 / 100,
        child: Row(
          children: [
            Expanded(
              flex: 90,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: TextFormField(
                      controller: ctrl,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        isDense: true,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 75,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 80,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      LetterButton('Q', ctrl),
                                      LetterButton('W', ctrl),
                                      LetterButton('E', ctrl),
                                      LetterButton('R', ctrl),
                                      LetterButton('T', ctrl),
                                      LetterButton('Y', ctrl),
                                      LetterButton('U', ctrl),
                                      LetterButton('I', ctrl),
                                      LetterButton('O', ctrl),
                                      LetterButton('P', ctrl),
                                      LetterButton('Ğ', ctrl),
                                      LetterButton('Ü', ctrl),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      LetterButton('A', ctrl),
                                      LetterButton('S', ctrl),
                                      LetterButton('D', ctrl),
                                      LetterButton('F', ctrl),
                                      LetterButton('G', ctrl),
                                      LetterButton('H', ctrl),
                                      LetterButton('J', ctrl),
                                      LetterButton('K', ctrl),
                                      LetterButton('L', ctrl),
                                      LetterButton('Ş', ctrl),
                                      LetterButton('İ', ctrl),
                                      ActionButton(
                                          text: '<<',
                                          onPressed: () {
                                            if (ctrl.text.isNotEmpty) {
                                              ctrl.text = ctrl.text.substring(
                                                  0, ctrl.text.length - 1);
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      LetterButton('Z', ctrl),
                                      LetterButton('X', ctrl),
                                      LetterButton('C', ctrl),
                                      LetterButton('V', ctrl),
                                      LetterButton('B', ctrl),
                                      LetterButton('N', ctrl),
                                      LetterButton('M', ctrl),
                                      LetterButton('Ö', ctrl),
                                      LetterButton('Ç', ctrl),
                                      ActionButton(
                                        text: 'BOŞLUK',
                                        onPressed: () {
                                          ctrl.text += " ";
                                        },
                                        flex: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 20,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        LetterButton('7', ctrl),
                                        LetterButton('8', ctrl),
                                        LetterButton('9', ctrl),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        LetterButton('4', ctrl),
                                        LetterButton('5', ctrl),
                                        LetterButton('6', ctrl),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        LetterButton('1', ctrl),
                                        LetterButton('2', ctrl),
                                        LetterButton('3', ctrl),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        LetterButton(',', ctrl),
                                        LetterButton('0', ctrl),
                                        ActionButton(
                                          text: 'C',
                                          onPressed: () {
                                            ctrl.clear();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      )),
                ],
              ),
            ),
            SizedBox(
              width: 80,
              child: Column(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context, ctrl.text);
                      },
                      color: Colors.green,
                      icon: const Icon(
                        Icons.check,
                        size: 30,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.red,
                      icon: const Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LetterButton extends StatelessWidget {
  final String text;
  final TextEditingController ctrl;
  const LetterButton(this.text, this.ctrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ideasTheme.scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
        onPressed: () {
          ctrl.text += text;
        },
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final int flex;
  final VoidCallback onPressed;
  const ActionButton(
      {super.key, required this.text, required this.onPressed, this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ideasTheme.scaffoldBackgroundColor,
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ))),
              onPressed: () => onPressed(),
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ));
  }
}

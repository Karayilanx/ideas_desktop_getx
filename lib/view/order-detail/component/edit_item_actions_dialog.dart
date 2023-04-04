import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ideas_desktop/extension/context_extension.dart';

import '../../../model/check_model.dart';
import '../../../model/menu_model.dart';
import '../../_utility/keyboard/button_type_enum.dart';
import '../../_utility/keyboard/numeric_keyboard.dart';
import 'edit_action_button.dart';

class EditItemActionsDialog extends StatelessWidget {
  final GroupedCheckItem? item;
  final VoidCallback? deleteAction;
  final VoidCallback? giftAction;
  final VoidCallback? updateQuantityAction;
  final VoidCallback? stopSendAction;
  final VoidCallback? noteAction;
  final VoidCallback? addAction;
  final VoidCallback? changePriceAction;
  final bool isCheckItem;
  const EditItemActionsDialog({
    super.key,
    this.item,
    this.deleteAction,
    this.stopSendAction,
    required this.isCheckItem,
    this.updateQuantityAction,
    this.noteAction,
    this.giftAction,
    this.addAction,
    this.changePriceAction,
  });
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          width: context.width * 30 / 100,
          child: Column(
            children: [
              buildItemNameText(item!, context),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 4),
                    isCheckItem
                        ? EditActionButton(
                            callback: () => addAction!(),
                            text: 'EKLE',
                          )
                        : Container(),
                    EditActionButton(
                      callback: () => deleteAction!(),
                      text: 'İPTAL',
                    ),
                    isCheckItem
                        ? EditActionButton(
                            callback: () => changePriceAction!(),
                            text: 'FİYAT DEĞİŞTİR',
                          )
                        : Container(),
                    isCheckItem
                        ? EditActionButton(
                            callback: () => giftAction!(),
                            text: 'İKRAM',
                          )
                        : Container(),
                    item!.originalItem!.isStopped == true || !isCheckItem
                        ? EditActionButton(
                            callback: () => stopSendAction!(),
                            text: isCheckItem
                                ? 'MARŞLA'
                                : item!.originalItem!.isStopped == null ||
                                        item!.originalItem!.isStopped == false
                                    ? 'BEKLET'
                                    : 'BEKLETMEYİ KALDIR',
                          )
                        : Container(),
                    !isCheckItem
                        ? EditActionButton(
                            callback: () => updateQuantityAction!(),
                            text: 'ADET DEĞİŞTİR',
                          )
                        : Container(),
                    !isCheckItem
                        ? EditActionButton(
                            callback: () => noteAction!(),
                            text: 'NOT',
                          )
                        : Container(),
                    EditActionButton(
                      callback: () {
                        Navigator.pop(context, null);
                      },
                      text: 'VAZGEÇ',
                      color: Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

Container buildItemNameText(GroupedCheckItem item, BuildContext context) {
  return Container(
    color: context.theme.primaryColor,
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AutoSizeText(
            'Ürün\n${item.itemCount!} - ${item.originalItem!.getName}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
          ),
        ),
        Expanded(
          child: AutoSizeText('Fiyat\n${item.totalPrice.toStringAsFixed(2)} TL',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24)),
        )
      ],
    ),
  );
}

// class NoteDialog extends StatelessWidget {
//   final TextEditingController? noteController;
//   final GroupedCheckItem? item;
//   final Function(String note)? updateAction;

//   const NoteDialog({this.noteController, this.item, this.updateAction});

//   @override
//   Widget build(BuildContext context) {
//     return SimpleDialog(
//       contentPadding: EdgeInsets.zero,
//       children: [
//         Container(
//           constraints: BoxConstraints(minHeight: 600),
//           width: 300,
//           child: Column(
//             children: [
//               buildItemNameText(item!, context),
//               SizedBox(height: 10),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8),
//                 child: TextFormField(
//                   controller: noteController,
//                   onTap: () async {
//                     if (LocaleManager.instance
//                         .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
//                       var res = await showDialog(
//                         context: context,
//                         builder: (context) => ScreenKeyboard(),
//                       );
//                       if (res != null) {
//                         noteController!.text = res;
//                       }
//                     }
//                   },
//                   style: TextStyle(fontSize: 22),
//                   maxLines: 3,
//                   decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15.0),
//                         borderSide: BorderSide(
//                           color: Colors.black,
//                         ),
//                       ),
//                       filled: true,
//                       hintText: 'Bu alana notalarınızı girebilirsiniz',
//                       fillColor: Colors.white),
//                 ),
//               ),
//               SizedBox(height: 30),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8),
//                 height: 60,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           updateAction!(noteController!.text);
//                         },
//                         style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(color: Colors.black),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10),
//                               ),
//                             ),
//                             backgroundColor: Color(0xffF1A159),
//                             padding: EdgeInsets.symmetric(vertical: 8)),
//                         child: Text(
//                           'Kaydet',
//                           style: TextStyle(
//                             fontSize: 24,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context, null);
//                         },
//                         style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               side: BorderSide(color: Colors.black),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(10),
//                               ),
//                             ),
//                             backgroundColor: Colors.red,
//                             padding: EdgeInsets.symmetric(vertical: 8)),
//                         child: Text(
//                           'Vazgeç',
//                           style: TextStyle(
//                             fontSize: 24,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

class QuantityDialog extends StatelessWidget {
  final GroupedCheckItem? item;
  final TextEditingController quantityController =
      TextEditingController(text: '');
  final Function(String quantity)? updateAction;
  QuantityDialog({super.key, this.item, this.updateAction});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: context.height * 70 / 100,
          width: context.width * 25 / 100,
          child: Column(
            children: [
              item != null ? buildItemNameText(item!, context) : Container(),
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
                    borderRadius: BorderRadius.circular(30.0),
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
                          if (quantityController.text != '') {
                            updateAction!(quantityController.text);
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
                          'Tamam',
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

class GramDialog extends StatelessWidget {
  final MenuItem? item;
  final TextEditingController quantityController =
      TextEditingController(text: '');
  final Function(String quantity)? updateAction;
  GramDialog({super.key, this.item, this.updateAction});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: context.height * 70 / 100,
          width: context.width * 25 / 100,
          child: Column(
            children: [
              buildGramItemNameText(item!, context),
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
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  type: KeyboardType.DOUBLE,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          updateAction!(quantityController.text);
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

Container buildGramItemNameText(MenuItem item, BuildContext context) {
  return Container(
    color: context.theme.primaryColor,
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Ürün\n${item.nameTr!}',
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
        ),
        Text('Birim Fiyatı\n${item.price.toStringAsFixed(2)} TL',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24))
      ],
    ),
  );
}

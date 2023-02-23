import 'package:flutter/material.dart';
import '../../../locale_keys_enum.dart';
import '../../../locale_manager.dart';
import '../../../theme/theme.dart';
import '../../_utility/screen_keyboard/screen_keyboard_view.dart';

class InputDialog extends StatelessWidget {
  final TextEditingController ctrl = TextEditingController();
  final String? titleText;
  final String? hintText;
  final TextInputType? inputType;

  InputDialog({super.key, this.titleText, this.hintText, this.inputType});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: const Color(0xffEDEAE6),
      title: Text(titleText!),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextField(
                controller: ctrl,
                onTap: () async {
                  if (LocaleManager.instance
                      .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                    var res = await showDialog(
                      context: context,
                      builder: (context) => const ScreenKeyboard(),
                    );
                    if (res != null) {
                      ctrl.text = res;
                    }
                  }
                },
                keyboardType: inputType,
                decoration: InputDecoration(
                    hintText: hintText, border: const OutlineInputBorder()),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, ctrl.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ideasTheme.scaffoldBackgroundColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Kaydet',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 25),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Vazgeç',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

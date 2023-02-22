import 'package:flutter/material.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'button_type_enum.dart';

class KeyboardActionButton extends StatelessWidget {
  final KeyboardButtonType type;
  final TextEditingController? ctrl;
  final Color buttonColor;
  final OutlinedBorder shape;
  final VoidCallback? clearCallback;
  final TextStyle? style;
  const KeyboardActionButton({
    super.key,
    required this.type,
    required this.ctrl,
    required this.buttonColor,
    required this.shape,
    this.clearCallback,
    this.style = const TextStyle(fontSize: 28),
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor, shape: shape),
          onPressed: () {
            if (type == KeyboardButtonType.CLEAR) {
              if (clearCallback != null) clearCallback!();
              ctrl!.clear();
            } else if (type == KeyboardButtonType.DELETE) {
              try {
                ctrl!.text = ctrl!.text.substring(0, ctrl!.text.length - 1);
                // ignore: empty_catches
              } catch (e) {}
            } else if (type == KeyboardButtonType.COMMA) {
              String a = '${ctrl!.text},0';
              if (a.isDouble) {
                ctrl!.text += ',';
              }
            }
          },
          child: buildIcon(),
        ),
      ),
    );
  }

  buildIcon() {
    if (type == KeyboardButtonType.CLEAR) {
      return Text('C', style: style);
    } else if (type == KeyboardButtonType.DELETE) {
      return const Icon(Icons.backspace);
    } else if (type == KeyboardButtonType.COMMA) {
      return Text(',', style: style);
    }
  }
}

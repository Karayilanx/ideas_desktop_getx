import 'package:flutter/material.dart';
import 'button_type_enum.dart';
import 'keyboard_action_button.dart';
import 'keyboard_numeric_button.dart';

class NumericKeyboard extends StatelessWidget {
  const NumericKeyboard({
    Key? key,
    required this.type,
    this.actionColumn,
    required this.pinFieldController,
    this.callBackLength,
    this.callback,
    required this.buttonColor,
    required this.shape,
    this.clearCallback,
    this.style,
  }) : super(key: key);

  final KeyboardType type;
  final Widget? actionColumn;
  final TextEditingController? pinFieldController;
  final int? callBackLength;
  final VoidCallback? callback;
  final Color buttonColor;
  final OutlinedBorder shape;
  final VoidCallback? clearCallback;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 1,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 4,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 7,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
              KeyboardActionButton(
                ctrl: pinFieldController,
                type: type == KeyboardType.INT
                    ? KeyboardButtonType.DELETE
                    : KeyboardButtonType.COMMA,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 2,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 5,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 8,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 0,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 3,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 6,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
              KeyboardNumericButton(
                ctrl: pinFieldController,
                number: 9,
                callBackLength: callBackLength,
                callback: callback,
                buttonColor: buttonColor,
                shape: shape,
                style: style,
              ),
              KeyboardActionButton(
                ctrl: pinFieldController,
                type: KeyboardButtonType.CLEAR,
                buttonColor: buttonColor,
                style: style,
                shape: shape,
                clearCallback: () =>
                    clearCallback != null ? clearCallback!() : null,
              )
            ],
          ),
        ),
        actionColumn != null ? Expanded(child: actionColumn!) : Container()
      ],
    );
  }
}

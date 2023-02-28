import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';

const defaultColor = Color(0xFFF8F8FF);

class EndOfDayReportInformation extends StatelessWidget {
  final String leftText;
  final double rightText;
  final bool isSubInfo;
  const EndOfDayReportInformation(
      {required this.leftText,
      required this.rightText,
      this.isSubInfo = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            isSubInfo ? '     $leftText' : '  $leftText',
            style: TextStyle(
                fontSize: 16,
                fontStyle: isSubInfo ? FontStyle.italic : FontStyle.normal),
          ),
        ),
        Text(
          rightText.getPriceString,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class EndOfDayReportHeader extends StatelessWidget {
  final String header;
  const EndOfDayReportHeader({Key? key, required this.header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class EndOfDayReportColumn extends StatelessWidget {
  final Widget child;
  const EndOfDayReportColumn(this.child);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 2),
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: child,
      ),
    );
  }
}

const Color defaultTabColor = Colors.blueGrey;

class EndOfDayTabButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool selected;
  final Color color;
  const EndOfDayTabButton(
      {required this.callback,
      required this.text,
      this.selected = false,
      this.color = defaultTabColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selected ? defaultTabColor : Colors.grey[300],
        ),
        onPressed: () => callback(),
        child: AutoSizeText(
          text,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class EndOfDayLeftSideButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final Color color;
  const EndOfDayLeftSideButton({
    required this.callback,
    required this.text,
    this.color = defaultColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14),
        child: ElevatedButton(
          onPressed: () => callback(),
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: Text(text),
        ),
      ),
    );
  }
}

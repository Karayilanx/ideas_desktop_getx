import 'package:flutter/material.dart';
import 'package:ideas_desktop/model/branch_model.dart';

class MsgDialog extends StatelessWidget {
  final ServerChangeMsgModel msg;

  const MsgDialog({
    super.key,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(msg.header!),
          const Divider(),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildIcon(),
          Text(msg.message!),
        ],
      ),
      actions: buildActions(context),
    );
  }

  Widget buildIcon() {
    if (msg.msgTypeId == 0) {
      return Column(
        children: [
          Row(
            children: const [
              Icon(
                Icons.info,
                color: Colors.blue,
                size: 30,
              ),
              Text(
                'Bilgilendirme',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.blue)
        ],
      );
    } else if (msg.msgTypeId == 1) {
      return Column(
        children: [
          Row(
            children: const [
              Icon(
                Icons.warning,
                color: Colors.orange,
                size: 30,
              ),
              Text(
                'Uyarı',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.orange)
        ],
      );
    } else if (msg.msgTypeId == 2) {
      return Column(
        children: [
          Row(
            children: const [
              Icon(
                Icons.error,
                color: Colors.red,
                size: 30,
              ),
              Text(
                'Önemli Uyarı',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.red)
        ],
      );
    }

    return const Icon(Icons.abc);
  }

  List<Widget> buildActions(BuildContext context) {
    if (msg.msgTypeId != 2) {
      return [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tamam'))
      ];
    } else {
      return [];
    }
  }
}

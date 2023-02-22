import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../model/table_model.dart';

class ClosedTableWidget extends StatelessWidget {
  final TableWithDetails table;
  final VoidCallback callback;
  const ClosedTableWidget(
      {super.key, required this.table, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFC0C0C0)),
        child: Center(
          child: AutoSizeText(
            table.name!,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class OpenTableWidget extends StatelessWidget {
  final TableWithDetails table;
  final VoidCallback? callback;
  const OpenTableWidget({
    super.key,
    required this.table,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback!(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFE04747)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 0, 0),
                child: AutoSizeText(
                  table.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: AutoSizeText(
                  table.terminalUserName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 4),
                        child: Icon(
                          Icons.timer_sharp,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${table.minute!}'",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 4),
                    child: AutoSizeText(
                      '${table.amount!.toStringAsFixed(2)} TL',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckSendTableWidget extends StatelessWidget {
  final TableWithDetails table;
  final VoidCallback? callback;
  const CheckSendTableWidget({
    super.key,
    required this.table,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback!(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF32454C)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 6, 0, 0),
                    child: Text(
                      table.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 6, 16, 0),
                    child: Icon(
                      Icons.print,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 0, 2),
                child: AutoSizeText(
                  table.terminalUserName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 0, 4),
                        child: Icon(
                          Icons.timer_sharp,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${table.minute!}'",
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.white),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 4),
                    child: AutoSizeText(
                      '${table.amount!.toStringAsFixed(2)} TL',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

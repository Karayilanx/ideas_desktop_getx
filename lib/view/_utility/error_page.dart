import 'package:flutter/material.dart';

class MainErrorPage extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const MainErrorPage({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Error!\n${errorDetails.exception}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

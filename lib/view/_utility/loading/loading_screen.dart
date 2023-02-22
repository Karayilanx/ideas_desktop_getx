import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../image/image_constatns.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageConstants.instance.ideaslogo),
          const SizedBox(height: 20),
          const SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          ),
          const SizedBox(height: 8),
          const Text(
            'Yükleniyor...',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

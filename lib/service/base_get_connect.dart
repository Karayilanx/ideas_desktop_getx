import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../locale_keys_enum.dart';
import '../locale_manager.dart';

class BaseGetConnect extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl =
        'http://${LocaleManager.instance.getStringValue(PreferencesKeys.IP_ADDRESS)}/api/';

    // It's will attach 'apikey' property on header from all requests
    // httpClient.addRequestModifier((request) {
    //   request.headers['apikey'] = '12345678';
    //   return request;
    // });

    // httpClient.addResponseModifier((request, response) {
    //   print("response.statusText");
    //   if (response.statusCode == 400) {
    //     print("response.statusText");
    //   }
    // });

    // httpClient.addAuthenticator((request) async {
    //   final response = await get("http://yourapi/token");
    //   final token = response.body['token'];
    //   // Set the header
    //   request.headers['Authorization'] = "$token";
    //   return request;
    // });
  }

  handleError(Response? response) {
    if (response != null && response.statusCode != 200) {
      Get.defaultDialog(
          title: "Bilgi",
          titleStyle: const TextStyle(color: Colors.black),
          cancel: ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Tamam',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              )),
          radius: 5,
          content: Text(
            response.body ?? response.statusText,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ));
    }
  }
}

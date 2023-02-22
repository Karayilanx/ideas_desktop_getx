import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/locale_manager.dart';
import 'package:ideas_desktop_getx/view/_utility/service_helper.dart';
import 'package:ideas_desktop_getx/view/authentication/auth_store.dart';

class BaseController extends GetxController with ServiceHelper {
  AuthStore authStore = Get.find();
  LocaleManager localeManager = LocaleManager.instance;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await checkSignalR();
    });
  }
}

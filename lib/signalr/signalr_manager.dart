import 'dart:async';

import 'package:signalr_core/signalr_core.dart';

import '../locale_keys_enum.dart';
import '../locale_manager.dart';

class SignalRManager {
  static SignalRManager? _instance;
  static LocaleManager localeManager = LocaleManager.instance;
  HubConnection hubConnection = HubConnectionBuilder()
      .withUrl(
          "http://${localeManager.getStringValue(PreferencesKeys.IP_ADDRESS)}/tablehub")
      .build();
  HubConnection serverHubConnection = HubConnectionBuilder()
      .withUrl(
          "http://${localeManager.getStringValue(PreferencesKeys.SERVER_IP_ADDRESS)}/tablehub")
      .build();
  static void reset() {
    _instance = null;
  }

  static SignalRManager? get instance {
    _instance ??= SignalRManager._init();
    return _instance;
  }

  SignalRManager._init() {
    hubConnection.onclose((_) => reconnectTimer());
    serverHubConnection.onclose((_) {
      reconnectServerTimer();
    });
  }

  static Future hubConnectionStart() async {
    await instance!.hubConnection.start()!.timeout(const Duration(seconds: 5));
    await instance!.serverHubConnection
        .start()!
        .timeout(const Duration(seconds: 5));
  }

  void reconnectTimer() async {
    bool isConnected = false;
    while (!isConnected) {
      // ignore: avoid_print
      print('WHİLE LOOP BAŞLADI');
      await Future.delayed(const Duration(seconds: 2));
      try {
        await hubConnection.start();
      } on Exception catch (_) {}
      await Future.delayed(const Duration(seconds: 2));
      if (hubConnection.state == HubConnectionState.connected) {
        isConnected = true;
      }
    }
  }

  void reconnectServerTimer() async {
    bool isConnected = false;
    while (!isConnected) {
      // ignore: avoid_print
      print('WHİLE LOOP BAŞLADI');
      await Future.delayed(const Duration(seconds: 2));
      try {
        await serverHubConnection.start();
      } on Exception catch (_) {}
      await Future.delayed(const Duration(seconds: 2));
      if (serverHubConnection.state == HubConnectionState.connected) {
        isConnected = true;
      }
    }
  }
}

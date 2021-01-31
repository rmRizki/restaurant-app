import 'dart:isolate';
import 'dart:ui';

import 'package:restaurant_app/core/network/network_service.dart';
import 'package:restaurant_app/core/providers/providers.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static void callback() async {
    try {
      final NotificationHelper _notificationHelper = NotificationHelper();
      var result =
          await RestaurantProvider(NetworkService()).getRestaurantList();
      await _notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, result);
      print('notification showed');
      _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
      _uiSendPort?.send(null);
    } catch (e) {
      print('error callback: $e');
    }
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}

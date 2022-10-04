import 'dart:isolate';
import 'dart:ui';

import 'package:http/http.dart'as http;
import '../../data/services/api_service.dart';
import '../../helpers/notification_helper.dart';
import '../../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _backgroundService;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _backgroundService = this;
  }

  factory BackgroundService() =>
      _backgroundService ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().getRestaurantList(http.Client());
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}

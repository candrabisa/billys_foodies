import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../common/navigation.dart';
import '../../common/strings.dart';
import '../../data/models/restaurant_result_model.dart';
import '../../ui/pages/base_page.dart';
import '../../ui/pages/restaurant_detail_page.dart';

class NotificationHelper {
  static NotificationHelper? _notificationHelper;

  NotificationHelper._internal() {
    _notificationHelper = this;
  }

  factory NotificationHelper() =>
      _notificationHelper ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    var data = RestaurantElement.fromJson(jsonDecode(payload!));

    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      await Navigation.intentWithData(
        MaterialPageRoute(
          builder: (_) => RestaurantDetailPage(restaurantElement: data),
        ),
      );
    } else {
      MaterialPageRoute(builder: (_) => const BasePage());
    }
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResultModel resultModel) async {
    var random = Random().nextInt(resultModel.restaurants.length);

    var smallPicturePath = await _downloadAndSaveFile(
        urlImageSmall + resultModel.restaurants[random].pictureId,
        'restaurantPics');
    var largePicturePath = await _downloadAndSaveFile(
        urlImageLarge + resultModel.restaurants[random].pictureId,
        'restaurantPics');

    var channelId = '1';
    var channelName = 'channel_01';
    var channelDescription = 'billy foodies';

    var androidPlatformSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: BigPictureStyleInformation(
        FilePathAndroidBitmap(largePicturePath),
        largeIcon: FilePathAndroidBitmap(smallPicturePath),
        htmlFormatContentTitle: true,
        htmlFormatSummaryText: true,
      ),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformSpecifics,
    );

    var titleNotification = resultModel.restaurants[random].name;
    var bodyNotification = 'Recommendation restaurant for you';

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      bodyNotification,
      platformChannelSpecifics,
      payload: jsonEncode(resultModel.restaurants[random].toJson()),
    );
  }
}

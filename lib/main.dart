import 'dart:io';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/navigation.dart';
import 'data/services/api_service.dart';
import 'data/services/background_service.dart';
import 'helpers/database_helper.dart';
import 'helpers/notification_helper.dart';
import 'helpers/preferences_helper.dart';
import 'providers/favorite_provider.dart';
import 'providers/preferences_provider.dart';
import 'providers/scheduling_provider.dart';
import 'providers/restaurant_list_provider.dart';
import 'providers/restaurant_review_provider.dart';
import 'providers/restaurant_search_provider.dart';
import 'ui/pages/base_page.dart';
import 'ui/pages/search_page.dart';
import 'ui/pages/splash_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantListProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantReviewProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantSearchProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SchedulingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Billys Foodies',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          BasePage.routeName: (context) => const BasePage(),
          SearchPage.routeName: (context) => const SearchPage(),
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../helpers/notification_helper.dart';
import '../../ui/pages/base_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final NotificationHelper notificationHelper = NotificationHelper();

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, BasePage.routeName, (route) => false);
    });
    notificationHelper.onDidReceiveNotificationResponse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/anims/foodies.json',
          width: MediaQuery.of(context).size.width * .6,
          repeat: true,
        ),
      ),
    );
  }
}

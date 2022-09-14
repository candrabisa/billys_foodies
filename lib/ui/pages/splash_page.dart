import 'dart:async';

import 'package:billys_foodies/providers/restaurant_provider.dart';
import 'package:billys_foodies/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 5),
      () => Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (route) => false,
      ),
    );
    getRestaurantList();
    super.initState();
  }

  getRestaurantList() async {
    await Provider.of<RestaurantProvider>(context, listen: false)
        .getRestaurant(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/json/foodies.json',
          width: MediaQuery.of(context).size.width * .6,
          repeat: false,
        ),
      ),
    );
  }
}

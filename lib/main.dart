import 'package:billys_foodies/providers/restaurant_provider.dart';
import 'package:billys_foodies/ui/pages/home_page.dart';
import 'package:billys_foodies/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
        ),
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}

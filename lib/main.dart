import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:billys_foodies/data/services/api_service.dart';
import 'package:billys_foodies/providers/restaurant_list_provider.dart';
import 'package:billys_foodies/providers/restaurant_review_provider.dart';
import 'package:billys_foodies/providers/restaurant_search_provider.dart';
import 'package:billys_foodies/ui/pages/search_page.dart';

import 'ui/pages/home_page.dart';
import 'ui/pages/splash_page.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Billys Foodies',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => const SplashPage(),
          HomePage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
        },
      ),
    );
  }
}

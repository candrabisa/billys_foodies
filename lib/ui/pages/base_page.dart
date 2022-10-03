import 'package:flutter/material.dart';

import '../../common/style.dart';
import '../../helpers/notification_helper.dart';
import '../../ui/pages/favorite_page.dart';
import '../../ui/pages/home_page.dart';
import '../../ui/pages/search_page.dart';
import '../../ui/pages/settings_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  static const routeName = '/base-page';

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late List pages;
  int selectedIndex = 0;

  final NotificationHelper notificationHelper = NotificationHelper();

  @override
  void initState() {
    pages = const [
      HomePage(),
      FavoritePage(),
      SettingPage(),
    ];
    notificationHelper.onDidReceiveNotificationResponse;
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foodies'),
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
            icon: Icon(
              Icons.search,
              color: kWhiteColor,
            ),
          ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_outlined, size: 18),
            activeIcon: Icon(Icons.restaurant_sharp, size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined, size: 18),
            activeIcon: Icon(Icons.favorite_sharp, size: 24),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, size: 18),
            activeIcon: Icon(Icons.settings_sharp, size: 24),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _selectedPage,
      ),
    );
  }
}

import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(MaterialPageRoute pageRoute) {
    navigatorKey.currentState?.push(pageRoute);
  }
  static back() => navigatorKey.currentState?.pop();
}
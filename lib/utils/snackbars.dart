import 'package:flutter/material.dart';

import '../common/style.dart';

snackBarNoIcon(dynamic context, Color color, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        style: kWhiteTextStyle.copyWith(fontSize: 15.0),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

snackBarWithIcon(dynamic context, String text, Icon icon) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kRedColor,
      content: Row(
        children: [
          icon,
          const SizedBox(width: 5),
          Text(
            text,
            style: kWhiteTextStyle.copyWith(fontSize: 15.0),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

snackBarWithAction(
    dynamic context, String text, String label, Function() onPressed) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kRedColor,
      content: Text(
        text,
        style: kWhiteTextStyle.copyWith(fontSize: 15.0),
      ),
      action: SnackBarAction(
        label: label,
        onPressed: onPressed,
      ),
    ),
  );
}

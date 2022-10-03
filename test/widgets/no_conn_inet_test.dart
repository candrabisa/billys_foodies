import 'package:billys_foodies/ui/widgets/no_conn_inet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test No Connection Internet Widgets', (tester) async {
    const text = 'No Connection Internet';
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(body: NoConnectionInternetWidget(msgError: text))));
    final textFinder = find.text(text);

    expect(textFinder, findsOneWidget);
  });
}

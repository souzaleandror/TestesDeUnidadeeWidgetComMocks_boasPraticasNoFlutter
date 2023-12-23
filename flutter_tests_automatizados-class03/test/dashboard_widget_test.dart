import 'package:bytebank/main.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {
    final mockContactDado = MockContactDao();
    await tester.pumpWidget(
      MaterialApp(
        home: BytebankApp(
          contactDao: mockContactDado,
        ),
      ),
    );
    final mainImage = find.byType(Image);
    expect(mainImage, findsOne);
  });

  testWidgets('Should display the first feature when the Dashboard is opened',
      (tester) async {
    final mockContactDado = MockContactDao();
    await tester.pumpWidget(
      MaterialApp(
        home: BytebankApp(
          contactDao: mockContactDado,
        ),
      ),
    );
    final firstFeature = find.byType(FeatureItem);
    expect(firstFeature, findsWidgets);
  });

  testWidgets('Should display the first transfer when the Dashboard is opened',
      (tester) async {
    final mockContactDado = MockContactDao();
    await tester.pumpWidget(MaterialApp(
        home: BytebankApp(
      contactDao: mockContactDado,
    )));
    // final iconTranfererFeatureItem =
    //     find.widgetWithIcon(FeatureItem, Icons.monetization_on);
    // expect(iconTranfererFeatureItem, findsOneWidget);
    // final nameTransferFeatureItem =
    //     find.widgetWithText(FeatureItem, 'Transfer');
    // expect(nameTransferFeatureItem, findsOneWidget);
    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
  });

  testWidgets(
      'Should display the transaction feed when the Dashboard is opened',
      (tester) async {
    final mockContactDado = MockContactDao();
    await tester.pumpWidget(MaterialApp(
        home: BytebankApp(
      contactDao: mockContactDado,
    )));
    // final iconTranfererFeedItem =
    //     find.widgetWithIcon(FeatureItem, Icons.description);
    // expect(iconTranfererFeedItem, findsOneWidget);
    // final nameTransferFeedFeatureItem =
    //     find.widgetWithText(FeatureItem, 'Transaction Feed');
    // expect(nameTransferFeedFeatureItem, findsOneWidget);
    final nameTransferFeedFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transaction Feed', Icons.description));
    expect(nameTransferFeedFeatureItem, findsOneWidget);
  });
}

import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';

@GenerateMocks([ContactDao])
@GenerateMocks([TransactionWebClient])
void main() {
  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {
    final mockContactDado = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(
      MaterialApp(
        home: BytebankApp(
          contactDao: mockContactDado,
          transactionWebClient: mockTransactionWebClient,
        ),
      ),
    );
    final mainImage = find.byType(Image);
    expect(mainImage, findsOne);
  });

  testWidgets('Should display the first feature when the Dashboard is opened',
      (tester) async {
    final mockContactDado = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(
      MaterialApp(
        home: BytebankApp(
          contactDao: mockContactDado,
          transactionWebClient: mockTransactionWebClient,
        ),
      ),
    );
    final firstFeature = find.byType(FeatureItem);
    expect(firstFeature, findsWidgets);
  });

  testWidgets('Should display the first transfer when the Dashboard is opened',
      (tester) async {
    final mockContactDado = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(MaterialApp(
        home: BytebankApp(
      contactDao: mockContactDado,
      transactionWebClient: mockTransactionWebClient,
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
    final mockTransactionWebClient = MockTransactionWebClient();
    await tester.pumpWidget(MaterialApp(
        home: BytebankApp(
      contactDao: mockContactDado,
      transactionWebClient: mockTransactionWebClient,
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

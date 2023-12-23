import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'matchers.dart';
import 'save_contact_flow_test.mocks.dart';

@GenerateMocks([ContactDao])
void main() {
  testWidgets('Should save a contact', (tester) async {
    final mockContactDao = MockContactDao();
    when(mockContactDao.findAll()).thenAnswer((_) async => []);
    when(mockContactDao.save(any)).thenAnswer((_) async => 1);
    await tester.pumpWidget(
      BytebankApp(
        contactDao: mockContactDao,
      ),
    );

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
        featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
    await tester.tap(transferFeatureItem);
    //await tester.pumpAndSettle();
    for (int i = 0; i < 5; i++) {
      await tester.pump(Duration(seconds: 1));
    }

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final nameTextField = find.byWidgetPredicate((widget) {
      if (widget is TextField) {
        return widget.decoration?.labelText == 'Full name';
      }
      return false;
    });
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, 'Alex');

    final accountNumberTextField = find.byWidgetPredicate((widget) {
      if (widget is TextField) {
        return widget.decoration?.labelText == 'Account number';
      }
      return false;
    });
    expect(accountNumberTextField, findsOneWidget);
    await tester.enterText(accountNumberTextField, '1000');

    final createButton = find.widgetWithText(TextButton, 'Create');
    await tester.tap(createButton);

    // final contactsListBack = find.byType(ContactsList);
    // expect(contactsListBack, findsOneWidget);
  });
}

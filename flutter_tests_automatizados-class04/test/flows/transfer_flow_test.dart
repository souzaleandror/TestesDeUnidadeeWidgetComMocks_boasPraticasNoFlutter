import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'actions.dart';
import 'transfer_flow_test.mocks.dart';

@GenerateMocks([ContactDao])
void main() {
  testWidgets('tranfer to a contact', (tester) async {
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

    when(mockContactDao.findAll()).thenAnswer((invocation) async {
      debugPrint('Name invocation ${invocation.memberName}');
      return [Contact(0, 'Alex', 1000)];
    });

    await clickOnTheTransferFeatureItem(tester);
    //await tester.pumpAndSettle();
    for (int i = 0; i < 5; i++) {
      await tester.pump(Duration(seconds: 1));
    }

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);

    verify(mockContactDao.findAll()).called(1);

    final contactItem = find.byWidgetPredicate((widget) {
      if (widget is ContactItem) {
        return widget.contact.name == 'Alex' &&
            widget.contact.accountNumber == 1000;
      }
      return false;
    });

    expect(contactItem, findsOneWidget);

    await tester.tap(contactItem);
    await tester.pumpAndSettle();

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm, findsOneWidget);
  });
}

import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import 'actions.dart';
import 'transfer_flow_test.mocks.dart';

@GenerateMocks([ContactDao])
@GenerateMocks([TransactionWebClient])
void main() {
  testWidgets('tranfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient();
    when(mockContactDao.findAll()).thenAnswer((_) async => []);
    when(mockContactDao.save(any)).thenAnswer((_) async => 1);
    await tester.pumpWidget(
      BytebankApp(
        contactDao: mockContactDao,
        transactionWebClient: mockTransactionWebClient,
      ),
    );
    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    final alex = Contact(0, 'Alex', 1000);
    when(mockContactDao.findAll()).thenAnswer((invocation) async {
      debugPrint('Name invocation ${invocation.memberName}');
      return [alex];
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

    final contactName = find.text('Alex');
    expect(contactName, findsOneWidget);

    final contactAccountNumber = find.text('1000');
    expect(contactAccountNumber, findsOneWidget);

    final textFieldValue = find.byWidgetPredicate((widget) {
      return textFieldByLabelTextMatcher(widget, 'Value');
    });

    expect(textFieldValue, findsOneWidget);
    await tester.enterText(textFieldValue, '200');

    final transferButton = find.widgetWithText(TextButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    await tester.tap(transferButton);
    await tester.pumpAndSettle();

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);

    final textFieldPassword =
        find.byKey(transactionAuthDialogTextFieldPasswordKey);
    expect(textFieldPassword, findsOneWidget);
    await tester.enterText(textFieldPassword, '1000');

    final cancelButton = find.widgetWithText(TextButton, 'Cancel');
    expect(cancelButton, findsOneWidget);

    final confirmButton = find.widgetWithText(TextButton, 'Confirm');
    expect(confirmButton, findsOneWidget);

    when(mockTransactionWebClient.save(Transaction(null, 200, alex), '1000'))
        .thenAnswer((_) async => Transaction(null, 200, alex));

    await tester.tap(confirmButton);
    await tester.pumpAndSettle();

    final successDialog = find.byType(SuccessDialog);
    expect(successDialog, findsOneWidget);

    final okButton = find.widgetWithText(TextButton, 'Ok');
    expect(okButton, findsOneWidget);

    await tester.tap(okButton);
    await tester.pumpAndSettle();

    final contactListBack = find.byType(ContactsList);
    expect(contactListBack, findsOneWidget);
  });
}

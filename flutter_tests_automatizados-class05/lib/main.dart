import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/app_depedencies.dart';
import 'package:flutter/material.dart';

import 'http/webclients/transaction_webclient.dart';

void main() {
  runApp(
    BytebankApp(
      contactDao: ContactDao(),
      transactionWebClient: TransactionWebClient(),
    ),
  );
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  BytebankApp({
    required this.contactDao,
    required this.transactionWebClient,
  });
  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      transactionWebClient: transactionWebClient,
      contactDao: contactDao,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: Dashboard(),
      ),
    );
  }
}

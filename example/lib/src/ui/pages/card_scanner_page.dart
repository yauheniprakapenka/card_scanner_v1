import 'package:credit_card_scanner/credit_card_scanner_plugin.dart';
import 'package:flutter/material.dart';

import '../models/credit_card_model.dart';
import '../widgets/credit_card/credit_card.dart';

class CardScannerPage extends StatelessWidget {
  const CardScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final cardScannerPlugin = CreditCardScannerPlugin();
    return Scaffold(
      appBar: AppBar(title: const Text('Credit card scanner example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<String>(
            stream: cardScannerPlugin.stream,
            builder: (context, snapshot) {
              final card = snapshot.data;
              return card == null
                  ? const Center(child: Text('Выберите карту'))
                  : Center(child: CreditCard(creditCard: CreditCardModel.fromJson(card)));
            },
          ),
          TextButton(
            onPressed: cardScannerPlugin.openScanCamera,
            child: const Text('Open card scanner'),
          ),
        ],
      ),
    );
  }
}

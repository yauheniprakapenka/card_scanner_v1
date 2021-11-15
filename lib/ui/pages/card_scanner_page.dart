import 'package:credit_card_scanner_example/domain/models/credit_card_model.dart';
import 'package:credit_card_scanner_example/ui/widgets/credit_card/credit_card.dart';
import 'package:flutter/material.dart';

import '../../card_scanner_plugin.dart';

class CardScannerPage extends StatelessWidget {
  CardScannerPage({Key? key}) : super(key: key);

  final cardScannerPlugin = CardScannerPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credit card scanner example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: cardScannerPlugin.streamCntr.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  debugPrint('Получено: ${snapshot.data}');

                  final creditCard = CreditCardModel.fromJson(
                    snapshot.data.toString(),
                  );
                  return Center(child: CreditCard(creditCard: creditCard));
                }

                return const Center(
                  child: Text('Выберите карту'),
                );
              }),
          TextButton(
            onPressed: () => cardScannerPlugin.openScanCamera(),
            child: const Text('Open card scanner'),
          )
        ],
      ),
    );
  }
}

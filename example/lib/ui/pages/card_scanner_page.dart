import 'package:credit_card_scanner/card_scanner.dart';
import 'package:credit_card_scanner_example/ui/widgets/credit_card/credit_card.dart';
import 'package:flutter/material.dart';

class CardScannerPage extends StatefulWidget {
  const CardScannerPage({Key? key}) : super(key: key);

  @override
  State<CardScannerPage> createState() => _CardScannerPageState();
}

class _CardScannerPageState extends State<CardScannerPage> {
  @override
  void initState() {
    super.initState();
    cardScannerPlugin.setMethodCallHandler();
  }

  final cardScannerPlugin = CardScannerPlugin();
  // final viewModel = CardScannerViewModel();

  @override
  void dispose() {
    cardScannerPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credit card scanner example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder<CreditCardModel?>(
              valueListenable: cardScannerPlugin.card,
              builder: (_, creditCard, ___) {
                return Center(child: CreditCard(creditCard: creditCard));
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

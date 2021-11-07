import 'package:credit_card_scanner/card_scanner_plugin.dart';
import 'package:credit_card_scanner_example/ui/view_models/card_scanner_view_model.dart';
import 'package:credit_card_scanner_example/ui/widgets/credit_card.dart';
import 'package:flutter/material.dart';

class CardScannerPage extends StatefulWidget {
  const CardScannerPage({Key? key}) : super(key: key);

  @override
  State<CardScannerPage> createState() => _CardScannerPageState();
}

class _CardScannerPageState extends State<CardScannerPage> {
  final viewModel = CardScannerViewModel();
  final cardScannerPlugin = CardScannerPlugin();

  @override
  void initState() {
    super.initState();
    cardScannerPlugin.setMethodCallHandler();
  }

  @override
  void dispose() {
    cardScannerPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder<String?>(
              valueListenable: cardScannerPlugin.card,
              builder: (_, json, ___) {
                final creditCard = viewModel.getCreditCard(json);
                if (creditCard == null) return const SizedBox();
                return Center(child: CreditCard(creditCard: creditCard));
              }),
          TextButton(
            onPressed: () => cardScannerPlugin.openScanCamera(),
            child: const Text('Открыть камеру'),
          )
        ],
      ),
    );
  }
}

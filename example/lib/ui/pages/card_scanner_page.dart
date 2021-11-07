import 'dart:convert';
import 'package:credit_card_scanner/card_scanner_plugin.dart';
import 'package:credit_card_scanner_example/domain/models/credit_card_ios_dto.dart';
import 'package:credit_card_scanner_example/ui/widgets/credit_card.dart';
import 'package:flutter/material.dart';

class CardScannerPage extends StatefulWidget {
  const CardScannerPage({Key? key}) : super(key: key);

  @override
  State<CardScannerPage> createState() => _CardScannerPageState();
}

class _CardScannerPageState extends State<CardScannerPage> {
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
              builder: (context, value, child) {
                if (value == null) return const SizedBox();
                final decodedJson = json.decode(value);
                
                final card = CreditCardIosDTO.fromJson(decodedJson);
                return Center(child: CreditCard(card: card));
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

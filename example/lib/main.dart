import 'package:flutter/material.dart';

import 'src/ui/pages/card_scanner_page.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return const MaterialApp(
      home: CardScannerPage(),
    );
  }
}

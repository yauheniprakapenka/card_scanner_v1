import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ui/pages/card_scanner_page.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CardScannerPage(),
    );
  }
}

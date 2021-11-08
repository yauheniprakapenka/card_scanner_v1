import 'package:credit_card_scanner/card_scanner.dart';

class CardScannerViewModel {
  CreditCardModel? getCreditCard(String? jsonData) {
    return CreditCardMapper.getCreditCard(jsonData);
  }
}

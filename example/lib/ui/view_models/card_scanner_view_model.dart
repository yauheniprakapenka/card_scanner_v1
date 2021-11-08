import 'package:credit_card_scanner/card_scanner.dart';
import 'package:credit_card_scanner_example/ui/view_models/credit_card_mapper.dart';

class CardScannerViewModel {
  CreditCardModel? getCreditCard(String? jsonData) {
    return CreditCardMapper.getCreditCard(jsonData);
  }
}

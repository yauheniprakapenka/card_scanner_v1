import 'dart:convert';
import 'dart:io';

import 'package:credit_card_scanner_example/domain/models/models.dart';
import 'package:flutter/material.dart';

class CardScannerViewModel {
  CreditCardModel? getCreditCard(String? jsonData) {
    return _CreditCardMapper.getCreditCard(jsonData);
  }
}

class _CreditCardMapper {
  static CreditCardModel? getCreditCard(String? jsonData) {
    if (jsonData == null) return null;

    final decodedJson = json.decode(jsonData);

    if (Platform.isIOS) {
      final creditCardIos = CreditCardIosModel.fromJson(decodedJson);
      return CreditCardModel(
        number: creditCardIos.number,
        cardHolder: creditCardIos.name,
        expiryMonth: creditCardIos.expireDate?.month,
        expiryYear: creditCardIos.expireDate?.year,
      );
    }

    if (Platform.isAndroid) {
      final creditCardAndroid = CreditCardAndroidModel.fromJson(decodedJson);
      return CreditCardModel(
        number: creditCardAndroid.cardNumber,
        cardHolder: creditCardAndroid.cardholderName,
        expiryMonth: creditCardAndroid.expiryMonth,
        expiryYear: creditCardAndroid.expiryYear,
      );
    }

    debugPrint('Unsupported platform: ${Platform.operatingSystem}');
    return null;
  }
}
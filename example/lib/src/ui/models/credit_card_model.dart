import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'credit_card_android_model.dart';
import 'credit_card_ios_model.dart';

class CreditCardModel {
  final String? number;
  final String? cardHolder;
  final int? expiryMonth;
  final int? expiryYear;

  CreditCardModel({
    this.number,
    this.cardHolder,
    this.expiryMonth,
    this.expiryYear,
  });

  /// Используемые хостами Android и iOS библиотеки для сканирования карты возвращают
  /// карту в формате JSON, где для каждой платформы он отличается.
  ///
  /// Эта фабрика позволяет привести эти JSON в единую модель.
  factory CreditCardModel.fromJson(String jsonData) {
    final decodedJson = json.decode(jsonData);

    if (Platform.isIOS) {
      final creditCardIos = CreditCardIosModel.fromJson(decodedJson);
      debugPrint(creditCardIos.toString());
      final creditCardModel = CreditCardModel(
        number: creditCardIos.number,
        cardHolder: creditCardIos.name,
        expiryMonth: creditCardIos.expireDate?.month,
        expiryYear: creditCardIos.expireDate?.year,
      );
      debugPrint(creditCardModel.toString());
      return creditCardModel;
    }

    if (Platform.isAndroid) {
      final creditCardAndroid = CreditCardAndroidModel.fromJson(decodedJson);
      debugPrint(creditCardAndroid.toString());
      final creditCardModel = CreditCardModel(
        number: creditCardAndroid.cardNumber,
        cardHolder: creditCardAndroid.cardholderName,
        expiryMonth: creditCardAndroid.expiryMonth,
        expiryYear: creditCardAndroid.expiryYear,
      );
      debugPrint(creditCardModel.toString());
      return creditCardModel;
    }

    debugPrint('Unsupported platform: ${Platform.operatingSystem}');
    return CreditCardModel();
  }

  @override
  String toString() {
    return 'CreditCardModel(number: $number, cardHolder: $cardHolder, expiryMonth: $expiryMonth, expiryYear: $expiryYear)';
  }
}

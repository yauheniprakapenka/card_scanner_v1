part of '../../card_scanner_plugin.dart';

class _CreditCardMapper {
  /// Converts the received JSON from Android or iOS.
  static CreditCardModel? getCreditCard(String? jsonData) {
    if (jsonData == null) return null;

    final decodedJson = json.decode(jsonData);

    if (Platform.isIOS) {
      final creditCardIos = _CreditCardIosModel.fromJson(decodedJson);
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
      final creditCardAndroid = _CreditCardAndroidModel.fromJson(decodedJson);
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
    return null;
  }
}

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

  @override
  String toString() {
    return 'CreditCardModel(number: $number, cardHolder: $cardHolder, expiryMonth: $expiryMonth, expiryYear: $expiryYear)';
  }
}
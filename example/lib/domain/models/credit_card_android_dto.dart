class CreditCardAndroidDTO {
  final String? cardNumber;
  final String? cardholderName;
  final int? expiryMonth;
  final int? expiryYear;

  CreditCardAndroidDTO({
    this.cardNumber,
    this.cardholderName,
    this.expiryMonth,
    this.expiryYear,
  });

  factory CreditCardAndroidDTO.fromJson(Map<String, dynamic> json) {
    var card = CreditCardAndroidDTO();

    final String? cardNumber = json['cardNumber'];
    if (cardNumber != null) card = card.copyWith(cardNumber: cardNumber);

    final String? cardholderName = json['cardholderName'];
    if (cardholderName != null) card = card.copyWith(cardNumber: cardholderName);

    final int? expiryMonth = json['expiryMonth'];
    if (expiryMonth != null) card = card.copyWith(expiryMonth: expiryMonth);

    final int? expiryYear = json['expiryYear'];
    if (expiryYear != null) card = card.copyWith(expiryYear: expiryYear);

    return card;
  }

  CreditCardAndroidDTO copyWith({
    String? cardNumber,
    String? cardholderName,
    int? expiryMonth,
    int? expiryYear,
  }) {
    return CreditCardAndroidDTO(
      cardNumber: cardNumber ?? this.cardNumber,
      cardholderName: cardholderName ?? this.cardholderName,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
    );
  }

  @override
  String toString() {
    return 'CreditCardAndroidDTO(cardNumber: $cardNumber, cardholderName: $cardholderName, expiryMonth: $expiryMonth, expiryYear: $expiryYear)';
  }
}

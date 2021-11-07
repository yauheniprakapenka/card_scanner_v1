class CreditCardViewModel {
  String getNumber(String? number) {
    return number ?? 'xxxx xxxx xxxx xxxx'.toUpperCase();
  }

  String getCardHolder(String? cardHolder) {
    return cardHolder ?? 'card holder'.toUpperCase();
  }

  String getExpiryMonth(int? expiryMonth) {
    final month = '${_handleDate(expiryMonth) ?? 'xx'}';
    final formattedMonth = month.padLeft(2, '0').toUpperCase();
    return formattedMonth;
  }

  String getExpiryYear(int? expiryYear) {
    final year = '${_handleDate(expiryYear) ?? 'xxxx'}';
    final formattedYear = year.toUpperCase();
    return formattedYear;
  }

  int? _handleDate(int? date) {
    // Card.io для Android может вернуть `0` для года и месяца, если не смог распознать.
    // Пример
    // CreditCardAndroidDTO(expiryMonth: 0, expiryYear: 0)
    // CreditCardModel(expiryMonth: 0, expiryYear: 0)
    // Чтобы не показывать `0`, заменяем на null
    if (date == 0) return null;
    return date;
  }
}

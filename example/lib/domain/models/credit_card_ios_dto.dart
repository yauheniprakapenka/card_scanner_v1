class CreditCardIosDTO {
  final String? name;
  final String? number;
  final _ExpireDate? expireDate;

  CreditCardIosDTO({
    this.name,
    this.number,
    this.expireDate,
  });

  factory CreditCardIosDTO.fromJson(Map<String, dynamic> json) {
    var card = CreditCardIosDTO();

    final String? name = json['name'];
    if (name != null) card = card.copyWith(name: name);

    final String? number = json['number'];
    if (number != null) card = card.copyWith(number: number);

    final Map<String, dynamic>? expireDate = json['expireDate'];
    if (expireDate != null) card = card.copyWith(expireDate: _ExpireDate.fromJson(expireDate));

    return card;
  }

  @override
  String toString() =>
      'CreditCard(name: $name, number: $number, expireDate: $expireDate)';

  CreditCardIosDTO copyWith({
    String? name,
    String? number,
    _ExpireDate? expireDate,
  }) {
    return CreditCardIosDTO(
      name: name ?? this.name,
      number: number ?? this.number,
      expireDate: expireDate ?? this.expireDate,
    );
  }
}

class _ExpireDate {
  final int? year;
  final int? month;

  _ExpireDate({
    this.year,
    this.month,
  });

  factory _ExpireDate.fromJson(Map<String, dynamic> json) {
    var expireDate = _ExpireDate();

    final int? year = json['year'];
    if (year != null) expireDate = expireDate.copyWith(year: year);

    final int? month = json['month'];
    if (month != null) expireDate = expireDate.copyWith(month: month);

    return expireDate;
  }

  @override
  String toString() => '_ExpireDate(year: $year, month: $month)';

  _ExpireDate copyWith({
    int? year,
    int? month,
  }) {
    return _ExpireDate(
      year: year ?? this.year,
      month: month ?? this.month,
    );
  }
}

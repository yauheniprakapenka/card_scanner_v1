class IosCreditCardDTO {
  final String? name;
  final String? number;
  final _ExpireDate? expireDate;

  IosCreditCardDTO({
    this.name,
    this.number,
    this.expireDate,
  });

  factory IosCreditCardDTO.fromJson(Map<String, dynamic> json) {
    var card = IosCreditCardDTO();

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

  IosCreditCardDTO copyWith({
    String? name,
    String? number,
    _ExpireDate? expireDate,
  }) {
    return IosCreditCardDTO(
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

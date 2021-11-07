import 'package:credit_card_scanner_example/domain/models/credit_card_model.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final CreditCardModel creditCard;

  const CreditCard({
    Key? key,
    required this.creditCard,
  }) : super(key: key);

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 120,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(creditCard.number ?? ''),
          Row(
            children: [
              Text(creditCard.cardHolder ?? ''),
              const Spacer(),
              Text('${creditCard.expiryMonth ?? ''}'.padLeft(2, '0')),
              const Text(' / '),
              Text('${creditCard.expiryYear ?? ''}'),
            ],
          )
        ],
      ),
    );
  }
}

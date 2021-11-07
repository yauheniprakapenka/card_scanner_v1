import 'package:credit_card_scanner_example/domain/models/credit_card_dto.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final IosCreditCardDTO card;

  const CreditCard({
    Key? key,
    required this.card,
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
          Text(card.number ?? '-'),
          Row(
            children: [
              Text(card.name ?? '-'),
              const Spacer(),
              Text('${card.expireDate?.month ?? ''}'.padLeft(2, '0')),
              const Text(' / '),
              Text('${card.expireDate?.year ?? ''}'),
            ],
          )
        ],
      ),
    );
  }
}

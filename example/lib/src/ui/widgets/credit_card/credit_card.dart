import 'package:flutter/material.dart';

import '../../models/credit_card_model.dart';
import 'credit_card_view_model.dart';

class CreditCard extends StatelessWidget {
  final CreditCardModel? creditCard;

  CreditCard({
    Key? key,
    required this.creditCard,
  }) : super(key: key);

  final viewModel = CreditCardViewModel();

  @override
  Widget build(context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 120,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(viewModel.getNumber(creditCard?.number)),
          Row(
            children: [
              Text(viewModel.getCardHolder(creditCard?.cardHolder)),
              const Spacer(),
              Text(viewModel.getExpiryMonth(creditCard?.expiryMonth)),
              const Text(' / '),
              Text(viewModel.getExpiryYear(creditCard?.expiryYear)),
            ],
          )
        ],
      ),
    );
  }
}

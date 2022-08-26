import 'dart:developer';

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.label,
    required this.amount,
    required this.amountPercentage,
  });
  final String label;
  final double amount;
  final double amountPercentage;

  @override
  Widget build(BuildContext context) {
    log(amountPercentage.toString());
    return Column(
      children: [
        Text(label),
        SizedBox(
          height: 100,
          width: 20,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(220, 216, 216, 216),
                  ),
                  color: const Color.fromARGB(220, 216, 216, 216),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: amountPercentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
          child: FittedBox(child: Text(amount.toStringAsFixed(0))),
        ),
      ],
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/home/models/transaction.dart';
import 'package:personal_expenses_app/home/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.trasacation});
  final List<Transaction> trasacation;

  List<DaysTransaction> get groupsTransacationValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;

      for (final tx in trasacation) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalAmount += tx.amount;
        }
      }
      return DaysTransaction(
        amount: totalAmount,
        day: DateFormat.E().format(weekDay),
      );
    }).reversed.toList();
  }

  double get totleSpanding {
    return groupsTransacationValues.fold(
      0,
      (total, element) => total + element.amount,
    );
  }

  @override
  Widget build(BuildContext context) {
    for (final tx in groupsTransacationValues) {
      log('day: ${tx.day}, amount: ${tx.amount}');
    }
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupsTransacationValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: e.day,
                amount: e.amount,
                amountPercentage: (e.amount / totleSpanding >= 0.0)
                    ? e.amount / totleSpanding
                    : 0.0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class DaysTransaction {
  DaysTransaction({required this.amount, required this.day});

  final double amount;
  final String day;
}

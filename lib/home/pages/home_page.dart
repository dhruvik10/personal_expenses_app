import 'package:flutter/material.dart';
import 'package:personal_expenses_app/home/models/transaction.dart';
import 'package:personal_expenses_app/home/widgets/chart.dart';
import 'package:personal_expenses_app/home/widgets/new_transaction.dart';
import 'package:personal_expenses_app/home/widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [];

  void _newUserTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      date: date,
      title: title,
      amount: amount,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void deleteTransacation(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }

  Future<dynamic> startNewExpense() {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      builder: (context) => NewTransaction(newTransaction: _newUserTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: startNewExpense,
            icon: const Icon(Icons.add),
            tooltip: 'Add new expense',
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Chart(trasacation: _recentTransaction),
              const SizedBox(
                height: 10,
              ),
              if (_userTransactions.isNotEmpty)
                Flexible(
                  child: TransactionList(
                    transactions: _userTransactions,
                    deleteTransaction: deleteTransacation,
                  ),
                )
              else
                Image.asset('assets/images/imaggg.png'),
            ],
          ),
        ),
      ),
    );
  }
}

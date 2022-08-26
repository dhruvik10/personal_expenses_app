import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/home/models/transaction.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({
    super.key,
    required this.transactions,
    required this.deleteTransaction,
  });
  final List<Transaction> transactions;
  final void Function(int) deleteTransaction;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemCount: widget.transactions.length,
      itemBuilder: (context, index) {
        final tx = widget.transactions[index];
        return Card(
          elevation: 3,
          child: ListTile(
            subtitle: Text(DateFormat.yMd('es').format(tx.date)),
            trailing: MediaQuery.of(context).size.width > 450
                ? ElevatedButton.icon(
                    onPressed: () => widget.deleteTransaction(index),
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Theme.of(context).errorColor,
                    ),
                    label: Text(
                      'Delete',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => widget.deleteTransaction(index),
                  ),
            title: Text(
              tx.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    '\$${tx.amount}',
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

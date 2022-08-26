import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({required this.newTransaction, super.key});
  final void Function(String, double, DateTime) newTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _onSubmitted() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    _formKey.currentState?.save();
    widget.newTransaction(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );
    Navigator.pop(context);
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    setState(() => _selectedDate = date!);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10) +
            EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
        children: [
          Text(
            'New Expense',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _titleController,
            onFieldSubmitted: (_) => _onSubmitted(),
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            validator: (value) {
              final title = value?.trim() ?? '';
              if (title.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _amountController,
            onFieldSubmitted: (_) => _onSubmitted(),
            decoration: InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              final amount = double.tryParse(value ?? '') ?? 0;
              if (amount.isNegative || amount.isNaN || amount == 0) {
                return 'Please enter a valid amount';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(DateFormat.yMd('es').format(_selectedDate)),
              TextButton(
                onPressed: _selectDate,
                child: Text(
                  'Choose date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _onSubmitted,
                child: Text(
                  'Add new expense',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

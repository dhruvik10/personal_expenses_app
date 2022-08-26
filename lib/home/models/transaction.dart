class Transaction {
  Transaction({
    required this.id,
    required this.date,
    required this.title,
    required this.amount,
  });

  final String id;
  final String title;
  final double amount;
  final DateTime date;
}

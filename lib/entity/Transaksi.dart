class Transaction {
  final String date;
  final String service;
  final String price;

  Transaction({required this.date, required this.service, required this.price});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      date: json['date'] ?? '',
      service: json['service'] ?? '',
      price: 'Rp ${json['price'] ?? 0}',
    );
  }
}

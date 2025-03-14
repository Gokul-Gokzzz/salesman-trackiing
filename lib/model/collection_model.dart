class GetCollection {
  final String id;
  final String client;
  final String salesman;
  final int amount;
  final DateTime date;
  final String clientName;

  GetCollection({
    required this.id,
    required this.client,
    required this.salesman,
    required this.amount,
    required this.date,
    required this.clientName,
  });

  factory GetCollection.fromJson(Map<String, dynamic> json) {
    return GetCollection(
      id: json['_id'],
      client: json['client'],
      salesman: json['salesman'],
      amount: (json['amount'] is int)
          ? json['amount']
          : (json['amount'] as num).toInt(),
      date: DateTime.parse(json['date']),
      clientName: json['clientName'],
    );
  }
}

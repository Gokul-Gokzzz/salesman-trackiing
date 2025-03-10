class Collection {
  final String id;
  final Client client;
  final String salesman;
  final double amount;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  Collection({
    required this.id,
    required this.client,
    required this.salesman,
    required this.amount,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['_id'],
      client: Client.fromJson(json['client']),
      salesman: json['salesman'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Client {
  final String id;
  final String name;

  Client({required this.id, required this.name});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['_id'],
      name: json['name'],
    );
  }
}

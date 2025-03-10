class OrderSummary {
  final String id;
  final String status;
  final double totalAmount;
  final Client client;
  final List<OrderProduct> products;
  final DateTime createdAt;

  OrderSummary({
    required this.id,
    required this.status,
    required this.totalAmount,
    required this.client,
    required this.products,
    required this.createdAt,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(
      id: json['_id'],
      status: json['status'],
      totalAmount: (json['totalAmount'] as num).toDouble(),
      client: Client.fromJson(json['clientId']),
      products: (json['products'] as List)
          .map((item) => OrderProduct.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class Client {
  final String id;
  final String name;
  final String contact;
  final String address;
  final double outstandingDue;

  Client({
    required this.id,
    required this.name,
    required this.contact,
    required this.address,
    required this.outstandingDue,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['_id'],
      name: json['name'],
      contact: json['contact'],
      address: json['address'],
      outstandingDue: (json['outstandingDue'] as num).toDouble(),
    );
  }
}

class OrderProduct {
  final String id;
  final String name;
  final double price;
  final int quantity;

  OrderProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['productId']['_id'],
      name: json['productId']['name'],
      price: (json['productId']['price'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
}

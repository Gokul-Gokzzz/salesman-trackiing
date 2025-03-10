class ClientModel {
  final String id;
  final String name;
  final String companyName;
  final String email;
  final String contact;
  final String address;
  final int outstandingDue;
  final int ordersPlaced;

  ClientModel({
    required this.id,
    required this.name,
    required this.companyName,
    required this.email,
    required this.contact,
    required this.address,
    required this.outstandingDue,
    required this.ordersPlaced,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['_id'],
      name: json['name'],
      companyName: json['companyName'],
      email: json['email'],
      contact: json['contact'],
      address: json['address'],
      outstandingDue: json['outstandingDue'] ?? 0,
      ordersPlaced: json['ordersPlaced'] ?? 0,
    );
  }
}

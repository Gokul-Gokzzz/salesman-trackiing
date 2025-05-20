class ClientModel {
  final String id;
  final String name;
  final String companyName;
  final String email;
  final String contact;
  final String address;
  final List<Branch> branches;
  final int outstandingDue;
  final int ordersPlaced;

  ClientModel({
    required this.id,
    required this.name,
    required this.companyName,
    required this.email,
    required this.branches,
    required this.contact,
    required this.address,
    required this.outstandingDue,
    required this.ordersPlaced,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      companyName: json['companyName'] ?? "",
      email: json['email'] ?? "",
      contact: json['contact'] ?? "",
      branches: (json['branches'] as List)
              .map((branchJson) => Branch.fromJson(branchJson))
              .toList() ??
          [],
      address: json['address'] ?? "",
      outstandingDue: json['outstandingDue'] ?? 0,
      ordersPlaced: json['ordersPlaced'] ?? 0,
    );
  }
}

class Branch {
  final String id;
  final String branchName;
  final String location;

  Branch({
    required this.id,
    required this.branchName,
    required this.location,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['_id'] ?? "",
      branchName: json['branchName'] ?? "",
      location: json['location'] ?? "",
    );
  }
}

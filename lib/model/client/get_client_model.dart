class ClientModel {
  final String id;
  final String name;
  final String companyName;
  final String email;
  final String contact;
  final String address;
  final List<Branch> branches;
  final int outstandingDue;
  // final int ordersPlaced;

  ClientModel({
    required this.id,
    required this.name,
    required this.companyName,
    required this.email,
    required this.branches,
    required this.contact,
    required this.address,
    required this.outstandingDue,
    // required this.ordersPlaced,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    // Safely parse branches:
    // 1. Check if 'branches' key exists and is a List.
    // 2. If it is, map through it.
    // 3. Otherwise, provide an empty list as default.
    final List<dynamic>? branchesData = json['branches'];
    final List<Branch> parsedBranches = branchesData != null &&
            branchesData is List
        ? branchesData
            .where((branchJson) =>
                branchJson != null && branchJson is Map<String, dynamic>)
            .map((branchJson) =>
                Branch.fromJson(branchJson as Map<String, dynamic>))
            .toList()
        : []; // Provide an empty list if branchesData is null or not a List

    return ClientModel(
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      companyName: json['companyName'] ?? "",
      email: json['email'] ?? "",
      contact: json['contact'] ?? "",
      branches: parsedBranches, // Use the safely parsed list
      address: json['address'] ?? "",
      outstandingDue: json['outstandingDue'] ?? 0,
      // ordersPlaced: json['ordersPlaced'] ?? 0,
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

class AddClient {
  final String? id;
  final String salesmanId;
  final String name;
  final String companyName;
  final String email;
  final String contact;
  final String address;
  // final int? ordersPlaced;
  final double outstandingDue;
  final List<Branch> branches;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  AddClient({
    this.id,
    required this.salesmanId,
    required this.name,
    required this.companyName,
    required this.email,
    required this.contact,
    required this.address,
    // this.ordersPlaced,
    required this.outstandingDue,
    required this.branches,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AddClient.fromJson(Map<String, dynamic> json) {
    return AddClient(
      id: json['_id'],
      salesmanId: json['salesmanId'],
      name: json['name'],
      companyName: json['companyName'],
      email: json['email'],
      contact: json['contact'],
      address: json['address'],
      // ordersPlaced: json['ordersPlaced'],
      outstandingDue: (json['outstandingDue'] as num).toDouble(),
      branches: (json['branches'] as List)
          .map((branch) => Branch.fromJson(branch))
          .toList(),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salesmanId': salesmanId,
      'name': name,
      'companyName': companyName,
      'email': email,
      'contact': contact,
      'address': address,
      // 'ordersPlaced': ordersPlaced,
      'outstandingDue': outstandingDue,
      'branches': branches.map((branch) => branch.toJson()).toList(),
    };
  }
}

class Branch {
  final String branchName;
  final String location;
  final String? id;

  Branch({
    required this.branchName,
    required this.location,
    this.id,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      branchName: json['branchName'],
      location: json['location'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branchName': branchName,
      'location': location,
    };
  }
}

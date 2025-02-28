class Collection {
  final int id;
  final String client;
  final double amount;
  final String date;

  Collection({
    required this.id,
    required this.client,
    required this.amount,
    required this.date,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'],
      client: json['client'],
      amount: double.parse(json['amount'].toString()),
      date: json['date'],
    );
  }
}

class GetCollectionModel {
  final List<Collection> collections;

  GetCollectionModel({required this.collections});

  factory GetCollectionModel.fromJson(List<dynamic> jsonList) {
    List<Collection> collections =
        jsonList.map((json) => Collection.fromJson(json)).toList();
    return GetCollectionModel(collections: collections);
  }
}

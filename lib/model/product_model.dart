class Product {
  String? id;
  String? name;
  double? price;
  int? stock;
  String? createdAt;
  String? updatedAt;
  int? v;

  Product({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'].toDouble();
    stock = json['stock'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['stock'] = stock;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    return data;
  }
}

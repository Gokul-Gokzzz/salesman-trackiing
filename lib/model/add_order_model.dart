class Order {
  final String salesmanId;
  final String clientId;
  final List<ProductOrder> products;
  final double totalAmount;
  final String status;

  Order({
    required this.salesmanId,
    required this.clientId,
    required this.products,
    required this.totalAmount,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "salesmanId": salesmanId,
      "clientId": clientId,
      "products": products.map((product) => product.toJson()).toList(),
      "totalAmount": totalAmount,
      "status": status,
    };
  }
}

class ProductOrder {
  final String productId;
  final int quantity;

  ProductOrder({required this.productId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "quantity": quantity,
    };
  }
}

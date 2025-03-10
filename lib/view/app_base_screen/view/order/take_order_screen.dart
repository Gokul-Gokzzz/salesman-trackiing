import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/add_order_controller.dart';
import 'package:salesman/controller/client/get_client_controller.dart';
import 'package:salesman/model/add_order_model.dart';
import 'package:salesman/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TakeOrderScreen extends StatefulWidget {
  final Product orderedProduct;

  const TakeOrderScreen({Key? key, required this.orderedProduct})
      : super(key: key);

  @override
  _TakeOrderScreenState createState() => _TakeOrderScreenState();
}

class _TakeOrderScreenState extends State<TakeOrderScreen> {
  int quantity = 1;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.orderedProduct.price ?? 0.0;
  }

  void _updateTotalPrice(int newQuantity) {
    setState(() {
      quantity = newQuantity;
      totalPrice = (widget.orderedProduct.price ?? 0.0) * quantity;
    });
  }
//  void _updateTotalPrice(int newQuantity) {
//     setState(() {
//       quantity = newQuantity;
//       totalPrice = (widget.orderedProduct.price ?? 0.0) * quantity;
//     });
//   }

  void _submitOrder(BuildContext context) async {
    final orderController =
        Provider.of<OrderController>(context, listen: false);
    final clientController =
        Provider.of<ClientProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId =
        prefs.getString('id'); // Retrieve ID from SharedPreferences

    if (salesmanId == null || salesmanId.isEmpty) {
      log("❌ Salesman ID is null or empty!");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Salesman ID not found")));
      return;
    }

    log("✅ Salesman ID: $salesmanId");

    String? clientId = clientController.selectedClient?.id.toString();

    if (clientId == null || clientId.isEmpty) {
      log("❌ Client ID is null or empty!");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Client ID not found")));
      return;
    }

    log("✅ Client ID: $clientId");

    Order order = Order(
      salesmanId: salesmanId,
      clientId: clientId,
      products: [
        ProductOrder(
          productId: widget.orderedProduct.id ?? "",
          quantity: quantity,
        )
      ],
      totalAmount: totalPrice,
      status: "pending",
    );

    await orderController.createOrder(order);

    if (orderController.message.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(orderController.message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 263,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/takeorder_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Take Order",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 15,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset("assets/images/backbutton.svg"),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                ],
              ),
              child: ListTile(
                title: Text(widget.orderedProduct.name ?? "Product",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.orderedProduct.price.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(widget.orderedProduct.stock.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: quantity > 1
                          ? () => _updateTotalPrice(quantity - 1)
                          : null,
                    ),
                    Text(quantity.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      icon: Icon(Icons.add_circle, color: Colors.green),
                      onPressed: () => _updateTotalPrice(quantity + 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
              ],
            ),
            child: Column(
              children: [
                _buildPriceRow("Subtotal",
                    "₹${(widget.orderedProduct.price ?? 0.0) * quantity}"),
                // _buildPriceRow("Delivery", "₹45"),
                Divider(),
                _buildPriceRow("Total",
                    "₹${(widget.orderedProduct.price ?? 0.0) * quantity}",
                    isTotal: true),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () => _submitOrder(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF094497),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Submit",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: isTotal ? Colors.black : Colors.grey.shade700)),
        ],
      ),
    );
  }
}

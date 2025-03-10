import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/order_summery_controller.dart';
import 'package:salesman/model/order/order_sumery_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderSummaryScreen extends StatefulWidget {
  const OrderSummaryScreen({Key? key}) : super(key: key);

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadOrderSummary();
    });
  }

  Future<void> _loadOrderSummary() async {
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

    Provider.of<OrderSummaryController>(context, listen: false)
        .loadOrders(salesmanId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Consumer<OrderSummaryController>(
        builder: (context, orderController, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 263,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/images/takeorder_bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Order Summary",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
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
                        child:
                            const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recent Orders",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        height: 3,
                        width: 59,
                        decoration: BoxDecoration(
                          color: const Color(0XFF094497),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(height: 30.75),
                      orderController.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : orderController.orders.isEmpty
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      "No orders available!",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              : Column(
                                  children: orderController.orders.map((order) {
                                    return OrderCard(order: order);
                                  }).toList(),
                                ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderSummary order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 14,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // _buildInfoRow("Order ID:", order.orderId.toString()),
            const Divider(),
            _buildInfoRow("Customer:", order.client.name ?? "Unknown"),
            const Divider(),
            _buildInfoRow("Total Amount:", "₹${order.totalAmount}"),
            const Divider(),
            _buildInfoRow("Status:", order.status),
            const SizedBox(height: 10),
            // ElevatedButton(
            //   onPressed: () {
            //     // Handle order details view
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color(0XFF094497),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //   ),
            //   child: const Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
            //     child: Text(
            //       "View Details",
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w600,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0XFF094497),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

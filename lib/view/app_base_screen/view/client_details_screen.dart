import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/get_client_controller.dart';
import 'package:salesman/model/add_client_form_model.dart';

class ClientDetailsScreen extends StatefulWidget {
  final String clientId;
  const ClientDetailsScreen({
    super.key,
    required this.clientId,
  });

  @override
  _ClientDetailsScreenState createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  Client? clientDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchClientDetails();
  }

  Future<void> _fetchClientDetails() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final provider = Provider.of<ClientProvider>(context, listen: false);
        log("Fetching client details for ID: 67ad71e20b04e1597a61f0eb");
        clientDetails = await provider.fetchClientDetails(widget.clientId);
        log("Client details fetched: ${clientDetails!.address}"); // Log the fetched client details
      } catch (e) {
        debugPrint("Error fetching client details: $e");
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30.75),
                  const Text(
                    "Client Details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 3,
                    width: 66.02,
                    decoration: BoxDecoration(
                      color: const Color(0XFF094497),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 30.75),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      // : clientDetails == null
                      //     ? const Center(child: Text("Client not found"))
                      : _buildClientDetails(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 318,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            image: DecorationImage(
              image: AssetImage("assets/images/expense_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: const Center(
            child: Text(
              "Client Details",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Color(0XFFFFFFFF),
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
            child: Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }

  Widget _buildClientDetails() {
    final provider = Provider.of<ClientProvider>(context, listen: false);
    var client = provider.selectedClient;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0XFFFFFFFF),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${client?.name ?? 'N/A'}"),
            Text("Company: ${client?.companyName ?? 'N/A'}"),
            Text("Email: ${client?.email ?? 'N/A'}"),
            Text("Contact: ${client?.contact ?? 'N/A'}"),
            Text("Address: ${client?.address ?? 'N/A'}"),
            Text("Outstanding Due: ${client?.outstandingDue ?? 'N/A'}"),
            Text("Orders Placed: ${client?.ordersPlaced ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }
}

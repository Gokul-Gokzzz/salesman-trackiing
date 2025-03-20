import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/client/get_client_controller.dart';
import 'package:salesman/model/add_client_form_model.dart';
import 'package:salesman/model/client/get_client_model.dart';

class ClientDetailsScreen extends StatefulWidget {
  final String clientId;
  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  _ClientDetailsScreenState createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  AddClient? clientDetails;
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
        log("Fetching client details for ID: ${widget.clientId}");
        clientDetails = await provider.fetchClientDetails(widget.clientId);
        log("Client details fetched: ${clientDetails?.address ?? 'N/A'}");
      } catch (e) {
        debugPrint("Error fetching client details: $e");
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  // Future<void> _deleteClient() async {
  // final provider = Provider.of<ClientProvider>(context, listen: false);
  // bool confirmDelete = await _showDeleteConfirmationDialog();
  // if (!confirmDelete) return;

  // try {
  //   await provider.deleteClient(widget.clientId);
  //   if (mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Client deleted successfully")),
  //     );
  //     Navigator.pop(context); // Go back after deletion
  //   }
  // } catch (e) {
  //   debugPrint("Error deleting client: $e");
  //   if (mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Failed to delete client")),
  //     );
  //   }
  // }
  // }

  // Future<bool> _showDeleteConfirmationDialog() async {
  //   return await showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: const Text("Confirm Delete"),
  //           content: const Text("Are you sure you want to delete this client?"),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, false),
  //               child: const Text("Cancel"),
  //             ),
  //             TextButton(
  //               onPressed: () => Navigator.pop(context, true),
  //               child:
  //                   const Text("Delete", style: TextStyle(color: Colors.red)),
  //             ),
  //           ],
  //         ),
  //       ) ??
  //       false;
  // }

  @override
  Widget build(BuildContext context) {
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
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
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
        color: Colors.white,
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
            // Text("Orders Placed: ${client?.ordersPlaced ?? 'N/A'}"),
            Text('Branches'),
            if (client?.branches != null)
              for (var branch in client!.branches)
                Text(
                    'Branch Name:${branch.branchName},Location:${branch.location}'),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showEditDialog(provider, client);
                  },
                  child: const Text("Edit"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    bool deleted = await provider.deleteClient(client!.id);
                    if (deleted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(ClientProvider provider, ClientModel? client) {
    final nameController = TextEditingController(text: client?.name);
    final contactController = TextEditingController(text: client?.contact);
    final addressController = TextEditingController(text: client?.address);
    final dueController =
        TextEditingController(text: client?.outstandingDue.toString());
    // final ordersController =
    //     TextEditingController(text: client?.ordersPlaced.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand properly
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom +
                16, // Adjust for keyboard
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Edit Client",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: contactController,
                  decoration: const InputDecoration(labelText: "Contact"),
                ),
                TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: "Address"),
                ),
                TextField(
                  controller: dueController,
                  decoration:
                      const InputDecoration(labelText: "Outstanding Due"),
                  keyboardType: TextInputType.number,
                ),
                // TextField(
                //   controller: ordersController,
                //   decoration: const InputDecoration(labelText: "Orders Placed"),
                //   keyboardType: TextInputType.number,
                // ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.red)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final data = {
                          "name": nameController.text,
                          "contact": contactController.text,
                          "address": addressController.text,
                          "outstandingDue":
                              int.tryParse(dueController.text) ?? 0,
                          // "ordersPlaced":
                          //     int.tryParse(ordersController.text) ?? 0,
                        };
                        bool updated =
                            await provider.updateClient(client!.id, data);
                        if (updated) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

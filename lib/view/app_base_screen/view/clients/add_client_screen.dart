import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/add_client_form_controller.dart';
import 'package:salesman/model/add_client_form_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController outstandingDueController =
      TextEditingController();
  List<Branch> branches = [];
  final TextEditingController ordersPlacedController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    companyNameController.dispose();
    contactController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  // Future<String> _getLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     log("❌ Location services are disabled.");
  //     return "Location Disabled";
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       log("❌ Location permissions denied.");
  //       return "Permission Denied";
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     log("❌ Location permissions are permanently denied.");
  //     return "Permission Denied";
  //   }

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   return "${position.latitude}, ${position.longitude}";
  // }

  Future<void> _addClient(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId = prefs.getString('id');

    if (salesmanId == null || salesmanId.isEmpty) {
      log("❌ Salesman ID is null or empty!");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Salesman ID not found")));
      return;
    }

    log("✅ Salesman ID: $salesmanId");

    // final nameController = TextEditingController();
    // final companyNameController = TextEditingController();
    // final emailController = TextEditingController();
    // final contactController = TextEditingController();
    // final addressController = TextEditingController();
    // final outstandingDueController = TextEditingController();
    // final ordersPlacedController = TextEditingController(); //add orders placed controller

    final client = AddClient(
      salesmanId: salesmanId,
      name: nameController.text,
      companyName: companyNameController.text,
      email: emailController.text,
      contact: contactController.text,
      address: addressController.text,
      outstandingDue: double.tryParse(outstandingDueController.text) ?? 0.0,
      ordersPlaced:
          int.tryParse(ordersPlacedController.text) ?? 0, //parse orders placed
      branches: branches, // Handle branches as needed (add branch logic)
    );
    log('Sending Client Data: ${client.toJson()}');

    try {
      final addedClient =
          await Provider.of<AddClientProvider>(context, listen: false)
              .addClient(client);

      log('Client added successfully: ${addedClient.name}');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Client added successfully!")));
      Navigator.pop(context); // Navigate back on success
    } catch (e) {
      log('Error adding client: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to add client: $e")));
    }
  }

  void _addBranch() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String branchName = '';
        String location = '';

        return AlertDialog(
          title: const Text('Add Branch'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Branch Name'),
                  onChanged: (value) => branchName = value,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Location'),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => location = value,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  branches.add(Branch(
                    branchName: branchName,
                    location: location,
                  ));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<AddClientProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 318,
                width: double.maxFinite,
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
                    textAlign: TextAlign.center,
                    "Add Client Form",
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
                  child: SvgPicture.asset("assets/images/backbutton.svg"),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30.75,
                    ),
                    const Text(
                      "Client Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 3,
                      width: 66.02,
                      decoration: BoxDecoration(
                          color: const Color(0XFF094497),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    const SizedBox(
                      height: 30.75,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: const Color(0XFFFFFFFF),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                labelText: "Client Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: companyNameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                labelText: "Company Name",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: "Email",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: contactController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Contact Number",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: addressController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                labelText: "Address",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: outstandingDueController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Outstanding Due",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: ordersPlacedController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "orderplaced",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _addBranch,
                              child: const Text('Add Branch'),
                            ),
                            const SizedBox(height: 20),
                            if (branches.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Branches:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  for (var branch in branches)
                                    ListTile(
                                      title: Text(
                                          'Branch Name:${branch.branchName}'),
                                      subtitle:
                                          Text('Location: ${branch.location},'),
                                    ),
                                ],
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 100,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0XFF094497)),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Color(0XFF094497),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.14),
                                      )),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _addClient(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0XFF094497),
                                        elevation: 0),
                                    child: clientProvider.isLoading
                                        ? CircularProgressIndicator()
                                        : Text(
                                            "Save Client",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10.14),
                                          )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

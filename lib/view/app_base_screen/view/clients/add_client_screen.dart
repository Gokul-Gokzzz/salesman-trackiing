import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/add_client_form_controller.dart';
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
  // final TextEditingController ordersPlacedController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    companyNameController.dispose();
    contactController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _addClient() async {
    final clientProvider =
        Provider.of<AddClientProvider>(context, listen: false);
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

    final clientData = {
      "salesmanId": salesmanId,
      "name": nameController.text,
      "companyName": companyNameController.text,
      "contact": contactController.text,
      "email": emailController.text,
      "address": addressController.text,
      "outstandingDue": outstandingDueController.text,
      // "ordersPlaced": ordersPlacedController.text
    };

    await clientProvider.addClient(clientData);

    if (clientProvider.message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(clientProvider.message!)),
      );

      if (clientProvider.clientModel != null) {
        Navigator.pop(context); // only pop if client added successfully.
      }
    }
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
                                      onPressed: () {},
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
                                      _addClient();
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

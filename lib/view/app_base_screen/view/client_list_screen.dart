import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/get_client_controller.dart';
import 'package:salesman/model/get_client_model.dart';
import 'package:salesman/view/app_base_screen/view/add_client_screen.dart';
import 'package:salesman/view/app_base_screen/view/client_details_screen.dart'; // Assuming you have this screen

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ClientProvider>(context, listen: false).fetchClients());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Consumer<ClientProvider>(
        builder: (context, clientProvider, child) {
          return Column(
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
                        "Clients",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
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
                      if (clientProvider.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (clientProvider.clients.isEmpty)
                        const Center(child: Text("No clients added yet."))
                      else
                        Expanded(
                          child: ListView.builder(
                            itemCount: clientProvider.clients.length,
                            itemBuilder: (context, index) {
                              return _buildClientListItem(
                                  clientProvider.clients[index]);
                            },
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddClientScreen()),
          ).then((_) {
            Provider.of<ClientProvider>(context, listen: false).fetchClients();
          });
        },
        backgroundColor: const Color(0XFF094497),
        child: const Icon(Icons.add, color: Colors.white),
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
              "Client List",
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
            child: SvgPicture.asset("assets/images/backbutton.svg"),
          ),
        ),
      ],
    );
  }

  Widget _buildClientListItem(Client client) {
    // log("client id : ${client.id}");
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientDetailsScreen(
                      clientId: client.id!,
                    )));
      },
      child: Container(
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
              Text("Name: ${client.name ?? 'N/A'}"),
              Text("Company: ${client.companyName ?? 'N/A'}"),
              Text("Email: ${client.email ?? 'N/A'}"),
              Text("Contact: ${client.contact ?? 'N/A'}"),
              Text("Address: ${client.address ?? 'N/A'}"),
              Text("Outstanding Due: ${client.outstandingDue ?? 'N/A'}"),
              Text("Orders Placed: ${client.ordersPlaced ?? 'N/A'}"),
            ],
          ),
        ),
      ),
    );
  }
}

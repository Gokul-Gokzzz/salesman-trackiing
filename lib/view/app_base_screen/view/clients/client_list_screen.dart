import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/client/get_client_controller.dart';
import 'package:salesman/model/client/get_client_model.dart';
import 'package:salesman/view/app_base_screen/view/clients/add_client_screen.dart';
import 'package:salesman/view/app_base_screen/view/clients/client_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientListScreen extends StatefulWidget {
  const ClientListScreen({super.key});

  @override
  _ClientListScreenState createState() => _ClientListScreenState();
}

class _ClientListScreenState extends State<ClientListScreen> {
  TextEditingController _searchController = TextEditingController();
  List<ClientModel> _filteredClients = [];

  @override
  void initState() {
    super.initState();
    _fetchClients();
  }

  Future<void> _fetchClients() async {
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId = prefs.getString('id');

    if (salesmanId == null || salesmanId.isEmpty) {
      log("❌ Salesman ID is null or empty!");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Salesman ID not found")),
        );
      }
      return;
    }

    log("✅ Salesman ID: $salesmanId");
    if (mounted) {
      await Provider.of<ClientProvider>(context, listen: false)
          .getClients(salesmanId);
      _updateFilteredList();
    }
  }

  void _updateFilteredList() {
    final provider = Provider.of<ClientProvider>(context, listen: false);
    setState(() {
      _filteredClients = provider.clients;
    });
  }

  void _filterClients(String query) {
    final provider = Provider.of<ClientProvider>(context, listen: false);
    setState(() {
      _filteredClients = provider.clients
          .where((client) =>
              client.name!.toLowerCase().contains(query.toLowerCase()) ||
              (client.companyName != null &&
                  client.companyName!
                      .toLowerCase()
                      .contains(query.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Consumer<ClientProvider>(
        builder: (context, clientProvider, child) {
          return RefreshIndicator(
            onRefresh: _fetchClients,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildSearchBar(),
                        const SizedBox(height: 20),
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
                        const SizedBox(height: 20),
                        if (clientProvider.isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (_filteredClients.isEmpty)
                          const Center(child: Text("No clients found."))
                        else
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: _filteredClients.length,
                              itemBuilder: (context, index) {
                                return _buildClientListItem(
                                    _filteredClients[index]);
                              },
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddClientScreen()),
          ).then((_) {
            _fetchClients();
          });
        },
        backgroundColor: const Color(0XFF094497),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: _filterClients,
      decoration: InputDecoration(
        hintText: "Search Clients...",
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
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

  Widget _buildClientListItem(ClientModel client) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClientDetailsScreen(clientId: client.id!),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  radius: 20,
                  child: Text(
                    client.name != null && client.name!.isNotEmpty
                        ? client.name![0].toUpperCase()
                        : "?",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        client.name ?? "Unknown",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (client.companyName != null &&
                          client.companyName!.isNotEmpty)
                        Text(
                          client.companyName!,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchDialer(client.contact);
                  },
                  child: const Icon(Icons.call, color: Colors.black, size: 24),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void _launchDialer(String? phoneNumber) async {
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final Uri url = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        log("Could not launch dialer");
      }
    }
  }
}

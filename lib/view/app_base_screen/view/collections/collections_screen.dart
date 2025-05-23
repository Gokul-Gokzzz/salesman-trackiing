import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/collections/collection_controller.dart';
import 'package:salesman/model/collection_model.dart';
import 'package:salesman/view/app_base_screen/view/collections/add_collection_screen.dart';
import 'package:salesman/view/app_base_screen/view/collections/collection_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  // final String salesmanId = "123"; // Replace with actual salesman ID

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchCollections();
    });
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchText = _searchController.text;
    });
  }

  Future<void> _fetchCollections() async {
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId =
        prefs.getString('id'); // Retrieve ID from SharedPreferences

    if (salesmanId == null || salesmanId.isEmpty) {
      log("❌ Salesman ID is null or empty!");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Salesman ID not found")),
      );
      return;
    }

    log("✅ Salesman ID: $salesmanId");

    // Fetch collections using Provider
    Provider.of<CollectionProvider>(context, listen: false)
        .getCollections(salesmanId);
  }

  List<GetCollection> _filterCollections(List<GetCollection> notes) {
    if (_searchText.isEmpty) {
      return notes;
    }
    return notes
        .where((collection) =>
            (collection.clientName
                    ?.toLowerCase()
                    .contains(_searchText.toLowerCase()) ??
                false) ||
            (collection.amount
                    ?.toString()
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()) ??
                false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: RefreshIndicator(
        onRefresh: _fetchCollections,
        child: Column(
          children: [
            Stack(
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
                      image: AssetImage("assets/images/collection_bg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Collections",
                      style: TextStyle(
                        fontSize: 35,
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
              child: Consumer<CollectionProvider>(
                builder: (context, collectionProvider, child) {
                  List<GetCollection> filteredCollections =
                      _filterCollections(collectionProvider.collections);
                  if (collectionProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final collections = collectionProvider.collections;
                  double totalCollected = collections.fold(
                      0, (sum, item) => sum + (item.amount ?? 0));

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Collection Summary",
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
                        const SizedBox(height: 30),
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search Collections',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        if (filteredCollections.isNotEmpty) ...[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 18),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Total Collected: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Color(0XFF094497),
                                        ),
                                      ),
                                      Text(
                                        "₹${totalCollected.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(),
                                for (var i = 0;
                                    i < filteredCollections.length;
                                    i++) ...[
                                  GestureDetector(
                                    onTap: () async {
                                      final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CollectionDetailsScreen(
                                                      collectionId:
                                                          filteredCollections[i]
                                                              .id)));
                                      if (result == true) {
                                        setState(() {
                                          _fetchCollections(); // Refresh the collections when returning
                                        });
                                      }
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Client",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: Color(0XFF094497)),
                                                ),
                                                Text(
                                                  collections[i]
                                                      .clientName
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Amount",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: Color(0XFF094497)),
                                                ),
                                                Text(
                                                  "₹${filteredCollections[i].amount}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Date",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: Color(0XFF094497)),
                                                ),
                                                Text(
                                                  collections[i]
                                                          .date
                                                          ?.toLocal()
                                                          .toString()
                                                          .split(" ")[0] ??
                                                      "N/A",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ] else ...[
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Text(
                                "No collections found.",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                        Center(
                          child: SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddCollectionScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0XFF094497),
                                elevation: 0,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Add Collection",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.14),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.add,
                                      color: Colors.white, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/collection_details_controller.dart';
import 'package:salesman/model/collection_details_model.dart';
import 'package:intl/intl.dart';

class CollectionDetailsScreen extends StatefulWidget {
  final String collectionId;

  const CollectionDetailsScreen({super.key, required this.collectionId});

  @override
  State<CollectionDetailsScreen> createState() =>
      _CollectionDetailsScreenState();
}

class _CollectionDetailsScreenState extends State<CollectionDetailsScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CollectionDetailsProvider>(context, listen: false)
          .getCollectionDetails(widget.collectionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Consumer<CollectionDetailsProvider>(
        builder: (context, provider, child) {
          return Column(
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
                        "Collection Details",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 15,
                    child: InkWell(
                      onTap: () => Navigator.pop(context, true),
                      child: SvgPicture.asset(
                        "assets/images/backbutton.svg",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: provider.collection == null
                            ? const Center(
                                child: Text(
                                  "No data available",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Collection Information",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
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
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _buildDetailRow("Client",
                                              provider.collection!.client.name),
                                          _buildDetailRow("Amount",
                                              "₹${provider.collection!.amount}"),
                                          _buildDetailRow(
                                              "Date",
                                              provider.collection!.date
                                                      ?.toLocal()
                                                      .toString()
                                                      .split(" ")[0] ??
                                                  "N/A"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            _showEditDialog(provider),
                                        child: const Text("Edit"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            _confirmDelete(provider),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        child: const Text("Delete",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDelete(CollectionDetailsProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Collection"),
          content: const Text(
            "If the client has Outstanding due the delete is not possible⚠🚫",
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await provider.deleteCollection(
                    provider.collection!.id, context);
                Navigator.pop(context); // Close dialog
                Navigator.pop(context, true); // Pop back with result
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final shouldRefresh = ModalRoute.of(context)?.settings.arguments as bool?;
    if (shouldRefresh == true) {
      Provider.of<CollectionDetailsProvider>(context, listen: false)
          .getCollectionDetails(widget.collectionId);
    }
  }

  // void _confirmDelete(CollectionDetailsProvider provider) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text("Delete Collection"),
  //         content:
  //             const Text("Are you sure you want to delete this collection?"),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               provider.deleteCollection(provider.collection!.id, context);
  //             },
  //             style: TextButton.styleFrom(foregroundColor: Colors.red),
  //             child: const Text("Delete"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showEditDialog(CollectionDetailsProvider provider) {
    amountController.text = provider.collection!.amount.toString();
    dateController.text =
        provider.collection!.date?.toLocal().toString().split(" ")[0] ?? "";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Wrap(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Edit Collection Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Amount"),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: "Date"),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        dateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await provider.updateCollection(
                            widget.collectionId,
                            {
                              "client": provider.collection!.client.id,
                              "salesman": provider.collection!.salesman,
                              "amount": amountController.text,
                              "date": dateController.text,
                            },
                          );
                          Navigator.pop(context);
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0XFF094497),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

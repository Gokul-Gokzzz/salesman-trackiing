import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/collection_controller.dart';
import 'package:salesman/view/app_base_screen/view/add_collection_screen.dart';

class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CollectionProvider>(context, listen: false)
          .fetchCollections();
    });
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
                height: 318,
                width: double.maxFinite,
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Collection Summary ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: const Color(0XFFFFFFFF),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Consumer<CollectionProvider>(
                        builder: (context, collectionProvider, child) {
                          if (collectionProvider.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (collectionProvider.collectionModel == null ||
                              collectionProvider.collectionModel!.collections ==
                                  null) {
                            return const Center(
                                child: Text("No collections found."));
                          }

                          final collections =
                              collectionProvider.collectionModel!.collections!;

                          double totalCollected = collections.fold(
                              0, (sum, item) => sum + item.amount!);

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 18),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
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
                                  ],
                                ),
                              ),
                              const Divider(),
                              for (var collection in collections)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 8),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      Row(
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
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10,
                                                    color: Color(0XFF094497)),
                                              ),
                                              Text(
                                                collection.client.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10),
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
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10,
                                                    color: Color(0XFF094497)),
                                              ),
                                              Text(
                                                "₹${collection.amount}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Date:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10,
                                                    color: Color(0XFF094497)),
                                              ),
                                              Text(
                                                "${collection.date?.toLocal().toString().split(" ")[0] ?? "N/A"}, ${collection.date?.toLocal().toString().split(" ")[1].split(".")[0] ?? "N/A"}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/lucide_edit.svg',
                                                height: 19,
                                                width: 19,
                                              ),
                                              const SizedBox(width: 10),
                                              SvgPicture.asset(
                                                'assets/images/material-symbols_delete-outline.svg',
                                                height: 22,
                                                width: 22,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 20)
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddCollectionScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF094497),
                              elevation: 0),
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
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          )),
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

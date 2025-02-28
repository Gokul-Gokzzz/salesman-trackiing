import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/take_order_provider.dart';

class TakeOrderScreen extends StatefulWidget {
  const TakeOrderScreen({super.key});

  @override
  State<TakeOrderScreen> createState() => _TakeOrderScreenState();
}

class _TakeOrderScreenState extends State<TakeOrderScreen> {
  String? selectedValue = 'Option 1';
  @override
  final List<Map<String, dynamic>> foodItems = [
    {
      "image": "assets/images/friedrice.png",
      "name": "Fried Rice",
      "restaurant": "Pista House",
      "user": "User 1",
      "price": "₹100",
      "quantity": 1,
    },
    {
      "image": "assets/images/friedrice.png",
      "name": "Fried Rice",
      "restaurant": "Pista House",
      "user": "User 2",
      "price": "₹100",
      "quantity": 1,
    },
    {
      "image": "assets/images/friedrice.png",
      "name": "Fried Rice",
      "restaurant": "Pista House",
      "user": "User 3",
      "price": "₹100",
      "quantity": 1,
    },
  ];

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
                    image: AssetImage("assets/images/takeorder_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "",
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
                  children: [
                    // Container(
                    //   color: Colors.red,
                    //   height: 44,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       border: Border.all(
                    //         color: const Color(0XFF094497),
                    //       ),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //       child: DropdownButton<String>(
                    //         value:
                    //             selectedValue, // The currently selected value
                    //         onChanged: (String? newValue) {
                    //           setState(() {
                    //             selectedValue = newValue!;
                    //           });
                    //         },
                    //         isExpanded: true,
                    //         underline:
                    //             Container(), // Remove the default underline
                    //         items: <String>['Option 1', 'Option 2', 'Option 3']
                    //             .map<DropdownMenuItem<String>>((String value) {
                    //           return DropdownMenuItem<String>(
                    //             value: value,
                    //             child: Text(
                    //               value,
                    //               style: const TextStyle(
                    //                   fontSize: 10,
                    //                   fontWeight: FontWeight.bold),
                    //             ),
                    //           );
                    //         }).toList(),
                    //         hint: const Text(
                    //           'Select an option',
                    //           style: TextStyle(
                    //               fontSize: 10, fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xffF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0XFF094497),
                          ),
                        ),
                        child: const SearchBar(
                          elevation: WidgetStatePropertyAll(0),
                          leading: Icon(Icons.search),
                          hintText: "Search",
                          backgroundColor:
                              WidgetStatePropertyAll(Color(0xffF2F2F2)),
                        )),
                    const SizedBox(
                      height: 36,
                    ),
                    Consumer<FoodProvider>(
                      builder: (context, foodProvider, child) {
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(10),
                          itemCount: foodProvider.foodItems.length,
                          itemBuilder: (context, index) {
                            final item = foodProvider.foodItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(item["image"]),
                                          width: 80.99,
                                          height: 66.87,
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item["name"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.83,
                                              ),
                                            ),
                                            Text(
                                              item["restaurant"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                              ),
                                            ),
                                            Text(
                                              item["user"],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12.83,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/deleteshadow.svg"),
                                        Container(
                                          width: 76.61,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0XFFEA6435)),
                                            borderRadius:
                                                BorderRadius.circular(18.33),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () => foodProvider
                                                    .decrementQuantity(index),
                                                child: const Text(
                                                  "-",
                                                  style: TextStyle(
                                                    fontSize: 19.25,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0XFFEA6435),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${item["quantity"]}",
                                                style: const TextStyle(
                                                  fontSize: 19.25,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0XFFEA6435),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () => foodProvider
                                                    .incrementQuantity(index),
                                                child: const Text(
                                                  "+",
                                                  style: TextStyle(
                                                    fontSize: 19.25,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0XFFEA6435),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          item["price"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12.83,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: const Color(0XFFFFFFFF),
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.1), // Shadow color with opacity
                            blurRadius: 7, // Blur radius
                            offset:
                                const Offset(0, 3), // Offset for shadow (x, y)
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 18,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "225",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Delivery",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "₹45",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "₹270",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: 262,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF094497),
                              elevation: 0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  width: 1,
                                ),
                                const Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w500),
                                ),
                                SvgPicture.asset(
                                    "assets/images/forward_arrow.svg"),
                              ],
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
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

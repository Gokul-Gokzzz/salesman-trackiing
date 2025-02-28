import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RedeemedRewards extends StatelessWidget {
  const RedeemedRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 263,
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                        image: DecorationImage(
                            image: AssetImage("assets/images/rewards.png"),
                            fit: BoxFit.fill)),
                    child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Redeemed Rewards History",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFFFFFFF)),
                          ),
                        )),
                  ),
                  Positioned(
                      top: 40,
                      left: 15,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                          SvgPicture.asset("assets/images/backbutton.svg")))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Redeemed Rewards",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 3,
                      width: 59,
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
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            offset: Offset(0, 4),
                            blurRadius: 14,
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Reward Name:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "₹500 Voucher",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "15-Dec-2024",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Status:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "Approved",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: const Color(0XFFFFFFFF),
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            offset: Offset(0, 4),
                            blurRadius: 14,
                          ),
                        ],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Reward Name:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "Headphones",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "05-Nov-2024",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Status:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "Pending",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}

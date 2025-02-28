import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/view/app_base_screen/view/redeemed_rewards.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
                      child: Text(
                    "Rewards",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFFFFFFFF)),
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
                    "Available Rewards ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Points Required:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF094497)),
                                ),
                                Text(
                                  "2000 pts",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          const Divider(),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0XFF094497)),
                              onPressed: () {},
                              child: const Text(
                                "Redeem",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              )),
                          const SizedBox(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Points Required:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF094497)),
                                ),
                                Text(
                                  "2000 pts",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          const Divider(),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: const Color(0XFF094497)),
                              onPressed: () {},
                              child: const Text(
                                "Redeem",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              )),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Points:",
                  style: TextStyle(
                      color: Color(0XFF094497),
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                Text(
                  " 1900",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 19,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: const Color(0XFF094497)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RedeemedRewards()),
                  );
                },
                child: const Text(
                  "View Redeemed Rewards",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

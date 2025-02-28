import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/view/app_base_screen/view/reward_screen.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
          forceMaterialTransparency: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SvgPicture.asset(
                "assets/images/notification.svg",
                height: 33,
                width: 33,
              ),
            )
          ],
          title: const SizedBox(
              width: 63,
              height: 57,
              child: Image(
                  image: AssetImage("assets/images/tracking_plane.png")))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Leaderboard",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Container(
                height: 3,
                width: 79,
                decoration: BoxDecoration(
                    color: const Color(0XFF094497),
                    borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Container(
                          height: 99,
                          decoration: BoxDecoration(
                              color: const Color(0XFFE7F1FF),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0XFF5EA1FF))),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  image:
                                      AssetImage('assets/images/ranking.png')),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Rank:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    " 3",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 99,
                          decoration: BoxDecoration(
                              color: const Color(0XFFE7F1FF),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: const Color(0XFF5EA1FF))),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                  image:
                                      AssetImage('assets/images/points.png')),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Points:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "2000 pts ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 208,
                      decoration: BoxDecoration(
                          color: const Color(0XFFC8DFFF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0XFF6BA8FF))),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/user.png'),
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Name:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0XFF094497)),
                                ),
                                Text(
                                  "  James",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 42,
              ),
              const Text(
                "Overview",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Container(
                height: 3,
                width: 59,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 97, 155, 236),
                    borderRadius: BorderRadius.circular(20)),
              ),
              const SizedBox(
                height: 26.5,
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
                        padding:
                            EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "John Doe",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF094497)),
                            ),
                            Text(
                              "2500 pts",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jane Smith",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF094497)),
                            ),
                            Text(
                              "2300 pts",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mark Taylor",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF094497)),
                            ),
                            Text(
                              "2100 pts",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
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
              const Row(
                children: [
                  Text(
                    "Your Position:",
                    style: TextStyle(
                        color: Color(0XFF094497),
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Text(
                    "Rank #5 ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "Points:",
                    style: TextStyle(
                        color: Color(0XFF094497),
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Text(
                    "1900",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: const Color(0XFF094497)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RewardsScreen()),
                    );
                  },
                  child: const Text(
                    "View Rewards",
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}

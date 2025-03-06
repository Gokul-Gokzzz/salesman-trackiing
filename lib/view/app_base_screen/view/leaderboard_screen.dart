import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/leader_board_controller.dart';
import 'package:salesman/model/leader_board_model.dart';
import 'package:salesman/view/app_base_screen/view/reward_screen.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LeaderboardController()..fetchLeaderboardData(),
      child: Scaffold(
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
        body: Consumer<LeaderboardController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.leaderboard == null ||
                controller.leaderboard!.leaderboard!.isEmpty) {
              return const Center(child: Text("No data available"));
            }

            final userRank = 5; // Example rank, replace with actual data
            final userPoints = 1900; // Example points, replace with actual data

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                  // Leaderboard Header (Rank, Points, Name)
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
                                  border: Border.all(
                                      color: const Color(0XFF5EA1FF))),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      image: AssetImage(
                                          'assets/images/ranking.png')),
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
                                  border: Border.all(
                                      color: const Color(0XFF5EA1FF))),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      image: AssetImage(
                                          'assets/images/points.png')),
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
                              border:
                                  Border.all(color: const Color(0XFF6BA8FF))),
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
                  const SizedBox(height: 20),

                  // Overview Title
                  const Text(
                    "Overview",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
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
                  // Leaderboard List
                  SizedBox(
                    height: 200,
                    width: 500,
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.leaderboard!.leaderboard!
                            .length, // Display top 3 users
                        itemBuilder: (context, index) {
                          Leaderboard user =
                              controller.leaderboard!.leaderboard![index];

                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    user.name ?? "Unknown",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF094497),
                                    ),
                                  ),
                                  trailing: Text(
                                    "${user.points ?? 0} pts",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                  height: 1,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // User Position and Points
                  RichText(
                    text: TextSpan(
                      text: "Your Position: ",
                      style: const TextStyle(
                          fontSize: 18, color: Color(0XFF094497)),
                      children: [
                        TextSpan(
                          text: "Rank #$userRank",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Points: ",
                      style: const TextStyle(
                          fontSize: 18, color: Color(0XFF094497)),
                      children: [
                        TextSpan(
                          text: "$userPoints",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // View Rewards Button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0XFF094497)),
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Info Card (Rank & Points)
  // Widget _infoCard(String text, String iconPath) {
  //   return Expanded(
  //     child: Container(
  //       padding: const EdgeInsets.all(12),
  //       margin: const EdgeInsets.symmetric(horizontal: 4),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(color: Colors.blue, width: 1.5),
  //       ),
  //       child: Column(
  //         children: [
  //           SvgPicture.asset(iconPath, height: 30),
  //           const SizedBox(height: 5),
  //           Text(
  //             text,
  //             textAlign: TextAlign.center,
  //             style: const TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 14,
  //                 color: Colors.black),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Profile Card
  Widget _profileCard(String name) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue, width: 1.5),
        ),
        child: Column(
          children: [
            const Icon(Icons.person, size: 40, color: Colors.black),
            const SizedBox(height: 5),
            Text(
              "Name: $name",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

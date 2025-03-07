import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/redeme_request_controller.dart';
import 'package:salesman/controller/reward_controller.dart';
import 'package:salesman/model/reward_model.dart';
import 'package:salesman/view/app_base_screen/view/redeemed_rewards.dart';
import 'package:salesman/view/app_base_screen/view/rewaed_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardProvider = Provider.of<RewardProvider>(context);

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
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/rewards.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Rewards",
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
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset("assets/images/backbutton.svg"),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Available Rewards",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 3,
                    width: 59,
                    decoration: BoxDecoration(
                      color: const Color(0XFF094497),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 30.75),
                  rewardProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: rewardProvider.rewards.map((reward) {
                            return RewardCard(reward: reward);
                          }).toList(),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Total Points:",
                  style: TextStyle(
                    color: Color(0XFF094497),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                // Text(
                //   " ${rewardProvider.rewards.isNotEmpty ? rewardProvider.rewards.first.userPoints : 0}",
                //   style: const TextStyle(
                //       fontWeight: FontWeight.w600, fontSize: 18),
                // ),
              ],
            ),
            const SizedBox(height: 19),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0XFF094497),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RedeemedRewards(),
                  ),
                );
              },
              child: const Text(
                "View Redeemed Rewards",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final Reward reward;
  const RewardCard({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RewardDetailsScreen(rewardId: reward),
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 20),
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
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Reward Name:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF094497),
                      ),
                    ),
                    Text(
                      reward.rewardName.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Points Required:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF094497),
                      ),
                    ),
                    Text(
                      "${reward.pointsRequired} pts",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const Divider(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0XFF094497),
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  String? userId =
                      prefs.getString('id'); // Fetch userId (Salesman ID)

                  if (userId == null || userId.isEmpty) {
                    log("❌ User ID is null or empty!");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("User ID not found")),
                    );
                    return;
                  }

                  log("✅ User ID: $userId");

                  final provider =
                      Provider.of<RedemptionProvider>(context, listen: false);
                  provider.redeemReward(userId,
                      reward.id.toString()); // Reward ID is hardcoded for now
                },
                child: const Text(
                  "Redeem",
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

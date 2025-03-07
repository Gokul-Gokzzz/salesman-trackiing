import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/reward_history_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RedeemedRewards extends StatefulWidget {
  const RedeemedRewards({
    super.key,
  });

  @override
  State<RedeemedRewards> createState() => _RedeemedRewardsState();
}

class _RedeemedRewardsState extends State<RedeemedRewards> {
  @override
  void initState() {
    super.initState();
    _initializeRewardHistory();
  }

  Future<void> _initializeRewardHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId =
        prefs.getString('id'); // Retrieve ID from SharedPreferences

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
      Provider.of<RewardHistoryProvider>(context, listen: false)
          .fetchRewardHistory(salesmanId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Consumer<RewardHistoryProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
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
                            child: SvgPicture.asset(
                                "assets/images/backbutton.svg")))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Redeemed Rewards",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 3,
                        width: 59,
                        decoration: BoxDecoration(
                            color: const Color(0XFF094497),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      const SizedBox(height: 30.75),
                      provider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : provider.rewardHistory.isEmpty
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      "No rewards found!",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                )
                              : Column(
                                  children:
                                      provider.rewardHistory.map((reward) {
                                    return RewardCard(
                                      rewardName: reward.reward.rewardName,
                                      // date: reward.reward.,
                                      status: reward.status,
                                    );
                                  }).toList(),
                                ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final String rewardName;
  // final String date;
  final String status;

  const RewardCard({
    super.key,
    required this.rewardName,
    // required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            _buildInfoRow("Reward Name:", rewardName),
            // const Divider(),
            // _buildInfoRow("Date:", date),
            const Divider(),
            _buildInfoRow("Status:", status),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0XFF094497)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

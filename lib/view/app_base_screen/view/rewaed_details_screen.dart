import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesman/model/reward_model.dart';

class RewardDetailsScreen extends StatelessWidget {
  final Reward rewardId;

  const RewardDetailsScreen({super.key, required this.rewardId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      // appBar: AppBar(
      //   title: const Text("Reward Details"),
      //   backgroundColor: const Color(0XFF094497),
      //   foregroundColor: Colors.white,
      // ),
      body: Column(
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rewardId.rewardName.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF094497),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Points Required: ${rewardId.pointsRequired} pts",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Quantity Available: ${rewardId.quantityAvailable} ",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // Text(
                      //   rewardId.description ?? "No description available",
                      //   style: const TextStyle(fontSize: 14),
                      // ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0XFF094497),
                          ),
                          onPressed: () {
                            // TODO: Implement reward redemption logic
                          },
                          child: const Text(
                            "Redeem Reward",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

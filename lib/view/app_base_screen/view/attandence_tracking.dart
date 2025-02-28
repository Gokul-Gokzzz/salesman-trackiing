import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AttendanceTracking extends StatelessWidget {
  const AttendanceTracking({super.key});

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
                  height: 318,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/AttendanceTracking_bg .png"),
                          fit: BoxFit.fill)),
                  child: const Center(
                      child: Text(
                    "Attendance Tracking",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFFFFFFFF)),
                  )),
                ),
                Positioned(
                    top: 31,
                    left: 15,
                    child: SvgPicture.asset("assets/images/backbutton.svg"))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Attendance Tracking",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 3,
                    width: 116.02,
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
                        borderRadius: BorderRadius.circular(7)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 14.0, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Check-in Time:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Color(0XFF094497)),
                              ),
                              Text(
                                "21-Dec-2024, 3:00 PM",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 13),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Check-out Time:",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    color: Color(0XFF094497)),
                              ),
                              Text(
                                "21-Dec-2024, 3:00 PM",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 13),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Monthly Summary",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: const Color(0XFFFFFFFF),
                        borderRadius: BorderRadius.circular(7)),
                    child: const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "23-Dec-2024",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Check-in",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "23-Dec-2024",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Check-out",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "24-Dec-2024",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "23-Dec-2024",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Check-in",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "23-Dec-2024",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Check-out",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: Color(0XFF094497)),
                                  ),
                                  Text(
                                    "24-Dec-2024",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

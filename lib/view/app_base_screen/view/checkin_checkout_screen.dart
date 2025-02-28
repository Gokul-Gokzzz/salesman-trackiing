import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/controller/check_in_controller.dart';
import 'package:salesman/main.dart';

class CheckinCheckoutScreen extends StatelessWidget {
  const CheckinCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CheckInController checkInController = CheckInController();
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
          forceMaterialTransparency: false,
          automaticallyImplyLeading: false,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16.22,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/images/backbutton.svg")),
            const SizedBox(
              height: 16.22,
            ),
            const Row(
              children: [
                Text(
                  "Store Name:",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 21,
                      color: Color(0XFF094497)),
                ),
                Text("[Auto-Detected/Select]",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0XFFF2F2F2)),
                      onPressed: () {
                        checkInController.handleCheckIn(
                            context,
                            checkInController
                                .checkInRequestModel.attendance!.salesman
                                .toString(),
                            startLocationUpdates());
                      },
                      child: const Text(
                        "Check In",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0XFF094497)),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0XFF094497)),
                      onPressed: () {},
                      child: const Text(
                        "Check Out",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: const Color(0XFFFFFFFF),
                  border: Border.all(color: const Color(0XFFD2D2D2)),
                  borderRadius: BorderRadius.circular(5)),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Check-in/Check-out Details",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Last Check-in: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0XFF094497)),
                        ),
                        Text("9:00 AM",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          "Last Check-out: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0XFF094497)),
                        ),
                        Text("12:00 PM",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

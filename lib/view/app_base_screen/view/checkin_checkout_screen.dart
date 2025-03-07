import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/attendence_controller.dart';
import 'package:salesman/controller/auth_conroller.dart';
import 'package:salesman/controller/check_in_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckinCheckoutScreen extends StatefulWidget {
  const CheckinCheckoutScreen({super.key});

  @override
  State<CheckinCheckoutScreen> createState() => _CheckinCheckoutScreenState();
}

class _CheckinCheckoutScreenState extends State<CheckinCheckoutScreen> {
  final CheckInController checkInController = CheckInController();

  Future<String> _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return "${position.latitude}, ${position.longitude}";
  }

  // void _handleCheckIn() async {
  //   final authProvider = Provider.of<AuthProvider>(context, listen: false);
  //   // String location = await _getLocation();
  //   String? salesmanId =
  //       authProvider.loginModel?.user?.id; // Replace with actual salesman ID
  //   // if (salesmanId == null) {
  //   //   log("❌ Salesman ID not found in AuthProvider!");
  //   //   ScaffoldMessenger.of(context)
  //   //       .showSnackBar(const SnackBar(content: Text("Salesman ID not found")));
  //   //   return;
  //   // }

  //   // log("✅ Check-in initiated for Salesman ID: $salesmanId");
  //   String location = await _getLocation();
  //   await checkInController.handleCheckIn(context, salesmanId ?? '', location);
  //   setState(() {
  //     lastCheckIn = DateTime.now().toLocal().toString().split('.')[0];
  //   });
  // }

  void _handleCheckIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId =
        prefs.getString('id'); // Retrieve ID from SharedPreferences

    if (salesmanId == null || salesmanId.isEmpty) {
      log("❌ Salesman ID is null or empty!");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Salesman ID not found")));
      return;
    }

    log("✅ Salesman ID: $salesmanId");
    String location = await _getLocation(); // Fetch location

    await checkInController.handleCheckIn(context, salesmanId, location);
    final attProvider =
        Provider.of<AttendanceController>(context, listen: false);

    setState(() {
      attProvider.lastCheckIn =
          DateTime.now().toLocal().toString().split('.')[0];
    });
  }

  void _handleCheckOut() async {
    final Logger _logger = Logger();

    // Ensure there is a stored attendance ID
    if (checkInController.lastAttendanceId == null) {
      _logger.e("❌ No attendance record found for checkout.");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No valid check-in record found!")));
      return;
    }

    await checkInController.handleCheckOut(context);
    final attProvider =
        Provider.of<AttendanceController>(context, listen: false);

    // Store check-out timestamp
    setState(() {
      attProvider.lastCheckOut =
          DateTime.now().toLocal().toString().split('.')[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final attProvider =
        Provider.of<AttendanceController>(context, listen: false);
    attProvider.getAttendance();
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
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
            const SizedBox(height: 16.22),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset("assets/images/backbutton.svg"),
            ),
            const SizedBox(height: 16.22),
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
            const SizedBox(height: 40),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: const Color(0XFFF2F2F2)),
                    onPressed: () {
                      _handleCheckIn();
                    },
                    child: const Text(
                      "Check In",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0XFF094497),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: const Color(0XFF094497)),
                    onPressed: _handleCheckOut,
                    child: const Text(
                      "Check Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: const Color(0XFFFFFFFF),
                  border: Border.all(color: const Color(0XFFD2D2D2)),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Check-in/Check-out Details",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text(
                          "Last Check-in: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0XFF094497)),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(attProvider.lastCheckIn)),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text(
                          "Last Check-out: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0XFF094497)),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd')
                              .format(DateTime.parse(attProvider.lastCheckOut)),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),
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

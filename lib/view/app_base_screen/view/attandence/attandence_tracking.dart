import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/attandence/attendence_controller.dart';
import 'package:salesman/model/attandence/attendence_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceTracking extends StatefulWidget {
  const AttendanceTracking({super.key});

  @override
  _AttendanceTrackingState createState() => _AttendanceTrackingState();
}

class _AttendanceTrackingState extends State<AttendanceTracking> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAttendanceData();
    });
  }

  Future<void> loadAttendanceData() async {
    final attendanceController =
        Provider.of<AttendanceController>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId = prefs.getString('id');
    if (salesmanId == null || salesmanId.isEmpty) {
      log("❌ Salesman ID is null or empty!");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Salesman ID not found")));
      return;
    }

    log("✅ Salesman ID: $salesmanId");
    // Replace 'yourSalesmanId' with the actual salesman ID you want to fetch
    await attendanceController.getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceController = Provider.of<AttendanceController>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: attendanceController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle(),
                        const SizedBox(height: 30.75),
                        _buildCheckInOut(attendanceController.attendanceData),
                        const SizedBox(height: 20),
                        _buildMonthlySummary(
                            attendanceController.attendanceData),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 318,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            image: DecorationImage(
              image: AssetImage("assets/images/AttendanceTracking_bg .png"),
              fit: BoxFit.fill,
            ),
          ),
          child: const Center(
            child: Text(
              "Attendance Tracking",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Color(0XFFFFFFFF),
              ),
            ),
          ),
        ),
        Positioned(
          top: 31,
          left: 15,
          child: SvgPicture.asset("assets/images/backbutton.svg"),
        )
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
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
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckInOut(AttendenceModel? data) {
    if (data == null || data.records == null || data.records!.isEmpty) {
      return Container(); // Or handle empty data case
    }
    final record =
        data.records!.last; // Assuming you want to display the first record

    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: const Color(0XFFFFFFFF),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 15),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Check-in Time:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0XFF094497),
                  ),
                ),
                Text(
                  record.checkInTime != null
                      ? "${record.checkInTime!.day}-${record.checkInTime!.month}-${record.checkInTime!.year}, ${record.checkInTime!.hour}:${record.checkInTime!.minute}"
                      : "N/A",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            // Added Row for Check-out Time
            Row(
              children: [
                const Text(
                  "Check-out Time:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0XFF094497),
                  ),
                ),
                Text(
                  record.checkOutTime != null
                      ? "${record.checkOutTime!.day}-${record.checkOutTime!.month}-${record.checkOutTime!.year}, ${record.checkOutTime!.hour}:${record.checkOutTime!.minute}"
                      : "N/A",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlySummary(AttendenceModel? data) {
    if (data == null || data.records == null || data.records!.isEmpty) {
      return Container(); // Or handle empty data case
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Monthly Summary",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: const Color(0XFFFFFFFF),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            children: data.records!.map((record) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryColumn("Date",
                            "${record.checkInTime!.day}-${record.checkInTime!.month}-${record.checkInTime!.year}"),
                        _buildSummaryColumn("Check-in",
                            "${record.checkInTime!.day}-${record.checkInTime!.month}-${record.checkInTime!.year}, ${record.checkInTime!.hour}:${record.checkInTime!.minute}"),

                        // _buildSummaryColumn("Check-out",
                        // "${record.checkOutTime!.day}-${record.checkOutTime!.month}-${record.checkOutTime!.year}, ${record.checkOutTime!.hour}:${record.checkOutTime!.minute}"),

                        // Add Check-out logic here if you have it in your data
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Color(0XFF094497),
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
        )
      ],
    );
  }
}

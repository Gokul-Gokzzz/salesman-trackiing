import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/fetch_meeting_controller.dart';
import 'package:salesman/model/meeting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'client_meeting_details.dart';

class ScheduledMeetings extends StatefulWidget {
  const ScheduledMeetings({super.key});

  @override
  State<ScheduledMeetings> createState() => _ScheduledMeetingsState();
}

class _ScheduledMeetingsState extends State<ScheduledMeetings> {
  Future<void> _fetchMeeting() async {
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId = prefs.getString('id');

    if (salesmanId == null || salesmanId.isEmpty) {
      log("❌ Salesman ID is null or empty!");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Salesman ID not found")));
      return;
    }

    log("✅ Salesman ID: $salesmanId");
    await context.read<GetMeetingController>().getMeetings(salesmanId);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMeeting();
    });
  }

  @override
  Widget build(BuildContext context) {
    final meetingController = context.watch<GetMeetingController>();
    final meetings = meetingController.meetings;
    final isLoading = meetingController.isLoading;

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
          // Header Section
          Stack(
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
                    image: AssetImage("assets/images/meeting_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Scheduled Meetings",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

          // Content Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Scheduled Meetings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 3,
                    width: 109.02,
                    decoration: BoxDecoration(
                      color: const Color(0XFF094497),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Meeting List
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : (meetings == null || meetings.isEmpty)
                            ? const Center(
                                child: Text('No meetings scheduled.'))
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: meetings.length,
                                itemBuilder: (context, index) {
                                  GetMeeting meeting = meetings[index];
                                  return MeetingCard(
                                      meeting: meeting, index: index);
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),

          // Add New Meeting Button
          const SizedBox(height: 20),
          SizedBox(
            width: 262,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClientMeetingDetailsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF094497), elevation: 0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Add New Meeting",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 10),
                    SvgPicture.asset("assets/images/forward_arrow.svg"),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Meeting Card Widget
class MeetingCard extends StatelessWidget {
  final GetMeeting meeting;
  final int index;

  const MeetingCard({Key? key, required this.meeting, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Meeting : ${index + 1}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0XFF094497),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "Date: ${meeting.createdAt ?? "N/A"}",
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 14),
              Text(
                "Location: ${meeting.locationType ?? "N/A"}",
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 14),
              Text(
                "Agenda: ${meeting.agenda ?? "N/A"}",
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

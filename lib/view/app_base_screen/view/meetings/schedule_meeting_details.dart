import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/fetch_meeting_controller.dart';

class ScheduledMeetingDetails extends StatefulWidget {
  final String meetingId;
  const ScheduledMeetingDetails({super.key, required this.meetingId});

  @override
  State<ScheduledMeetingDetails> createState() =>
      _ScheduledMeetingDetailsState();
}

class _ScheduledMeetingDetailsState extends State<ScheduledMeetingDetails> {
  late GetMeetingController _meetingDetailsController;

  Future<void> _fetchMeetingDetails() async {
    log("✅ Fetching details for Meeting ID: ${widget.meetingId}");
    await _meetingDetailsController.getMeetingDetails(widget.meetingId);

    // log("🛠 Meeting Details Response: ${_meetingDetailsController.meetingDetails}");
  }

  @override
  void initState() {
    super.initState();
    _meetingDetailsController = context.read<GetMeetingController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchMeetingDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    final meetingDetails = context.watch<GetMeetingController>();
    final isLoading = context.watch<GetMeetingController>().isLoading;

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
                    "Meeting Details",
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
              child:
                  // isLoading
                  //     ? const Center(child: CircularProgressIndicator())
                  //     : meetingDetails == null
                  //         ? const Center(
                  //             child: Text('Meeting details not available.'))
                  //         : ListView(
                  //             padding: EdgeInsets.zero,
                  //             children: [
                  //               //   _buildDetailItem(
                  //               //       "Date",
                  //               //       meetingDetails.meetingDetails!.dateTime
                  //               // .toString()),
                  //               _buildDetailItem("Location",
                  //                   meetingDetails.meetingDetails!.locationDetails),
                  //               _buildDetailItem("Agenda",
                  //                   meetingDetails.meetingDetails!.agenda),
                  //               _buildDetailItem("Participants",
                  //                   meetingDetails.meetingDetails!.locationType),
                  //               _buildDetailItem(
                  //                   "Notes", meetingDetails.meetingDetails!.notes),
                  //             ],
                  //           ),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : meetingDetails == null
                          ? const Center(
                              child: Text('Meeting details not available.'))
                          : ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                _buildDetailItem(
                                    "Location",
                                    meetingDetails
                                        .meetingDetails?.locationDetails),
                                _buildDetailItem("Agenda",
                                    meetingDetails.meetingDetails?.agenda),
                                _buildDetailItem(
                                    "Participants",
                                    meetingDetails
                                        .meetingDetails?.locationType),
                                _buildDetailItem("Notes",
                                    meetingDetails.meetingDetails?.notes),
                              ],
                            ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0XFF094497),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value ?? "N/A",
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}

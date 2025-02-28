import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/meeting_controller.dart'; // Import MeetingController
import 'package:salesman/model/meeting_model.dart'; // Import MeetingModel
import 'client_meeting_details.dart';

class ScheduledMeetings extends StatefulWidget {
  const ScheduledMeetings({super.key});

  @override
  State<ScheduledMeetings> createState() => _ScheduledMeetingsState();
}

class _ScheduledMeetingsState extends State<ScheduledMeetings> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MeetingController>()
          .fetchMeetings(); // Fetch meetings on init
    });
  }

  @override
  Widget build(BuildContext context) {
    final meetingController = context.watch<MeetingController>();
    final meetingModel = meetingController.meetingModel;
    final isLoading = meetingController.isLoading;
    final errorMessage = meetingController.errorMessage;

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Column(
        children: [
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
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 15,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset("assets/images/backbutton.svg"),
                ),
              ),
            ],
          ),
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
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : errorMessage != null
                            ? Center(child: Text(errorMessage))
                            : meetingModel == null ||
                                    meetingModel.meetings == null ||
                                    meetingModel.meetings!.isEmpty
                                ? const Center(
                                    child: Text('No meetings scheduled.'))
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: meetingModel.meetings!.length,
                                    itemBuilder: (context, index) {
                                      Meeting meeting =
                                          meetingModel.meetings![index];
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 14.0),
                                        child: Container(
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color: const Color(0XFFFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14.0, horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Meeting : ${index + 1}",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color:
                                                            Color(0XFF094497),
                                                      ),
                                                    ),
                                                    // const Text(
                                                    //   ":",
                                                    //   style: TextStyle(
                                                    //     fontWeight:
                                                    //         FontWeight.w600,
                                                    //     fontSize: 15,
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                                const SizedBox(height: 14),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Date: ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color:
                                                            Color(0XFF094497),
                                                      ),
                                                    ),
                                                    Text(
                                                      (meeting.date != null
                                                          ? "${meeting.date!.day}-${meeting.date!.month}-${meeting.date!.year}"
                                                          : "Date N/A"),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 14),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Location: ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color:
                                                            Color(0XFF094497),
                                                      ),
                                                    ),
                                                    Text(
                                                      meeting.location ?? "N/A",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 14),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Agenda: ",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color:
                                                            Color(0XFF094497),
                                                      ),
                                                    ),
                                                    Text(
                                                      meeting.agenda ?? "N/A",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 262,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClientMeetingDetails()),
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

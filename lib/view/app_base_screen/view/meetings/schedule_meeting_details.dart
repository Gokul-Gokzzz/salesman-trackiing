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
  }

  Future<void> _deleteMeeting() async {
    bool confirmDelete = await _showDeleteConfirmationDialog();
    if (confirmDelete) {
      await _meetingDetailsController.removeMeeting(widget.meetingId);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<bool> _showDeleteConfirmationDialog() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Confirm Delete"),
            content:
                const Text("Are you sure you want to delete this meeting?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child:
                    const Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _editMeetingDialog() async {
    final meeting = _meetingDetailsController.meetingDetails;
    if (meeting == null) return;

    TextEditingController locationController =
        TextEditingController(text: meeting.locationDetails);
    TextEditingController agendaController =
        TextEditingController(text: meeting.agenda);
    TextEditingController dateController =
        TextEditingController(text: meeting.dateTime.toString());

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Meeting"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: "Location"),
            ),
            TextField(
              controller: agendaController,
              decoration: const InputDecoration(labelText: "Agenda"),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: "Date"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await _meetingDetailsController.updateMeeting(
                widget.meetingId,
                {
                  "locationDetails": locationController.text,
                  "agenda": agendaController.text,
                  "date": dateController.text,
                },
              );
              if (mounted) Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
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
    final isLoading = meetingDetails.isLoading;

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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : meetingDetails.meetingDetails == null
                      ? const Center(
                          child: Text('Meeting details not available.'))
                      : ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            _buildDetailItem("Location Detailes",
                                meetingDetails.meetingDetails?.locationDetails),
                            _buildDetailItem("Agenda",
                                meetingDetails.meetingDetails?.agenda),
                            _buildDetailItem(
                                "Date",
                                meetingDetails.meetingDetails?.dateTime
                                    .toString()),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _editMeetingDialog,
                                  icon: const Icon(Icons.edit,
                                      color: Colors.white),
                                  label: const Text("Edit"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 12),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _deleteMeeting,
                                  icon: const Icon(Icons.delete,
                                      color: Colors.white),
                                  label: const Text("Delete"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 12),
                                  ),
                                ),
                              ],
                            ),
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

import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/add_client_form_controller.dart';
import 'package:salesman/controller/add_client_meeting_details_controller.dart';
import 'package:salesman/controller/client/get_client_controller.dart';
import 'package:salesman/controller/field_staff_controller.dart';
import 'package:salesman/model/add_client_meeting_details_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientMeetingDetailsScreen extends StatefulWidget {
  const ClientMeetingDetailsScreen({super.key});

  @override
  State<ClientMeetingDetailsScreen> createState() =>
      _ClientMeetingDetailsScreenState();
}

class _ClientMeetingDetailsScreenState
    extends State<ClientMeetingDetailsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _locationDetailsController =
      TextEditingController();
  final TextEditingController _agendaController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime? _selectedDateTime;
  DateTime? _followUpReminder;
  File? _selectedFile;

  String? _selectedLocationType;
  String? _selectedFieldStaff;
  String? _selectedRepeatFrequency;

  List<String> clientSuggestions = [];
  bool showSuggestions = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FieldStaffController>(context, listen: false).getFieldStaff();
    });
  }

  final List<String> locationTypes = ['On-Site', 'Virtual'];
  final List<String> repeatFrequencies = ["daily", "weekly", "monthly"];

  void _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _pickFollowUpReminder() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _followUpReminder = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  // void _pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     setState(() {
  //       _selectedFile = File(result.files.single.path!);
  //     });
  //   }
  // }

  void _submitMeeting() async {
    final meetingController =
        Provider.of<AddClientMeetingDetailsController>(context, listen: false);

    if (_titleController.text.isEmpty ||
        _clientController.text.isEmpty ||
        _selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }
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

    AddMeeting newMeeting = AddMeeting(
      salesman: salesmanId,
      title: _titleController.text,
      client: _clientController.text,
      dateTime: _selectedDateTime!,
      locationType: _selectedLocationType ?? '',
      locationDetails: _locationDetailsController.text,
      fieldStaff: _selectedFieldStaff ?? '',
      agenda: _agendaController.text,
      notes: _notesController.text,
      repeatFrequency: _selectedRepeatFrequency ?? '',
      followUpReminder: _followUpReminder,
    );

    bool success = await meetingController.createMeeting(newMeeting, context);

    if (success) {
      Navigator.pop(context); // Pop back if meeting added successfully
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    image: AssetImage("assets/images/collection_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Client Meeting Details",
                    style: TextStyle(
                      fontSize: 35,
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset("assets/images/backbutton.svg"),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                          labelText: "Meeting Title",
                          border: OutlineInputBorder())),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _clientController,
                    decoration: const InputDecoration(
                        labelText: "Client Name", border: OutlineInputBorder()),
                    onChanged: (value) async {
                      final clientProvider =
                          Provider.of<ClientProvider>(context, listen: false);
                      final prefs = await SharedPreferences.getInstance();
                      String? salesmanId = prefs.getString('id');
                      if (salesmanId == null || salesmanId.isEmpty) return;
                      await clientProvider.getClients(salesmanId);

                      setState(() {
                        if (value.isNotEmpty) {
                          clientSuggestions = clientProvider.clients
                              .where((client) => client.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .map((client) => client.name)
                              .toList();
                          showSuggestions = clientSuggestions.isNotEmpty;
                        } else {
                          clientSuggestions.clear();
                          showSuggestions = false;
                        }
                      });
                    },
                  ),
                  if (showSuggestions)
                    Container(
                      height: 100,
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: clientSuggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(clientSuggestions[index]),
                            onTap: () {
                              _clientController.text = clientSuggestions[index];
                              setState(() {
                                clientSuggestions.clear();
                                showSuggestions = false;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: _pickDateTime,
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: _selectedDateTime == null
                              ? "Select Date & Time"
                              : DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(_selectedDateTime!),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField(
                    value: _selectedLocationType,
                    items: locationTypes
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedLocationType = value),
                    decoration: const InputDecoration(
                        labelText: "Location Type",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                      controller: _locationDetailsController,
                      decoration: const InputDecoration(
                          labelText: "Location Details",
                          border: OutlineInputBorder())),
                  const SizedBox(height: 15),
                  const SizedBox(height: 15),
                  Consumer<FieldStaffController>(
                    builder: (context, controller, child) {
                      if (controller.isLoading) {
                        return const CircularProgressIndicator();
                      }

                      return DropdownButtonFormField<String>(
                        value: _selectedFieldStaff,
                        items: controller.staffList
                            .map((staff) => DropdownMenuItem(
                                  value: staff.name,
                                  child: Text(staff.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedFieldStaff = value;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Field Staff",
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  TextField(
                      controller: _agendaController,
                      decoration: const InputDecoration(
                          labelText: "Agenda", border: OutlineInputBorder())),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: "Notes",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField(
                    value: _selectedRepeatFrequency,
                    items: repeatFrequencies
                        .map((freq) =>
                            DropdownMenuItem(value: freq, child: Text(freq)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedRepeatFrequency = value),
                    decoration: const InputDecoration(
                      labelText: "Repeat Frequency",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: _pickFollowUpReminder,
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: _followUpReminder == null
                              ? "Select Follow-up Reminder"
                              : DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(_followUpReminder!),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // ElevatedButton(
                  //   onPressed: _pickFile,
                  //   child: Text(_selectedFile == null
                  //       ? "Upload Attachment"
                  //       : "Attachment: ${_selectedFile!.path.split('/').last}"),
                  // ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _submitMeeting,
                        child: const Text("Submit Meeting")),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

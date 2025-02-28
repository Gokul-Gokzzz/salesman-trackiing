import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClientMeetingDetails extends StatefulWidget {
  const ClientMeetingDetails({super.key});

  @override
  State<ClientMeetingDetails> createState() => _ClientMeetingDetailsState();
}

class _ClientMeetingDetailsState extends State<ClientMeetingDetails> {
  @override
  String? selectedValue = 'Option 1';
  String? selectedMeetingLocation = 'On-site';
  TimeOfDay? selectedTime; // Stores the selected time
  String? selectedOption;

  // Function to open the Time Picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(), // Default to current time
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool isChecked = false;
  bool isReminderChecked = false;
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
                    image: AssetImage("assets/images/expense_bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Client Meeting details",
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: const Color(0XFFFFFFFF),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Enter Meeting title",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30.75,
                    ),
                    const Text(
                      "Client Details",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 3,
                      width: 66.02,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Client Name",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Company Name",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Contact number",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Email address",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: const Color(0XFFFFFFFF),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                const Text(
                                  "Select Date",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: Container(
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0XFF999999)),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      selectedDate != null
                                          ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}" // Show selected date
                                          : "Pick a date",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Select Time",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => _selectTime(context),
                              child: Container(
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0XFF999999)),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  selectedTime != null
                                      ? selectedTime!
                                          .format(context) // Show selected time
                                      : "Pick a time",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: const Color(0XFFFFFFFF),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Location Type",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: const Color(0XFF999999),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: DropdownButton<String>(
                                    value:
                                        selectedMeetingLocation, // The currently selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedMeetingLocation = newValue!;
                                      });
                                    },
                                    isExpanded: true,
                                    underline:
                                        Container(), // Remove the default underline
                                    items: <String>[
                                      'On-site',
                                      'Virtual',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }).toList(),
                                    hint: const Text(
                                      'Select an option',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Address / Meeting Link",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: 8.0,
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Assigned Field Staff:",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 30,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: const Color(0XFF999999),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: DropdownButton<String>(
                                    value:
                                        selectedValue, // The currently selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValue = newValue!;
                                      });
                                    },
                                    isExpanded: true,
                                    underline:
                                        Container(), // Remove the default underline
                                    items: <String>[
                                      'Option 1',
                                      'Option 2',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    }).toList(),
                                    hint: const Text(
                                      'Select an option',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Meeting Agenda:",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 75,
                              child: TextField(
                                maxLines: null,
                                expands: true,
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.top,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                    top:
                                        5.0, // Adjust the vertical padding to start from the top
                                    left:
                                        8.0, // Adjust the horizontal padding to the left
                                    right: 0.0, // Remove padding from the right
                                    bottom: 0.0,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                                scrollPadding: const EdgeInsets.all(10.0),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Notes / Remarks:",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 75,
                              child: TextField(
                                maxLines: null,
                                expands: true,
                                textAlign: TextAlign.left,
                                textAlignVertical: TextAlignVertical.top,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: const BorderSide(
                                      color: Color(0XFF999999),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                    top:
                                        5.0, // Adjust the vertical padding to start from the top
                                    left:
                                        8.0, // Adjust the horizontal padding to the left
                                    right: 0.0, // Remove padding from the right
                                    bottom: 0.0,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                                scrollPadding: const EdgeInsets.all(10.0),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Attach Files ",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                      color: const Color(0XFF999999))),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 22,
                                    width: 91,
                                    decoration: BoxDecoration(
                                        color: const Color(0XFFD9D9D9),
                                        borderRadius: BorderRadius.circular(2)),
                                    child: const Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Choose File",
                                          style: TextStyle(
                                              fontSize: 10.4,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Icon(
                                          Icons.file_upload_outlined,
                                          color: Colors.black,
                                          size: 12,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "No file chosen",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10.14,
                                        color: Color(0XFF6D6D6D)),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                Text("Repeat Meeting"),
                              ],
                            ),
                            if (isChecked) // Show radio buttons when checked
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<String>(
                                        value: "Repeat Weekly",
                                        groupValue: selectedOption,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedOption = value;
                                          });
                                        },
                                      ),
                                      Text("Repeat Weekly"),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Radio<String>(
                                        value: "Monthly",
                                        groupValue: selectedOption,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedOption = value;
                                          });
                                        },
                                      ),
                                      Text("Monthly"),
                                    ],
                                  ),
                                ],
                              ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: isReminderChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isReminderChecked = value!;
                                    });
                                  },
                                ),
                                Text("Follow-Up Reminder"),
                              ],
                            ),
                            if (isReminderChecked) // Show radio buttons when checked
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () => _selectDate(context),
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0XFF999999)),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        selectedDate != null
                                            ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}" // Show selected date
                                            : "Pick a date",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _selectTime(context),
                                    child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0XFF999999)),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        selectedTime != null
                                            ? selectedTime!.format(
                                                context) // Show selected time
                                            : "Pick a time",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            // const SizedBox(
                            //   height: 15,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 120,
                                  height: 38,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0XFF094497)),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 0),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                            color: Color(0XFF094497),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.14),
                                      )),
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0XFF094497),
                                        elevation: 0),
                                    child: const Text(
                                      "Create Meeting",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.14),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

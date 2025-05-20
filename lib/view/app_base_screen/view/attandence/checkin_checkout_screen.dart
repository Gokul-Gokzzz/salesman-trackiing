import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/attandence/attendence_controller.dart';
import 'package:salesman/controller/auth_conroller.dart';
import 'package:salesman/controller/attandence/check_in_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salesman/model/attandence/check_in_model.dart';
import 'package:salesman/service/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckinCheckoutScreen extends StatefulWidget {
  const CheckinCheckoutScreen({super.key});

  @override
  State<CheckinCheckoutScreen> createState() => _CheckinCheckoutScreenState();
}

class _CheckinCheckoutScreenState extends State<CheckinCheckoutScreen> {
  final CheckInCheckOutController _attendanceController =
      CheckInCheckOutController();
  Attendance? _currentAttendance; // Store the current attendance record
  String? _lastCheckIn;
  String? _lastCheckOut;
  File? _image;
  final picker = ImagePicker();
  late SharedPreferences prefs; // Declare prefs as late

  @override
  void initState() {
    super.initState();
    _loadPreferences(); // Load preferences when the state is initialized
  }

  Future<void> _loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastCheckIn = prefs.getString('checkedintime');
      _lastCheckOut = prefs.getString('checkedOutTime');
    });
  }

  Future<String> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      log("❌ Location services are disabled.");
      return "Location Disabled";
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log("❌ Location permissions denied.");
        return "Permission Denied";
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log("❌ Location permissions are permanently denied.");
      return "Permission Denied";
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return "${position.latitude}, ${position.longitude}";
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        log("📷 Image picked from ${source == ImageSource.camera ? 'Camera' : 'Gallery'}: ${_image!.path}");
        log("🖼️ Image type: ${pickedFile.mimeType ?? 'Unknown'}");
      } else {
        log('No image selected.');
      }
    });
  }

  void _handleCheckIn() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (_image != null)
                    Image.file(
                      _image!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    )
                  else
                    const Text('No image selected.'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await getImage(ImageSource.camera);
                          setModalState(
                              () {}); // Rebuild the modal to show the image
                        },
                        child: const Text('Take Photo'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await getImage(ImageSource.gallery);
                          setModalState(
                              () {}); // Rebuild the modal to show the image
                        },
                        child: const Text('Choose from Gallery'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _image != null
                            ? () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                String? salesmanId = prefs.getString('id');

                                if (salesmanId == null || salesmanId.isEmpty) {
                                  log("❌ Salesman ID is null or empty!");
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Salesman ID not found")));
                                  }
                                  return;
                                }

                                log("✅ Salesman ID: $salesmanId");
                                String location = await _getLocation();
                                log("📍 Location: $location");

                                if (_image != null) {
                                  log("📸 Image file path: ${_image!.path}");
                                  // You can try to infer the image type from the extension or just log the path
                                  log("🖼️ Image file extension: ${_image!.path.split('.').last}");
                                } else {
                                  log("⚠️ No image selected for check-in.");
                                }

                                _currentAttendance = await _attendanceController
                                    .checkIn(salesmanId, location, _image!);

                                if (_currentAttendance != null && mounted) {
                                  String? attandanceid = _currentAttendance?.id;
                                  String? checkedinTime =
                                      _currentAttendance?.checkInTime;
                                  log("✅ Check-in successful!");
                                  log("🆔 Attendance ID: $attandanceid");
                                  log("⏰ Checked In Time: $checkedinTime");

                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString(
                                      'attandanceId', attandanceid!);
                                  await prefs.setString(
                                      'checkedintime', checkedinTime!);
                                  String? saveCheckInTime =
                                      prefs.getString('checkedintime');
                                  setState(() {
                                    _lastCheckIn = saveCheckInTime;
                                    _lastCheckOut = null;
                                  });
                                  await prefs.setString('checkedOutTime', "");
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Checked in successfully")));
                                  }
                                } else {
                                  log("❌ Check-in failed.");
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Failed to check in")));
                                  }
                                }
                                Navigator.pop(
                                    context); // Close the bottom sheet
                              }
                            : null,
                        child: const Text('Check In'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _handleCheckOut() async {
    final Logger _logger = Logger();
    final prefs = await SharedPreferences.getInstance();
    String? saveattandanceID = prefs.getString('attandanceId');

    if (saveattandanceID == null) {
      _logger.e("❌ No attendance record found for checkout.");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No valid check-in record found!")));
      }
      return;
    }

    bool checkedOut =
        await _attendanceController.checkOut(saveattandanceID.toString());

    if (checkedOut && mounted) {
      String? checkedOutTime =
          DateTime.now().toLocal().toString().split('.')[0];
      log("✅ Check-out successful!");
      log("⏰ Checked Out Time: $checkedOutTime");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('checkedOutTime', checkedOutTime!);
      String? savedCheckoutTime = prefs.getString('checkedOutTime');
      setState(() {
        _lastCheckOut = savedCheckoutTime;
        _currentAttendance = null; // Clear current attendance
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Checked out successfully")));
    } else {
      log("❌ Check-out failed.");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to check out")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final attendanceController =
        Provider.of<AttendanceController>(context, listen: false);
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
                              fontSize: 17,
                              color: Color(0XFF094497)),
                        ),
                        Text(
                          _lastCheckIn ?? 'N/A', // Display loaded check-in time
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text(
                          "Last Check-out: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Color(0XFF094497)),
                        ),
                        Text(
                          _lastCheckOut ??
                              'N/A', // Display loaded check-out time
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
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

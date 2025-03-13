import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/add_client_form_controller.dart';
import 'package:salesman/controller/add_client_meeting_details_controller.dart';
import 'package:salesman/controller/add_note_controller.dart';
import 'package:salesman/controller/add_order_controller.dart';
import 'package:salesman/controller/attandence/attendence_controller.dart';
import 'package:salesman/controller/auth_conroller.dart';
import 'package:salesman/controller/collections/collection_controller.dart';
import 'package:salesman/controller/collection_details_controller.dart';
import 'package:salesman/controller/dashboard_controller.dart';
import 'package:salesman/controller/expense_controlelr.dart';
import 'package:salesman/controller/expenses_type_controller.dart';
import 'package:salesman/controller/fetch_meeting_controller.dart';
import 'package:salesman/controller/field_staff_controller.dart';
import 'package:salesman/controller/forgot_password_provider.dart';
import 'package:salesman/controller/client/get_client_controller.dart';
import 'package:salesman/controller/leader_board_controller.dart';
import 'package:salesman/controller/meeting_controller.dart';
import 'package:salesman/controller/navigation_controller.dart';
import 'package:salesman/controller/note_controller.dart';
import 'package:salesman/controller/notification_controller.dart';
import 'package:salesman/controller/order_summery_controller.dart';
import 'package:salesman/controller/product_controller.dart';
import 'package:salesman/controller/redeme_request_controller.dart';
import 'package:salesman/controller/reward_controller.dart';
import 'package:salesman/controller/reward_history_controller.dart';
import 'package:salesman/controller/take_order_provider.dart';
import 'package:salesman/service/shared_preference.dart';
import 'package:salesman/view/app_base_screen/view/clients/client_list_screen.dart';
import 'package:salesman/view/app_base_screen/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharedPrefs();
  // Start periodic location fetching
  startLocationUpdates();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginScreenProvider()),
        ChangeNotifierProvider(create: (_) => NavigationController()),
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // ChangeNotifierProvider(create: (_) => MeetingController()),
        ChangeNotifierProvider(create: (_) => NoteController()),
        ChangeNotifierProvider(create: (_) => NoteController()),
        ChangeNotifierProvider(create: (_) => ExpenseController()),
        ChangeNotifierProvider(create: (_) => CollectionProvider()),
        ChangeNotifierProvider(create: (_) => UserMetricsController()),
        ChangeNotifierProvider(create: (context) => AttendanceController()),
        ChangeNotifierProvider(create: (_) => AddClientProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (context) => AddNoteController()),
        ChangeNotifierProvider(create: (context) => FieldStaffController()),
        ChangeNotifierProvider(
            create: (context) => AddClientMeetingDetailsController()),
        ChangeNotifierProvider(create: (context) => GetMeetingController()),
        ChangeNotifierProvider(create: (context) => LeaderboardController()),
        ChangeNotifierProvider(create: (context) => RewardProvider()),
        ChangeNotifierProvider(create: (context) => RedemptionProvider()),
        ChangeNotifierProvider(create: (context) => RewardHistoryProvider()),
        ChangeNotifierProvider(create: (_) => CollectionDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
        ChangeNotifierProvider(create: (_) => OrderSummaryController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
        ChangeNotifierProvider(create: (_) => ExpenseTypeController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

// Function to fetch and log location every 5 seconds
startLocationUpdates() {
  Timer.periodic(const Duration(seconds: 3), (timer) async {
    Position? position = await _fetchCurrentLocation();
    if (position != null) {
      log("Updated Location: ${position.latitude}, ${position.longitude}");
    }
  });
}

// Function to get current location
Future<Position?> _fetchCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    log("Location services are disabled.");
    await Geolocator.openLocationSettings();
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      log("Location permission denied.");
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    log("Location permissions are permanently denied.");
    return null;
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

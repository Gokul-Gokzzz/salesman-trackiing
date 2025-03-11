import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/auth_conroller.dart';
import 'package:salesman/controller/dashboard_controller.dart';
import 'package:salesman/view/app_base_screen/view/clients/add_client_screen.dart';
import 'package:salesman/view/app_base_screen/view/attandence/checkin_checkout_screen.dart';
import 'package:salesman/view/app_base_screen/view/clients/client_list_screen.dart';
import 'package:salesman/view/app_base_screen/view/collections/collections_screen.dart';
import 'package:salesman/view/app_base_screen/view/expenses/expenses_screen.dart';
import 'package:salesman/view/app_base_screen/view/notes/notes_screen.dart';
import 'package:salesman/view/app_base_screen/view/notification/notification_screen.dart';
import 'package:salesman/view/app_base_screen/view/order/product_list_screen.dart';
import 'package:salesman/view/app_base_screen/view/meetings/scheduled_meetings.dart';
import 'package:salesman/view/app_base_screen/view/tabview.dart';
import 'package:salesman/view/app_base_screen/view/order/take_order_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAndSetUserId(context);
      // final authProvider = Provider.of<AuthProvider>(context, listen: false);
      // final metricsController =
      //     Provider.of<UserMetricsController>(context, listen: false).getUserMetrics(userId);

      // if (authProvider.loginModel?.user != null) {
      //   metricsController.getUserMetrics(authProvider.loginModel!.id);
      // }
    });
  }

  Future<void> _fetchAndSetUserId(BuildContext context) async {
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

    // Call getUserMetrics with the retrieved salesmanId
    final metricsController =
        Provider.of<UserMetricsController>(context, listen: false);
    metricsController.getUserMetrics(salesmanId);
  }

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final metricsController = Provider.of<UserMetricsController>(context);
    List heading = [
      "Orders",
      "Meetings",
      "Clients",
      "Expenses",
      "Collections",
      "Notes",
    ];
    // List amount = [
    //   "\$ 0",
    //   "5",
    //   "2",
    //   "\$ 25",
    //   "0",
    //   "lorem",
    // ];
    List<Widget> pages = [
      ProductListScreen(),
      // const TakeOrderScreen(),
      const ScheduledMeetings(),
      const ClientListScreen(),
      const ExpensesScreen(),
      const CollectionsScreen(),
      const NotesScreen(),
    ];
    Future<void> _showLogoutDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // User must tap a button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to logout?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss dialog
                },
              ),
              TextButton(
                child: const Text('Logout'),
                onPressed: () {
                  final authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  authProvider.logout();
                  Navigator.of(context).pop(); // Dismiss dialog
                  Navigator.pushReplacement(
                      // Navigate to login, remove previous routes
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyTabViewInBody()));
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          elevation: 0,
          forceMaterialTransparency: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  String? salesmanId = prefs
                      .getString('id'); // Retrieve ID from SharedPreferences

                  if (salesmanId == null || salesmanId.isEmpty) {
                    log("❌ Salesman ID is null or empty!");
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Salesman ID not found")));
                    return;
                  }

                  log("✅ Salesman ID: $salesmanId");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NotificationScreen(userId: salesmanId),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  "assets/images/notification.svg",
                  height: 33,
                  width: 33,
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  _showLogoutDialog(context);
                },
                icon: Icon(Icons.logout)),
          ],
          title: const SizedBox(
              width: 63,
              height: 57,
              child: Image(
                  image: AssetImage("assets/images/tracking_plane.png")))),
      body: metricsController.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${metricsController.userMetrics?.user.name ?? ''}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFF094497)),
                            ),
                            Text(
                              "${metricsController.userMetrics?.user.email ?? ''}",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0XFF094497)),
                            ),
                          ],
                        ),
                        Spacer(),
                        // CircleAvatar(
                        //   radius: 32.5,
                        //   backgroundImage:
                        //       AssetImage("assets/images/profilephoto.png"),
                        // ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 26,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // IconButton(
                            //     onPressed: () {
                            //       authProvider.logout();
                            //     },
                            //     icon: Icon(Icons.logout)),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0XFFC8DFFF),
                                    border: Border.all(
                                      color: const Color(0XFF5EA1FF),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Metrics Overview",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/images/order.png"),
                                              height: 41,
                                              width: 41,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Orders:${metricsController.userMetrics?.ordersCount ?? 0}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "assets/images/meeting.png"),
                                              height: 41,
                                              width: 41,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Meetings:${metricsController.userMetrics?.meetingsCount ?? 0}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color(0XFFC8DFFF),
                                  border: Border.all(
                                    color: const Color(0XFF5EA1FF),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Collections",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image(
                                      image: AssetImage(
                                          "assets/images/collections.png"),
                                      height: 41,
                                      width: 41,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "₹${metricsController.userMetrics?.collectionsTotalAmount ?? 0}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        const Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            "Quick Actions",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color(0XFFF2F2F2)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CheckinCheckoutScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Check In",
                                    style: TextStyle(color: Colors.black),
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0XFF094497)),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: const Color(0XFF094497)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CheckinCheckoutScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Check Out",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0XFF094497)),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            const Color(0XFF094497)),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ScheduledMeetings()),
                                      );
                                    },
                                    child: const Text(
                                      "View Schedule",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            const Color(0XFFF2F2F2)),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ExpensesScreen()),
                                      );
                                    },
                                    child: const Text(
                                      "Add Expense",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.maxFinite,
                    color: const Color(0XFFFFFFFF),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 22.0, horizontal: 15),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: heading.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => pages[index]),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    width: double.maxFinite,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: const Color(0XFFF1F1F1),
                                        border: Border.all(
                                            color: const Color(0XFFD2D2D2)),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  heading[index],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16),
                                                ),
                                                // Text(
                                                //   amount[index],
                                                //   style: const TextStyle(
                                                //       fontWeight: FontWeight.w600,
                                                //       fontSize: 13),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: double.maxFinite,
                                          width: 1,
                                          color: const Color(0XFFCFCFCF),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: SvgPicture.asset(
                                              "assets/images/add.svg"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

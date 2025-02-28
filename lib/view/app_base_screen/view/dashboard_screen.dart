import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/view/app_base_screen/view/add_client_screen.dart';
import 'package:salesman/view/app_base_screen/view/checkin_checkout_screen.dart';
import 'package:salesman/view/app_base_screen/view/collections_screen.dart';
import 'package:salesman/view/app_base_screen/view/expenses_screen.dart';
import 'package:salesman/view/app_base_screen/view/notes_screen.dart';
import 'package:salesman/view/app_base_screen/view/scheduled_meetings.dart';
import 'package:salesman/view/app_base_screen/view/take_order_screen.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List heading = [
      "Orders",
      "Meetings",
      "Clients",
      "Expenses",
      "Collections",
      "Notes",
    ];
    List amount = [
      "\$ 0",
      "5",
      "2",
      "\$ 25",
      "0",
      "lorem",
    ];
    List<Widget> pages = [
      const TakeOrderScreen(),
      const ScheduledMeetings(),
      const AddClientScreen(),
      const ExpensesScreen(),
      const CollectionsScreen(),
      const NotesScreen(),
    ];
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 15,
            ),
            const Padding(
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
                        "James Anderson",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0XFF094497)),
                      ),
                      Text(
                        "Lorem pesum",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: Color(0XFF094497)),
                      ),
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 32.5,
                    backgroundImage:
                        AssetImage("assets/images/profilephoto.png"),
                  ),
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
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0XFFC8DFFF),
                              border: Border.all(
                                color: const Color(0XFF5EA1FF),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Metrics Overview",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
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
                                        "Orders: 15",
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
                                        "Meetings: 5",
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
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Collections",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Image(
                                image:
                                    AssetImage("assets/images/collections.png"),
                                height: 41,
                                width: 41,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "₹50,000",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                                  backgroundColor: const Color(0XFF094497)),
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
                                  backgroundColor: const Color(0XFFF2F2F2)),
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            amount[index],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13),
                                          ),
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

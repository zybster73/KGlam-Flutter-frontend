import 'dart:async';

import 'package:KGlam/Services/clientApi.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:KGlam/View/CustomWidgets/MySidebar.dart';
import 'package:KGlam/View/owner_side/Appoinments_screen.dart';
import 'package:KGlam/View/owner_side/Homepage_screen.dart';
import 'package:KGlam/View/owner_side/Notification_screen.dart';
import 'package:KGlam/View/owner_side/Reviews_screen.dart';
import 'package:KGlam/View/owner_side/portfolio.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int index = 0;

  int? lastAppointmentid;

  bool hasNewAppointment = false;

  bool hasNewReview = false;

  bool hasNewNotification = false;

  @override
  void initState() {
    super.initState();

    checkNewNotifications();

    // checkNewappointments();
  }

  // Future<void> checkNewappointments() async {
  //   final data = await client_Api().ownerGetAllBookings();
  //   if (!mounted || data == null || data.isEmpty) return;

  //   final lastestId = data.last['id'];
  //   print(lastestId);

  //   if (lastAppointmentid == null) {
  //     lastAppointmentid = lastestId;
  //     print(lastAppointmentid);
  //     return;
  //   }

  //   if (lastestId != lastAppointmentid) {
  //     setState(() {
  //       hasNewAppointment = true;
  //       lastAppointmentid = lastestId;
  //     });
  //   }
  // }

  Future<void> checkNewNotifications() async {
    final data = await client_Api().ownerNotifications();

    if (!mounted || data == null || data.isEmpty) return;

    final hasUnread = data.any((notif) => notif['is_read'] == false);

    if (hasUnread) {
      setState(() {
        hasNewNotification = true;
      });
    } else {
      setState(() {
        hasNewNotification = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomePage(),
      AppointmentScreen(
        onBack: () {
          setState(() {
            index = 0;
          });
        },
      ),
      ReviewsScreen(
        onBack: () {
          setState(() {
            index = 0;
          });
        },
      ),
      NotificationScreen(
        onBack: () {
          setState(() {
            index = 0;
          });
        },
        onMarkAllRead: () {
          setState(() {
            hasNewNotification = false;
          });
        },
      ),
      portfolio(),
    ];

    final items = [
      Icon(
        Icons.home_rounded,
        color: index == 0 ? Colors.black : Colors.black26,
      ),
      Icon(
        Icons.event_note_rounded,
        color: index == 1 ? Colors.black : Colors.black26,
      ),
      Icon(
        Icons.rate_review_outlined,
        color: index == 2 ? Colors.black : Colors.black26,
      ),
      alertIcon(
        Icons.notifications_none_rounded,
        hasNewNotification,
        color: index == 3 ? Colors.black : Colors.black26,
      ),
    ];

    return PopScope(
      canPop: index == 0,
      onPopInvoked: (didPop) {
        if (!didPop && index != 0) {
          setState(() {
            index = 0;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 141, 202, 202),
        extendBody: true,
        drawer: CustomDrawer(),
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          color: Color.fromARGB(255, 167, 226, 226),
          backgroundColor: Colors.transparent,
          items: items,
          height: 60,
          index: index,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: (i) {
            setState(() {
              index = i;
            });

            // Call API when user navigates to index 1
            if (i == 1 || i == 2 || i==0 ) {
              checkNewNotifications();
              print('API called for index 1');
            }
          },
        ),
      ),
    );
  }

  Widget alertIcon(
    IconData icon,
    bool showBadge, {
    Color color = Colors.black,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: color, size: 30),
        if (showBadge) // show badge only when true
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
      ],
    );
  }
}

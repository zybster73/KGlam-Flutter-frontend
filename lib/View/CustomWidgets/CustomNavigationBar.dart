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
      ),
      portfolio(),
    ];

    final items = [
      Icon(
        Icons.home_rounded,
        color: index == 0 ? Colors.black : Colors.black26
      ),
      Icon(
        Icons.event_note_rounded,
        color: index == 1 ? Colors.black  : Colors.black26
      ),
      Icon(
        Icons.rate_review_outlined,
        color: index == 2 ? Colors.black: Colors.black26
      ),
      Icon(
        Icons.notifications_none_rounded,
        color: index == 3 ? Colors.black  : Colors.black26
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
          onTap: (i) => setState(() => index = i),
        ),
      ),
    );
  }
}

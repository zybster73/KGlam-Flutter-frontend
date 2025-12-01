import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:saloon_app/View/CustomWidgets/User_sidebar.dart';
import 'package:saloon_app/View/owner_side/Appoinments_screen.dart';
import 'package:saloon_app/View/owner_side/Homepage_screen.dart';
import 'package:saloon_app/View/owner_side/Notification_screen.dart';
import 'package:saloon_app/View/owner_side/Reviews_screen.dart';
import 'package:saloon_app/View/owner_side/portfolio.dart';
import 'package:saloon_app/View/user_side/User_Notifications.dart';
import 'package:saloon_app/View/user_side/customerHomescreen.dart';
import 'package:saloon_app/View/user_side/user_appointmnets.dart';
import 'package:saloon_app/View/user_side/user_profile.dart';

class Usernavigationbar extends StatefulWidget {
  @override
  State<Usernavigationbar> createState() => _UsernavigationbarState();
}

class _UsernavigationbarState extends State<Usernavigationbar> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      Customerhomescreen(),
      UserAppointmnets(
        onBack: () {
          setState(() {
            index = 0;
          });
        },
      ),
      UserProfile(
        onBack: () {
          setState(() {
            index = 0;
          });
        },
      ),
      UserNotifications(
        onBack: () {
          setState(() {
            index = 0;
          });
        },
      ),
    ];

    final items = [
      Icon(
        Icons.home_rounded,
        color: index == 0 ? Color(0xFF01ABAB) : Color(0xFF717680),
      ),
      Icon(
        Icons.event_note_rounded,
        color: index == 1 ? Color(0xFF01ABAB) : Color(0xFF717680),
      ),
      Icon(
        Icons.person_outline_outlined,
        color: index == 2 ? Color(0xFF01ABAB) : Color(0xFF717680),
      ),
      Icon(
        Icons.notifications_none_rounded,
        color: index == 3 ? Color(0xFF01ABAB) : Color(0xFF717680),
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
        drawer: UserSidebar(),
        backgroundColor: const Color.fromARGB(255, 175, 239, 250),
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
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

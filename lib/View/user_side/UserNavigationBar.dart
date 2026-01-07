import 'package:KGlam/Services/clientApi.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:KGlam/View/CustomWidgets/User_sidebar.dart';
import 'package:KGlam/View/user_side/User_Notifications.dart';
import 'package:KGlam/View/user_side/customerHomescreen.dart';
import 'package:KGlam/View/user_side/user_appointmnets.dart';
import 'package:KGlam/View/user_side/user_profile.dart';

class Usernavigationbar extends StatefulWidget {
  @override
  State<Usernavigationbar> createState() => _UsernavigationbarState();
}

class _UsernavigationbarState extends State<Usernavigationbar> {
  int index = 0;

  bool hasNewNotification = false;

  @override
  void initState() {
    super.initState();

    checkNewNotifications();

    // checkNewappointments();
  }

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
        onMarkAllRead: () {
          setState(() {
            hasNewNotification = false;
          });
        },
      ),
    ];

    final items = [
      Icon(
        Icons.home_rounded,
        color: index == 0 ? Colors.black : Colors.black26
      ),
      Icon(
        Icons.event_note_rounded,
        color: index == 1 ? Colors.black : Colors.black26
      ),
      Icon(
        Icons.person_outline_outlined,
        color: index == 2 ? Colors.black : Colors.black26
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
        drawer: UserSidebar(),
        backgroundColor: const Color.fromARGB(255, 175, 239, 250),
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: CurvedNavigationBar(
          color: Color.fromARGB(255, 141, 202, 202),
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
        if (showBadge)
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

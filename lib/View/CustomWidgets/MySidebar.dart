import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_app/View/Login%20&%20signup/Login_screen.dart';
import 'package:saloon_app/View/owner_side/Appoinments_screen.dart';
import 'package:saloon_app/View/owner_side/Notification_screen.dart';
import 'package:saloon_app/View/owner_side/Profile.dart';
import 'package:saloon_app/View/owner_side/Reviews_screen.dart';
import 'package:saloon_app/View/owner_side/Upload_services.dart';
import 'package:saloon_app/View/owner_side/portfolio.dart';

class CustomDrawer extends StatelessWidget {
  //ustomDrawer({this.logicIndex});
  int loginScreen = 1;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: const Color(0xFF01ABAB),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.28,
              child: Stack(
                //alignment: Alignment.center,
                children: [
                  Positioned(
                    top: -0.05 * screenHeight,
                    left: -10,
                    child: Image.asset(
                      'assets/images/Eclipse.png',
                      height: screenHeight * 0.35,
                      width: screenWidth * 0.9,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    top: screenHeight * 0.05 + 20,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/Logo.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 60.h,
                    right: 20.w,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconSize: 26,
                      color: Colors.white,
                      padding: EdgeInsets.zero,

                      icon: Icon(Icons.close_sharp),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: drawerItem(Icons.home, 'Home'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppointmentScreen(),
                            ),
                          );
                        },
                        child: drawerItem(
                          Icons.event_note_rounded,
                          'Appointment',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewsScreen(),
                            ),
                          );
                        },
                        child: drawerItem(
                          Icons.rate_review_outlined,
                          'Reviews',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => portfolio(),
                            ),
                          );
                        },
                        child: drawerItem(
                          Icons.photo_library_outlined,
                          'Portfolio',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(),
                            ),
                          );
                        },
                        child: drawerItem(
                          Icons.notifications_none_rounded,
                          'Notification',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadServices(),
                            ),
                          );
                        },
                        child: drawerItem(Icons.design_services, 'Services'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: drawerItem(
                          Icons.person_outline_rounded,
                          'Profile',
                        ),
                      ),

                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                logicIndex : loginScreen,
                              ),
                            ),
                            ModalRoute.withName('/'),
                          );
                        },
                        child: drawerItem(Icons.logout, 'Logout'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(width: 16),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:KGlam/Services/auth_Provider.dart';
import 'package:KGlam/Services/storeToken.dart';
import 'package:KGlam/View/CustomWidgets/fluttertoast.dart';
import 'package:KGlam/View/CustomWidgets/helperClass.dart';
import 'package:KGlam/View/owner_side/personalInformation.dart';
import 'package:KGlam/View/selectRole.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:KGlam/View/Login%20&%20signup/Login_screen.dart';
import 'package:KGlam/View/owner_side/Appoinments_screen.dart';
import 'package:KGlam/View/owner_side/Notification_screen.dart';
import 'package:KGlam/View/owner_side/Profile.dart';
import 'package:KGlam/View/owner_side/Reviews_screen.dart';
import 'package:KGlam/View/owner_side/view_services.dart';
import 'package:KGlam/View/owner_side/portfolio.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  //ustomDrawer({this.logicIndex});
  int loginScreen = 1;
  @override
  Widget build(BuildContext context) {
    void showLoading(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>
            Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    Utils.instance.initToast(context);

    final authProvider = Provider.of<AuthProvider>(context);
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
                              builder: (context) => viewServices(),
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Personalinformation(),
                            ),
                          );
                        },
                        child: drawerItem(
                          Icons.info_rounded,
                          'Personal Information',
                        ),
                      ),

                      SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          showLoading(context);

                          try {
                            String? token = await Storetoken.getRefreshToken();

                            final result = await authProvider.logout(token);

                            Navigator.pop(context);

                            await Prefs.setBool(Prefs.loggedIn, false);
                            await Prefs.removeRole();

                            if (result['success'] == true) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectRole(),
                                ),
                                (route) => false,
                              );
                            } else {
                              Utils.instance.toastMessage(
                                'Logout failed. Try again.',
                              );
                            }
                          } catch (e) {
                            Navigator.pop(context); // close loading
                            Utils.instance.toastMessage('Something went wrong');
                          }
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
